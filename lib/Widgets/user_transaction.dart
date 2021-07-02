import 'package:flutter/material.dart';
import '/Widgets/new_transaction.dart';
import '/Widgets/transaction_list.dart';
import '../models/transaction.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactionsList = [
    Transaction(
        id: "1", title: "New tee shirt", amount: 25, date: DateTime.now()),
    Transaction(id: "2", title: "New tie", amount: 10.99, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(),
        //List of transactions
        TransactonList(_userTransactionsList)
      ],
    );
  }
}
