import 'package:flutter/material.dart';

import './models/transection.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Tracker',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'Vehicle', amount: 23.9, time: DateTime.now()),
    Transaction(id: 't2', title: 'Food', amount: 2.90, time: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: const Card(
              child: Text('Chart'),
              color: Colors.green,
            ),
          ),
          Container(
              width: double.infinity,
              child: Column(
                children: transactions.map((item) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 2,
                    ),
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(right: 15),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.pink.shade200, width: 2),
                                  color: Colors.pink.shade200,
                                ),
                                child: Text(item.amount.toStringAsFixed(2)),
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text(item.title),
                                Text('${item.time}'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }
}
