import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_expense_planner/models/transaction.dart';

class TransactonList extends StatelessWidget {
  final List<Transaction> _userTransactionList;

  TransactonList(this._userTransactionList);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ..._userTransactionList.map((transaction) {
          return Card(
            elevation: 20,
            margin: EdgeInsets.all(5),
            child: Container(
              // padding:
              //     EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.purple, width: 2)),
                        child: Text(
                          "\$${transaction.amount}",
                          style: TextStyle(
                              color: Colors.purple,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat.yMMMMd().format(transaction.date),
                            // DateFormat('yyyy-MM-dd')
                            // .format(transaction.date),
                            // transaction.date.toString(),
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }).toList()
      ],
    );
  }
}
