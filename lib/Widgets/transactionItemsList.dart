import 'package:flutter/material.dart';
import '/Widgets/no_transaction.dart';
import 'package:real_expense_planner/models/transaction.dart';
import 'transactionItem.dart';

class TransactonItemsList extends StatelessWidget {
  final List<Transaction> _transactionList;
  final Function _deleteTransaction;

  TransactonItemsList(this._transactionList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    // ListView.builder should be used instead of ListView as it helps
    //to optimize memory and improves app performance.
    //It does not render invisible widgets like Row,Column,Container so less memory is used.
    return _transactionList.isEmpty
        ? NoTransaction()
        : ListView.builder(
            itemBuilder: (context, index) {
              //keys are required only for list View having stateful widget as children.
              // Dismissible is used to dismiss items when swiped.
              return Dismissible(
                key: Key(_transactionList[index].id),
                onDismissed: (direction) {
                  _deleteTransaction(index);
                },
                child: TransactionItem(
                    transaction: _transactionList[index],
                    deleteTransaction: () {
                      _deleteTransaction(index);
                    }),
                //to give background when dismissed
                background: Container(
                  color: Colors.red[800],
                  child: Text(
                    'Item delete',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              );
            },
            itemCount: _transactionList.length,
          );
  }
}
