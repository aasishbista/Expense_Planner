import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:real_expense_planner/Widgets/new_transaction.dart';
import 'package:real_expense_planner/Widgets/transaction_list.dart';
import 'models/transaction.dart';
import './widgets/chart.dart';

void main() {
  //To prevent landacape mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
                      fontFamily: "Quicksand",
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
        isScrollControlled: true,
        isDismissible: true,
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

  bool _showChartToggle = false;

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
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text(
              "Expense Planner",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                    color: Colors.white,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ))
        : AppBar(
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
          );

    final mediaQuery = MediaQuery.of(context);

    final topStatusBarHeight = mediaQuery.padding.top;

    final appBarHeight = appBar.preferredSize.height;

    final _safeAreaLayoutHeight =
        mediaQuery.size.height - appBarHeight - topStatusBarHeight;

    final _transactionListTileWidget = Container(
        height: _safeAreaLayoutHeight * 0.7,
        child: TransactonList(_userTransactionsList, _deleteTx));

    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: isLandscape
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show chart',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Platform.isIOS
                          ? CupertinoSwitch(
                              value: _showChartToggle,
                              activeColor: Theme.of(context).accentColor,
                              onChanged: (val) {
                                setState(() {
                                  _showChartToggle = val;
                                });
                              },
                            )
                          : Switch(
                              value: _showChartToggle,
                              onChanged: (value) {
                                setState(() {
                                  _showChartToggle = value;
                                });
                              })
                    ],
                  ),
// this type of if statement (inlist If Statemnet )can only be used in list
                  if (_showChartToggle)
                    Container(
                      height: _safeAreaLayoutHeight * 0.7,
                      child: Chart(_recentSevenDaysTransactions),
                    ),
                  if (!_showChartToggle)
                    Container(
                      height: _safeAreaLayoutHeight * 0.8,
                      child: _transactionListTileWidget,
                    ),
                  // _transactionListTileWidget,
                ],
              )
            : Column(
                children: [
                  Container(
                      // Here we deduct the appBar height and the top notch height to set hte height dynamically.
                      height: _safeAreaLayoutHeight * 0.3,
                      padding: EdgeInsets.all(7),
                      child: Chart(_recentSevenDaysTransactions)),
                  _transactionListTileWidget
                ],
              ),
      ),
    );

//MediaQuery determines orientation during each build
//for each build run we will never reassign it so final.

    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: appBar, child: pageBody)
        : Scaffold(
            appBar: appBar,
            // Whole body must be wrapped by SingleChildScrollView to prevent
            // overflow caused by keyboard as keyboard takes textfield height as padding.

            body: pageBody,

            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
