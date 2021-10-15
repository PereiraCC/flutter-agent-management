import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:agent_management/widgets/widgets.dart';

// Create a enum for get status of dialogAlert
enum StatusAlert {
  Success,
  Error
}

showAlert({
  required BuildContext context, 
  required String title,
  required String subTitle,
  required String urlImage,
  required String successPage,
  required String cancelPage,
  String? userName,
  required StatusAlert status
}) {

  Color color;

  if(status == StatusAlert.Success) {
    color = Colors.green.shade500;
  } else {
    color = Colors.red.shade500;
  }

  if(Platform.isAndroid){
    return showDialog(
    context: context, 
      builder: (_) => AlertDialog(
        title: Text(title, style: TextStyle(color: color)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(subTitle),
            Container(
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
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () {
              if(status == StatusAlert.Success){
                Navigator.pushNamed(context, successPage);
              } else {
                Navigator.pushNamed(context, cancelPage);
              }
            },
          )
        ],
      )
    );
  }

  showCupertinoDialog(
    context: context, 
    builder: (_) => CupertinoAlertDialog(
      title: Text(title, style: TextStyle(color: color)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subTitle),
          Container(
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
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () {
            if(title == 'Success'){
              Navigator.pushNamed(context, 'home');
            } else {
              Navigator.pushNamed(context, 'create');
            }
          }
        )
      ],
    )
  );
}