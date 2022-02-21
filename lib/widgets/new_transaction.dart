import 'dart:io';

import 'package:flutter/cupertino.dart';
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

    Navigator.of(context)
        .pop(); // context is provided automatically to Stateful  widget;
  }

    void _showDatePicker(ctx) {
    // showCupertinoModalPopup is a built-in function of the cupertino library
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              height: 300,
              color: const Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        maximumDate: DateTime.now(),
                        minimumDate: DateTime(2022),
                        onDateTimeChanged: (value) {
                          if (value == null) return;
                          setState(() {
                            _selectedDate = value;
                          });
                        }),
                  ),

                  // Close the modal
                  CupertinoButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.of(ctx).pop(),
                  )
                ],
              ),
            ));
  }

  void _datePicker() {
    if(Platform.isIOS) {
      _showDatePicker(context);
    }

    if(Platform.isAndroid) {
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom +
                  10, // This will take keyboard height along with 10 pixel;
              left: 10),
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
                    Platform.isIOS
                        ? CupertinoButton(
                            child: const Text('Choose Date'),
                            onPressed: _datePicker)
                        : FlatButton(
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
      ),
    );
  }
}
