import 'package:expense_tracker/widgets/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './new_transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  /// This function will return recent 7 days transaction with sum all transaction of a single day
  List<Map<String, Object>> get getTotalWeekTransactions {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(
        Duration(days: index),
      );

      num totalAmountOnADay = 0;

      for(var element in recentTransactions) {
        if (element.time.day == day.day && element.time.month == day.month) {
          totalAmountOnADay += element.amount;
        }
      }

      return {
        'day': DateFormat.E().format(day).substring(0, 1),
        'amount': totalAmountOnADay,
      };
    }).reversed.toList();
  }

  /// Will calculate whole transaction of a week.
  double get wholeWeekSpendingInTotal {
    return getTotalWeekTransactions.fold(0.0,
        (previousValue, element) => previousValue + (element['amount'] as num));
  }

  /// This function will return ratio of total week transaction and maximum transaction of a single day;
  double getRatioOfTransaction(num singleDayMaximumSpend) {
    if (wholeWeekSpendingInTotal == 0.0) return 0.0;

    return singleDayMaximumSpend / wholeWeekSpendingInTotal;
  }

  @override
  Widget build(BuildContext context) {
    print('whole week $wholeWeekSpendingInTotal');
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: getTotalWeekTransactions.map((element) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  weekDay: (element['day'] as String),
                  spendingAmount: element['amount'] as num,
                  spendingPctOfTotal: getRatioOfTransaction(element['amount'] as num),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
