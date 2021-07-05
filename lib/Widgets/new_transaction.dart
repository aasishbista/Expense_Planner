import 'package:flutter/material.dart';

// NewTransaction
class NewTransaction extends StatefulWidget {
  final Function newTransactionAdded;

  NewTransaction(this.newTransactionAdded);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void dataSubmitted() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
//Validation for amount and title.
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      print("Invalid input");
      return;
    }
    //If validation is not satisfied newTransactionAdded willl not be called.
    widget.newTransactionAdded(enteredTitle, enteredAmount);

// Helps to close modal sheet automatically after data is submitted.
//Closes the topmost screen which is modal sheet in this case.
    Navigator.of(context).pop();
    print("Hello");
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
                dataSubmitted();
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => dataSubmitted(),
            ),
            TextButton(
              onPressed: dataSubmitted,
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(primary: Colors.purple),
            )
          ],
        ),
      ),
    );
  }
}
