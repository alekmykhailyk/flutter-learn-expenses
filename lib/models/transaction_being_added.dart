import 'package:flutter/material.dart';
import './transaction.dart';

class TransactionBeingAdded {
  final TextEditingController titleController;
  final TextEditingController amountController;
  final DateTime? date;

  TransactionBeingAdded({
    required this.titleController,
    required this.amountController,
    this.date,
  });

  bool isValid() {
    return isAmountValid() && isTitleValid();
  }

  bool isAmountValid() {
    var lowLimit = 0.0;
    var highLimit = 1000000.0;
    var currentAmount = double.tryParse(amountController.text);
    return currentAmount != null && amount > lowLimit && amount < highLimit;
  }

  bool isTitleValid() {
    return title.isNotEmpty;
  }

  bool isDateValid() {
    return date != null;
  }

  TransactionBeingAdded generateNewItself(DateTime? givenDate) {
    return TransactionBeingAdded(
      titleController: titleController,
      amountController: amountController,
      date: givenDate ?? date,
    );
  }

  Transaction generateNewTransaction() {
    return Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date ?? DateTime.now(),
    );
  }

  double get amount {
    return double.parse(amountController.text);
  }

  String get title {
    return titleController.text;
  }
}
