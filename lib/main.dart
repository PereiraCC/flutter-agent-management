import 'package:agent_management/providers/agent_provider.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/routes/routes.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(
          create: ( _ ) => AgentManamegentProvider()
        )

      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: getRoutes(),
      ),
    );
  }
}