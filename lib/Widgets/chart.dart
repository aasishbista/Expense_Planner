import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  ///last sev days transactions
  final List<Transaction> recentWeekTransactions;
  Chart(this.recentWeekTransactions);

// groupedTransactionsByWeekDay is a List of Map(i.e. Key Value pair)
//containing days and amount spent in the day.
  List<Map<String, Object>> get groupedTransactionsByWeekDay {
    //weekDay is date and time of each transaction.
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalEachWeekDaySum = 0.0;

// If condition is used to check if the transaction we are looking at
      // in recentWeekTransaction happened today.
      for (var i = 0; i < recentWeekTransactions.length; i++) {
        if (recentWeekTransactions[i].date.day == weekDay.day &&
            recentWeekTransactions[i].date.month == weekDay.month &&
            recentWeekTransactions[i].date.year == weekDay.year) {
          totalEachWeekDaySum += recentWeekTransactions[i].amount;
        }
      }
      print(weekDay);
      print(totalEachWeekDaySum);
      return {
        //DateFormat.E() helps to give shortcut of each weekday.
        "day": DateFormat.E().format(weekDay).substring(0, 2),
        "amount": totalEachWeekDaySum
      };
    });
  }

//Fold function is similar to reduce function in JavaScript.
  double get weeklyTotalSpending {
    return groupedTransactionsByWeekDay.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsByWeekDay);
    return Container(
      child: Card(
        elevation: 10,
        //Padding can be used instead of container if you just want to introduce some padding.
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactionsByWeekDay
                  .map((data) {
                    //Flexible helps to equally space items even if items are large
                    return Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        percentOfTotalSpending:
                            ((data['amount'] as double) / weeklyTotalSpending),
                        totalSpentAmount: data['amount'],
                        weekDayLabel: data['day'],
                      ),
                    );
                  })
                  .toList()
                  .reversed
            ],
          ),
        ),
      ),
    );
  }
}
