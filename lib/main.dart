import 'package:flutter/material.dart';
import '/Widgets/user_transaction.dart';

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
  // String titleInput;
  // String amountInput;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Planner"),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      // Whole body must be wrapped by SingleChildScrollView to prevent
      // overflow caused by keyboard as keyboard takes textfield height as padding.
      body: SingleChildScrollView(
        child: Center(
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
              UserTransaction(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
