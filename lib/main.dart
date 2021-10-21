import 'package:flutter/material.dart';

import 'package:agent_management/providers/agent_provider.dart';
import 'package:agent_management/providers/user_provider.dart';

import 'package:agent_management/routes/routes.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: ( _ ) => AgentManamegentProvider(),
        ),

        ChangeNotifierProvider(
          create: ( _ ) => UserProvider(),
        ),

      ],
      child: MaterialApp(
        title: 'My Company Management',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: getRoutes(),
      ),
    );
  }
}