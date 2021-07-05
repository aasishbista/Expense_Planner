import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_expense_planner/models/transaction.dart';

class TransactonList extends StatelessWidget {
  final List<Transaction> _transactionList;

  TransactonList(this._transactionList);

  @override
  Widget build(BuildContext context) {
    // ListView.builder should be used instead of ListView as it helps
    //to optimize memory and improves app performance.
    //It does not render invisible widgets like Row,Column,Container so less meemory is used.
    return Container(
      height: 350,
      child: ListView.builder(
        itemBuilder: (context, index) {
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
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 2)),
                        child: Text(
                          //toStringAsFixed helps to round off the decimal numbers (2 decimal places in this case).
                          "\$${_transactionList[index].amount.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _transactionList[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat.yMMMMd()
                                .format(_transactionList[index].date),
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
        },
        itemCount: _transactionList.length,
      ),
    );
  }
}
