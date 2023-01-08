import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function _transactionDeletedCallback;
  const TransactionList(this._transactions, this._transactionDeletedCallback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 5,
            ),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('\$${_transactions[index].amount}'),
                  ),
                ),
              ),
              title: Text(
                _transactions[index].title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                DateFormat.yMMMd().format(_transactions[index].date),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete,
                ),
                onPressed: () =>
                    {_transactionDeletedCallback(_transactions[index].id)},
              ),
            ),
          );
        },
        itemCount: _transactions.length,
      ),
    );
  }
}
