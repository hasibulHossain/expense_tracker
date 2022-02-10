import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String weekDay;
  final num spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
      {required this.weekDay,
      required this.spendingAmount,
      required this.spendingPctOfTotal});

  String getShorterVal(int val) {
    if (val > 1000 && val < 1000000) {
      double convertInThousand = val / 1000;
      return '\$${convertInThousand.toInt()}k';
    }
    
    if (val > 1000000 && val < 100000000) {
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
    // print('spending total percantage $spendingPctOfTotal, total: $spendingAmount, weekday $weekDay');
    return Column(
      children: <Widget>[
        Text(
          getShorterVal(spendingAmount.toInt()),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          height: 100,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          weekDay,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
