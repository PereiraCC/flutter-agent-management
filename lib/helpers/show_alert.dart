import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

showAlert(BuildContext context, String titulo, String subtitulo) {

  if(Platform.isAndroid){
    return showDialog(
    context: context, 
      builder: (_) => AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          MaterialButton(
            child: Text('Ok'),
            elevation: 5,
            textColor: Colors.blue,
            onPressed: () {
              if(titulo == 'Success'){
                Navigator.pushNamed(context, 'home');
              } else {
                Navigator.pushNamed(context, 'create');
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
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text('Ok'),
          onPressed: () {
            if(titulo == 'Success'){
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