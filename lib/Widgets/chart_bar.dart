import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalSpentAmount;
  final String weekDayLabel;
  final double percentOfTotalSpending;

  ChartBar(
      {this.totalSpentAmount, this.weekDayLabel, this.percentOfTotalSpending});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(weekDayLabel),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                //the ternary is operation is used to prevent the app from crashing when
                //totalAMountaspent is 0
                heightFactor:
                    totalSpentAmount == 0 ? 0 : percentOfTotalSpending,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        //FittedBox helps to forcefully fit an item withina single line.
        //especially for large text.
        FittedBox(child: Text("\$${totalSpentAmount.toStringAsFixed(0)}"))
      ],
    );
  }
}
