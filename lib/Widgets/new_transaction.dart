import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function newTransactionAdded;

  NewTransaction(this.newTransactionAdded);

  void dataSubmitted() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
//Validation for amount and title.
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      print("Invalid input");
      return;
    }
    //If validation is not satisfied newTransactionAdded willl not be called.
    newTransactionAdded(enteredTitle, enteredAmount);
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
