import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:real_expense_planner/Widgets/PlatformAdaptiveButtons/adaptive_elevatedBg_button.dart';
import 'PlatformAdaptiveButtons/adaptive_Text_Button.dart';

// NewTransaction
class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime _chosenDate;

  void _dataSubmitted() {
    // It ensures that error is not raised when empty amount
    //is enters and addTx button is pressed as function is simply returned.
    if (amountController.text.isEmpty) {
      return;
    }
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    DateTime enteredDate = _chosenDate;

//Validation for amount and title.
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      print("Invalid input");
      return;
    }

    //If validation is not satisfied newTransactionAdded willl not be called.
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );

// Helps to close modal sheet automatically after data is submitted.
//Closes the topmost screen which is modal sheet in this case.
    Navigator.of(context).pop();
    print("Hello");
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
                      padding: EdgeInsets.all(15),
                      prefix: Icon(
                        Icons.title_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      maxLength: 50,
                      suffix: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      ),
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
                      cursorColor: Colors.pink,
                      placeholder: "Amount",
                      prefixMode: OverlayVisibilityMode.always,
                      suffixMode: OverlayVisibilityMode.always,
                      prefix: Icon(
                        Icons.monetization_on,
                        color: Theme.of(context).primaryColor,
                      ),
                      maxLength: 50,
                      padding: EdgeInsets.all(15),
                      suffix: Icon(
                        Icons.check_circle,
                        color: Theme.of(context).primaryColor,
                      ),
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
              AdaptiveElevatedButton(
                  text: "Add Transaction", buttonTriggered: _dataSubmitted)
            ],
          ),
        ),
      ),
    );
  }
}
