import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function deleteTransaction;
  final Function getShorterVal;

  const TransactionItem({Key? key, required this.transaction, required this.deleteTransaction, required this.getShorterVal})
      : super(key: key);

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? bgColor;

  @override
  void initState() {
    // TODO: implement initState
    const bgColors = [Colors.red, Colors.blue, Colors.teal, Colors.amberAccent];
    bgColor = bgColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 15),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: bgColor!,
                    width: 2,
                  ),
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Container(
                  width: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.getShorterVal(widget.transaction.amount.toInt()),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Text(
                    widget.transaction.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  DateFormat.yMMMd().format(widget.transaction.time),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.tight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => widget.deleteTransaction(widget.transaction.id),
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
