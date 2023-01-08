import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:widgets_00/models/transaction_being_added.dart';

class TransactionAdd extends StatefulWidget {
  final Function _transactionAddedCallback;

  TransactionAdd(this._transactionAddedCallback, {super.key});

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  var transactionBeingAdded = TransactionBeingAdded(
    titleController: TextEditingController(),
    amountController: TextEditingController(),
  );

  void newTransactionAdded() {
    if (!transactionBeingAdded.isValid()) {
      return;
    }

    widget._transactionAddedCallback(
        transactionBeingAdded.generateNewTransaction());

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    (showDatePicker(
      context: context,
      initialDate: transactionBeingAdded.date ?? DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    )).then((date) {
      transactionBeingAdded = transactionBeingAdded.generateNewItself(date);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
              controller: transactionBeingAdded.titleController,
              onSubmitted: (_) => newTransactionAdded(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              controller: transactionBeingAdded.amountController,
              onSubmitted: (_) => newTransactionAdded(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      transactionBeingAdded.date == null
                          ? 'No date chosen'
                          : DateFormat.yMMMd()
                              .format(transactionBeingAdded.date as DateTime),
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: presentDatePicker,
                  )
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Submit'),
              onPressed: newTransactionAdded,
            )
          ],
        ),
      ),
    );
  }
}
