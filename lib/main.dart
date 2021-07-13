import 'package:flutter/material.dart';
import 'package:real_expense_planner/Widgets/new_transaction.dart';
import 'package:real_expense_planner/Widgets/transaction_list.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';

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
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.purple[700],
          fontFamily: "Oswald",
          scaffoldBackgroundColor: Colors.white70,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "OpenSans",
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white)),
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

//To filter out last seven days transactions
  List<Transaction> get _recentSevenDaysTransactions {
    //where gives iterable which must be converted to List.
    return _userTransactionsList.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTransaction = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactionsList.add(newTransaction);
    });
    print(_userTransactionsList);
  }

  void _deleteTx(int index) {
    setState(() {
      _userTransactionsList.removeAt(index);
    });
  }

//Mark:- Delete transaction by Id -> String using remove where.
  // void _deleteTransaction(String txId) {
  //   setState(() {
  //     _userTransactionsList.removeWhere((tx) {
  //       return tx.id == txId;
  //     });
  //   });

  //   print("{Transaction $txId removed}");
  // }

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
          child: Container(
            padding: EdgeInsets.all(7),
            child: Column(
              children: [
                Chart(_recentSevenDaysTransactions),
                TransactonList(_userTransactionsList, _deleteTx),
              ],
            ),
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
