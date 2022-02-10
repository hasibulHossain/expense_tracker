import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final num spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
      {required this.weekDay,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  @override
  Widget build(BuildContext context) {
    // print('spending total percantage $spendingPctOfTotal, total: $spendingAmount, weekday $weekDay');
    return Column(
      children: <Widget>[
        Text('${spendingAmount.toInt()}'),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(19),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(weekDay),
      ],
    );
  }
}
