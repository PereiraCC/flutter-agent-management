import 'package:agent_management/widgets/widgets.dart';
import 'package:flutter/material.dart';


class SingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(  
        children: [

          Container(
            child: CurvedHeader( screen: Screens.Sing ),
          ), 

          ArrowBackIcon(
            top       : 90, 
            right     : 5, 
            bottom    : 0, 
            left      : 30, 
            onPressed : () => print('sing arrow back icon') //TODO: Add fuction
          ),

        ],
      )
   );
  }
}