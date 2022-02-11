import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function createTransaction;

  NewTransaction(this.createTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    String title = _titleController.text;
    num amount =
        _amountController.text.isEmpty ? 0 : num.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) return;

    widget.createTransaction(
        title: title,
        amount: amount,
        time: _selectedDate); // widget is provided automatically;
        
    Navigator.of(context).pop(); // context is provided automatically to Stateful  widget;
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
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
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
              controller: _amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 20),
              child: Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? 'Not chosen'
                        : DateFormat.yMd().format(_selectedDate as DateTime),
                  ),
                  FlatButton(
                    onPressed: _datePicker,
                    child: const Text('Choose Date'),
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitData,
                  child: const Text('Add Transaction'),
                  color: Colors.pink,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
