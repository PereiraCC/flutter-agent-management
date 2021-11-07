
import 'package:agent_management/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/screens/screens.dart';


Map<String, WidgetBuilder> getRoutes() {

  return <String, WidgetBuilder> {
    'checking' : (_) => CheckAuthScreen(),

    'home'     : (_) => HomeScreen(),

    'sing'     : (_) => SingScreen(),
    'login'    : (_) => LoginScreen(),

    'agent'    : (_) => AgentScreen(),
    'create'   : (_) => CreateAgentScreen(),
  };

}