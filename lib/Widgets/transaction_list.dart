import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Widgets/no_transaction.dart';
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
        child: _transactionList.isEmpty
            ? NoTransaction()
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(5),
                    elevation: 10,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: ListTile(
                        // dense: true,
                        leading: CircleAvatar(
                          maxRadius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              child:
                                  Text('\$${_transactionList[index].amount}'),
                            ),
                          ),
                        ),
                        title: Text(
                          '${_transactionList[index].title}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                            '${DateFormat.yMMMMd().format(_transactionList[index].date)}'),
                      ),
                    ),
                  );
                },
                itemCount: _transactionList.length,
              ));
  }
}
