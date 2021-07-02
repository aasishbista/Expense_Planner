import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
    );
  }
}
