import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final String text;
  final Function buttonTriggered;

  AdaptiveElevatedButton({@required this.text, @required this.buttonTriggered});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              text,
            ),
            onPressed: buttonTriggered,
            color: Theme.of(context).primaryColor,
          )
        : ElevatedButton(
            onPressed: buttonTriggered,
            child: Text(text),
            style: ElevatedButton.styleFrom(
                onPrimary: Theme.of(context).textTheme.button.color,
                primary: Theme.of(context).primaryColor),
          );
  }
}
