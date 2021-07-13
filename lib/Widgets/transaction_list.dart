import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/Widgets/no_transaction.dart';
import 'package:real_expense_planner/models/transaction.dart';

class TransactonList extends StatelessWidget {
  final List<Transaction> _transactionList;
  final Function _deleteTransaction;

  TransactonList(this._transactionList, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    // ListView.builder should be used instead of ListView as it helps
    //to optimize memory and improves app performance.
    //It does not render invisible widgets like Row,Column,Container so less memory is used.
    return Container(
        //We will set the height dynamically
        height: 400,
        child: _transactionList.isEmpty
            ? NoTransaction()
            : ListView.builder(
                cacheExtent: 100.0,
                // addAutomaticKeepAlives helps in garbageCollection
                // and saves memory when UI is out of view which minimizes app crash.
                // addAutomaticKeepAlives: false,
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
                        trailing: IconButton(
                          icon: CircleAvatar(
                            backgroundColor: Theme.of(context).errorColor,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            _deleteTransaction(index);
                          },
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _transactionList.length,
              ));
  }
}
