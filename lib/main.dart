import 'package:flutter/material.dart';
import 'package:real_expense_planner/Widgets/new_transaction.dart';
import 'package:real_expense_planner/Widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Expense Plannner",
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.pink[200],
          fontFamily: "Oswald",
          scaffoldBackgroundColor: Colors.purple[100],
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "OpenSans",
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // void _startAddNewTransaction(BuildContext ctx) {
  //   showModalBottomSheet(
  //       context: ctx,
  //       builder: (builderctx) {
  //         //Now no need to use Gesture Detector for this.
  //         // ModalBottomSheet wont close automatically by tapping it.
  //         return GestureDetector(
  //           onTap: () {},
  //           child: NewTransaction(_addNewTransaction),
  //           behavior: HitTestBehavior.opaque,
  //         );
  //       });
  // }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bctx) {
          return NewTransaction(_addNewTransaction);
        });
  }

// UserTransactionList
  final List<Transaction> _userTransactionsList = [
    // Transaction(
    //     id: "1", title: "New tee shirt", amount: 25, date: DateTime.now()),
    // Transaction(id: "2", title: "New tie", amount: 10.99, date: DateTime.now())
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTransaction = Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());

    setState(() {
      _userTransactionsList.add(newTransaction);
    });
    print(_userTransactionsList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Planner",
        ),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
          )
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
                  child: Text('Chart',
                      // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      style: Theme.of(context).textTheme.headline6),
                  elevation: 10,
                ),
              ),
              TransactonList(_userTransactionsList),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
