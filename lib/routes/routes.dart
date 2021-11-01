
import 'package:flutter/material.dart';

import 'package:agent_management/screens/screens.dart';


Map<String, WidgetBuilder> getRoutes() {

  return <String, WidgetBuilder> {
    'checking' : (_) => CheckAuthScreen(),

    'sing'     : (_) => SingScreen(),
    'login'    : (_) => LoginScreen(),

    'agent'    : (_) => AgentScreen(),
    'create'   : (_) => CreateAgentScreen(),
  };

}