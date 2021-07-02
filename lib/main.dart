import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: "1", title: "New tee shirt", amount: 25, date: DateTime.now()),
    Transaction(id: "2", title: "New tie", amount: 10.99, date: DateTime.now())
  ];

  // String titleInput;
  // String amountInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Planner"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              // padding: EdgeInsets.all(20),
              child: Card(
                // margin: EdgeInsets.all(10),
                child: Text(
                  'Chart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                elevation: 10,
              ),
            ),
            Card(
              elevation: 10,
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: "Title"),
                      controller: titleController,
                      // onChanged: (value) {
                      //   titleInput = value;
                      // },
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: "Amount"),
                      controller: amountController,
                      // onChanged: (value) {
                      //   // amountInput = value;
                      //   amountController.text = value
                      // },
                    ),
                    TextButton(
                      onPressed: () {
                        print("Hello");
                        print(titleController.text);
                        print(amountController.text);
                        // print(titleInput);sdd
                        // print(amountInput);
                      },
                      child: Text('Add Transaction'),
                      style: TextButton.styleFrom(primary: Colors.purple),
                    )
                  ],
                ),
              ),
            ),
            //List of transactions
            Column(
              children: [
                ...transactions.map((transaction) {
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
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.purple, width: 2)),
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
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    DateFormat.yMMMMd()
                                        .format(transaction.date),
                                    // DateFormat('yyyy-MM-dd')
                                    // .format(transaction.date),
                                    // transaction.date.toString(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
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
            )
          ],
        ),
      ),
    );
  }
}
