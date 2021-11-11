import 'package:flutter/material.dart';

import 'package:agent_management/screens/screens.dart';
import 'package:agent_management/services/user_service.dart';

class CheckAuthScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.red.shade300,
      body: Center(
        child: FutureBuilder(
          future: UserService.readToken(context),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {

            if( !snapshot.hasData )
              return Text(
                'Wait...',
                style: TextStyle(  
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              );

            if( snapshot.data == ''){

              Future.microtask(() {
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_ , __, ___ ) => LoginScreen(),
                  transitionDuration: Duration( seconds: 0)
                ));
              });

            } else {
              
              Future.microtask(() async {
                await UserService.readUser(context);
                Navigator.pushReplacement(context, PageRouteBuilder(
                  pageBuilder: (_ , __, ___ ) => HomeScreen(),
                  transitionDuration: Duration( seconds: 0)
                ));
              });

            }


            return Container();
          },
        ),
     ),
   );
  }
}