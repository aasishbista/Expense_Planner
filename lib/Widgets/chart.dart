import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  ///last sev days transactions
  final List<Transaction> recentWeekTransactions;
  Chart(this.recentWeekTransactions);

  List<Map<String, Object>> get groupedTransactionsByWeekDay {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalEachWeekDaySum = 0.0;

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
        "day": DateFormat.E().format(weekDay),
        "amount": totalEachWeekDaySum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionsByWeekDay);
    return Container(
      child: Card(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}

/*
class Chart extends StatelessWidget {
  final List<Transaction> recentWeekTransactions;

  Chart(this.recentWeekTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      //weekDay is date and time of each transaction.
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSumofEachWeekDay = 0.0;

      for (var i = 0; i < recentWeekTransactions.length; i++) {
        // If condition is used to check if the transaction we are looking at
        // in recentWeekTransaction happened today.
        if (recentWeekTransactions[i].date.day == weekDay.day &&
            recentWeekTransactions[i].date.month == weekDay.month &&
            recentWeekTransactions[i].date.year == weekDay.year) {
          totalSumofEachWeekDay += recentWeekTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSumofEachWeekDay);

      return {
        //DateFormat.E() helps to give shortcut of each weekday.
        'day': DateFormat.E().format(weekDay),
        "amount": totalSumofEachWeekDay,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactions);
    return Container(
      child: Card(
        elevation: 20,
        child: Row(
          children: [
            for (var tx in recentWeekTransactions) Text(tx.date.toString())
          ],
        ),
      ),
    );
  }
}*/
