import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function createTransaction;

  NewTransaction(this.createTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  submitData() {
    String title = titleController.text;
    num amount = amountController.text.isEmpty ? 0 : num.parse(amountController.text);

    if(title.isEmpty || amount <= 0) return;

    widget.createTransaction(title: title, amount: amount); // widget is provided automatically;
    Navigator.of(context).pop(); // context is provided automatically to Stateful  widget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5),
      child: Card(
        child: Column(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: 'Title',
                labelText: 'Title',
              ),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => submitData(),
            ),
            FlatButton(
              onPressed: submitData,
              child: Text('Add Transaction'),
              textColor: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}
