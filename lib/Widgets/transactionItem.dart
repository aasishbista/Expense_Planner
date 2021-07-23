import 'package:flutter/material.dart';
import '/models/transaction.dart';
import 'package:intl/intl.dart';

//Single transaction item
class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);
  //key of your widget is passed to he base flutter or parent (super) widget.

  final Transaction transaction;

  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
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
                child: Text('\$${transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            '${transaction.title}',
            style: Theme.of(context).textTheme.headline6,
          ),

          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text('${DateFormat.yMMMMd().format(transaction.date)}'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  "No of items: ${transaction.numberOfItems}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          isThreeLine: true,
          //Rendering UI differently according to device size.
          trailing: mediaQuery.size.width > 360
              ? TextButton.icon(
                  onPressed: deleteTransaction,
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  label: Text(
                    "Delete transaction",
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ))
              : IconButton(
                  icon: CircleAvatar(
                    backgroundColor: Theme.of(context).errorColor,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: deleteTransaction,
                ),
        ),
      ),
    );
  }
}
