import 'package:agent_management/providers/providers.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/providers/agent_provider.dart';
import 'package:agent_management/providers/user_provider.dart';

import 'package:agent_management/routes/routes.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.red.shade300,
      statusBarBrightness: Brightness.dark,
    ));
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: ( _ ) => AgentManamegentProvider(),
        ),

        ChangeNotifierProvider(
          create: ( _ ) => UserProvider(),
        ),

        ChangeNotifierProvider(
          create: ( _ ) => ProductProvider(),
        ),

      ],
      child: MaterialApp(
        title: 'My Company Management',
        debugShowCheckedModeBanner: false,
        initialRoute: 'checking',
        routes: getRoutes(),
      ),
    );
  }
}