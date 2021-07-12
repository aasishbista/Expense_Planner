import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    return Card(
      elevation: 10,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
              onSubmitted: (_) {
                _dataSubmitted();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
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
                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    "Choose Date",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ]),
            ),
            ElevatedButton(
              onPressed: _dataSubmitted,
              child: Text('Add Transaction'),
              style: ElevatedButton.styleFrom(
                  onPrimary: Theme.of(context).textTheme.button.color,
                  primary: Theme.of(context).primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
