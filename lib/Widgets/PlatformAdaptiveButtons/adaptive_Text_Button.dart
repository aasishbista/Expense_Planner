import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function buttonTriggered;

  AdaptiveTextButton({@required this.text, @required this.buttonTriggered});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            onPressed: buttonTriggered)
        : TextButton(
            onPressed: buttonTriggered,
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
