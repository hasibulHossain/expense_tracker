// core imports
import 'dart:io';

import 'package:flutter/material.dart'; // for android type style
import 'package:flutter/cupertino.dart'; // for ios style
import 'package:flutter/services.dart';

// third party imports

// local imports
import './models/transaction.dart';
import 'widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import 'widgets/chart.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expanse Tracker',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
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

  void addTransaction(
      {required String title, required num amount, required DateTime time}) {
    final tx = Transaction(
      title: title,
      amount: amount,
      time: time,
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

  void deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => id == element.id);
    });
  }

  List<Transaction> get _lastSevenDaysTransactions {
    return _transactions
        .where((element) => element.time
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      title: const Text('Expense Tracker'),
      actions: <Widget>[
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: const Icon(Icons.add),
        ),
      ],
    );

    final Widget screenBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(_lastSevenDaysTransactions),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6, // calculate transaction list height dynamically.
              child: TransactionList(_transactions, deleteTransaction),
            ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('Expense tracker'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(CupertinoIcons.add),
                    onTap: () => _startAddNewTransaction(context),
                  )
                ],
              ),
            ),
            child: screenBody,
          )
        : Scaffold(
            appBar: appBar,
            body: screenBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  )
                : Container(),
          );
  }
}
