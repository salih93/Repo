import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, 
  String titleText,
  String descText,
  String btnTextOK,
  Function okOnpressed,  
  String btnTextCancel,
  Function cancelOnpressed,
  
) async {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(btnTextOK),
    onPressed: okOnpressed,
  );
  Widget continueButton = TextButton(
    child: Text(btnTextCancel),
    onPressed: cancelOnpressed,
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(    
    title: Text(titleText),
    content: Text(descText),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(    
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}