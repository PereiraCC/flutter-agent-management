

import 'package:flutter/material.dart';

showConfirmationAlert({
  required BuildContext context, 
  required String title, 
  required String subtitle, 
  required Function continueEvent, 
  required Function cancelEvent
}) {
  
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () => cancelEvent() 
  );
  Widget continueButton = TextButton(
    child: Text("Delete", style: TextStyle(color: Colors.red.shade300)),
    onPressed: () => continueEvent()
  );
  
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(subtitle),
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