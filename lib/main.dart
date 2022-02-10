// core imports
import 'package:flutter/material.dart';

// third party imports

// local imports
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.pink,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // make transactions private property by adding _
    // Transaction(
    //   id: 't1',
    //   title: 'Vehicle',
    //   amount: 23.9,
    //   time: DateTime.now(),
    // ),
  ];

  void addTransaction({required String title, required num amount}) {
    final tx = Transaction(
      title: title,
      amount: amount,
      time: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _transactions.add(tx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    // showModalBottomSheet is a flutter given function.
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(addTransaction),
    );
  }

  List<Transaction> get _lastSevenDaysTransactions {
    return  _transactions.where((element) => element.time.isAfter(DateTime.now().subtract(const Duration(days: 7)))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Chart(_lastSevenDaysTransactions),
            TransactionList(_transactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
