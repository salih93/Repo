import 'package:flutter/material.dart';

class TextAlertDialog extends StatelessWidget {
  final String titleText;
  final String descText;
  final String btnTextOK;
  final String btnTextCancel;
  const TextAlertDialog({
    this.titleText,
    this.descText,
    this.btnTextOK,
    this.btnTextCancel
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(titleText),
      content: new Text(descText),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Text(btnTextOK),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),

        new TextButton(
          child: new Text(btnTextCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        
      ],
    );
  }
}
