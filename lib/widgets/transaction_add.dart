import 'package:flutter/material.dart';

class TransactionAdd extends StatefulWidget {
  final Function newTransactionCallback;
  TransactionAdd(this.newTransactionCallback, {super.key});

  @override
  State<TransactionAdd> createState() => _TransactionAddState();
}

class _TransactionAddState extends State<TransactionAdd> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void newTransactionAdded() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount < 0) {
      return;
    }

    widget.newTransactionCallback(
      title,
      amount,
    );

    Navigator.of(context).pop();
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
              controller: titleController,
              onSubmitted: (_) => newTransactionAdded(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              controller: amountController,
              onSubmitted: (_) => newTransactionAdded(),
            ),
            TextButton(
              child: Text('Submit'),
              onPressed: newTransactionAdded,
            )
          ],
        ),
      ),
    );
  }
}
