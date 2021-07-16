import 'package:flutter/material.dart';

class NoTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Card(
              margin: EdgeInsets.all(20),
              color: Colors.blue[100],
              child: Text(
                "No any transactions yet!",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              child: Image.asset(
                "Assets/images/waiting.png",
                fit: BoxFit.cover,
              ),
            )
          ],
        );
      },
    );
  }
}
