import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'PlatformAdaptiveButtons/adaptive_elevatedBg_button.dart';
import 'PlatformAdaptiveButtons/adaptive_Text_Button.dart';

// NewTransaction
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction) {
    print('Constructor New Transaction widget called');
  }

  @override
  _NewTransactionState createState() {
    print('createState called.');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _chosenDate;

  int numberOFItems = 0;
  _NewTransactionState() {
    print('Constructor _NewTransactionState called');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose called");
  }

  @override
  void initState() {
    super.initState();
    print("Init state called");
  }

  void _dataSubmitted() {
    // It ensures that error is not raised when empty amount
    //is enters and addTx button is pressed as function is simply returned.
    if (amountController.text.isEmpty) {
      return;
    }
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    DateTime enteredDate = _chosenDate;
    int enteredNumberOfItems = numberOFItems;

//Validation for amount and title.
    if (enteredTitle.isEmpty ||
        enteredAmount <= 0 ||
        enteredDate == null ||
        enteredNumberOfItems == 0) {
      print("Invalid input");
      return;
    }

    //If validation is not satisfied newTransactionAdded willl not be called.
    widget.addNewTransaction(
        enteredTitle, enteredAmount, enteredDate, enteredNumberOfItems);

// Helps to close modal sheet automatically after data is submitted.
//Closes the topmost screen which is modal sheet in this case.
    Navigator.of(context).pop();
    // print("Hello");
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //tells that app needs to rn build agian to update UI.
      setState(() {
        _chosenDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        //For keyboard inset
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: Platform.isIOS
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.end,
            children: [
              Platform.isIOS
                  ? CupertinoTextField.borderless(
                      cursorColor: Colors.pink,
                      placeholder: "Title",
                      prefixMode: OverlayVisibilityMode.always,
                      suffixMode: OverlayVisibilityMode.always,
                      padding: const EdgeInsets.all(15),
                      prefix: Icon(
                        Icons.title_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      maxLength: 50,
                      suffix: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      controller: titleController,
                      onSubmitted: (_) {
                        _dataSubmitted();
                      },
                    )
                  : TextFormField(
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.title_sharp,
                          color: Theme.of(context).primaryColor,
                        ),
                        suffixIcon: Icon(Icons.check_circle),
                        labelText: "Title",
                        labelStyle:
                            TextStyle(color: Theme.of(context).primaryColor),
                        helperText: "Name of Transaction",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor)),
                      ),
                      controller: titleController,
                      maxLength: 50,
                      onFieldSubmitted: (_) {
                        _dataSubmitted();
                      },
                    ),
              Platform.isIOS
                  ? CupertinoTextField.borderless(
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.pink,
                      placeholder: "Amount",
                      prefixMode: OverlayVisibilityMode.always,
                      suffixMode: OverlayVisibilityMode.always,
                      prefix: Icon(
                        Icons.monetization_on,
                        color: Theme.of(context).primaryColor,
                      ),
                      maxLength: 50,
                      padding: const EdgeInsets.all(15),
                      suffix: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      controller: amountController,
                      onSubmitted: (_) {
                        _dataSubmitted();
                      },
                    )
                  : TextField(
                      maxLength: 30,
                      cursorColor: Colors.pink,
                      decoration: InputDecoration(
                          labelText: "Amount",
                          labelStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          helperText: "Transaction Amount",
                          // helperStyle: TextStyle(color: Theme.of(context).primaryColor),
                          icon: Icon(
                            Icons.monetization_on,
                            color: Theme.of(context).primaryColor,
                          ),
                          suffixIcon: Icon(Icons.check_circle),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor))),
                      controller: amountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      onSubmitted: (_) => _dataSubmitted(),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Number of items taken : ",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 14),
                  ),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          numberOFItems > 0
                              ? numberOFItems -= 1
                              : numberOFItems = 0;
                        });
                      },
                      icon: Icon(Icons.remove)),
                  Text('$numberOFItems',
                      style: Theme.of(context).textTheme.headline6),
                  IconButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          numberOFItems += 1;
                        });
                      },
                      icon: Icon(Icons.add))
                ],
              ),
              Container(
                height: 50,
                child: Row(children: [
                  Expanded(
                      child: Text(
                    _chosenDate == null
                        ? "No Date chosen"
                        : 'Date chosen : ${DateFormat.yMd().format(_chosenDate)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  //Custom made text button
                  AdaptiveTextButton(
                    text: "Choose Date",
                    buttonTriggered: _presentDatePicker,
                  )
                ]),
              ),
              // Custom made elevated button or button with background for both iOS and android.
              InkWell(
                child: AdaptiveElevatedButton(
                    text: "Add Transaction", buttonTriggered: _dataSubmitted),
              )
            ],
          ),
        ),
      ),
    );
  }
}
