import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double totalSpentAmount;
  final String weekDayLabel;
  final double percentOfTotalSpending;

  const ChartBar(
      {this.totalSpentAmount, this.weekDayLabel, this.percentOfTotalSpending});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder is used to dynamically set the height and width
    //using the widget constraint in which it is present 'Chart Bar widget' in this case.
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.1,
              child: FittedBox(child: Text(weekDayLabel))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
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
            height: constraints.maxHeight * 0.05,
          ),
          //FittedBox helps to forcefully fit an item withina single line.
          //especially for large text.
          Container(
              //height must be set to horizontally align the bars in same line incase of large numbers
              height: constraints.maxHeight * 0.1,
              child: FittedBox(
                  child: Text(
                "\$${totalSpentAmount.toStringAsFixed(0)}",
              ))),
        ],
      );
    });
  }
}
