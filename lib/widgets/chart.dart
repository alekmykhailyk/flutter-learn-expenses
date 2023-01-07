import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> _recentTransactions;
  const Chart(this._recentTransactions, {super.key});

  @override
  Widget build(BuildContext context) {
    //print(_dayTransactionSum);
    double recentDaysMaxSum = _recentDaysMaxSum;
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _recentDaysSum.entries.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                DateFormat.E().format(e.key),
                e.value,
                recentDaysMaxSum == 0 ? 0 : e.value / recentDaysMaxSum,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Map<DateTime, double> get _recentDaysSum {
    final weekDays = List.generate(7, (index) {
      return DateTime.now().subtract(
        Duration(days: 6 - index),
      );
    });

    return Map<DateTime, double>.fromIterable(
      weekDays,
      key: (item) => item,
      value: (item) {
        var sum = 0.0;

        _recentTransactions.forEach((transaction) {
          if (transaction.isDateMatchedAsWeekDayTo(item)) {
            sum = sum + transaction.amount;
          }
        });

        return sum;
      },
    );
  }

  double get _recentDaysMaxSum {
    return _recentDaysSum.values
        .reduce((value, element) => element > value ? element : value);
  }
}
