import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  String _getShorterVal(int val) { 
    if (val >= 1000 && val < 1000000) {
      double convertInThousand = val / 1000;
      return '\$${convertInThousand.toInt()}k';
    }

    if (val >= 1000000 && val < 100000000) {
      double convertInThousand = val / 1000000;
      return '\$${convertInThousand.toInt()}m';
    }

    if (val > 100000000) {
      double convertInThousand = val / 100000000;
      return '\$${convertInThousand.toInt()}B';
    }
    return '\$${val.toInt()}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                const Text(
                  'No transaction found!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ), // we can use this widget to add empty space;
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            )
          : ListView.builder(itemBuilder: (ctx, index) { // ListView.builder used for large list
                return Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 2,
                  ),
                  child: TransactionItem(key: ValueKey(index), transaction: transactions[index], deleteTransaction: deleteTransaction, getShorterVal: _getShorterVal,)
                );
          }, itemCount: transactions.length,)
    );
  }
}
