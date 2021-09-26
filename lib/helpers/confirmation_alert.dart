
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

// Show confirmation alert (Yes No)
showConfirmationAlert({
  required BuildContext context, 
  required String title, 
  required String subtitle,
  required String urlImage,
  String? userName, 
  required Function continueEvent, 
  required Function cancelEvent
}) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(subtitle),
            Container(
              // color: Colors.red,
              // margin: EdgeInsets.only(top: 100, left: 10),
              child: ImageAgent(
                wid: 100,
                hei: 100,
                urlImage: urlImage,
              )
            ),
            Text(userName ?? '')
          ],
        ),
        actions: [
          TextButton(
            child: Text("Cancel"),
            onPressed: () => cancelEvent() 
          ),
          TextButton(
            child: Text("Delete", style: TextStyle(color: Colors.red.shade300)),
            onPressed: () => continueEvent()
          )
        ],
      );
    },
  );
}