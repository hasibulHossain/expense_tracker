import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  
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
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: amountController,
            ),
            FlatButton(
              onPressed: () {
                print(
                    'title: ${titleController.text}. amount: ${amountController.text};');
              },
              child: Text('Add Transaction'),
              textColor: Colors.pink,
            ),
          ],
        ),
      ),
    );
  }
}
