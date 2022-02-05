import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Trackers',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Tracker')),
      body: Column(
        children: <Widget>[
          Card(
            child: Container(child: Text('Chart'), width: 100,),
            elevation: 5,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
