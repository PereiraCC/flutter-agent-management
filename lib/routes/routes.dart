
import 'package:flutter/material.dart';

import 'package:agent_management/screens/screens.dart';


Map<String, WidgetBuilder> getRoutes() {

  return <String, WidgetBuilder> {
    'checking' : (_) => CheckAuthScreen(),

    'sing'     : (_) => SingScreen(),
    'login'    : (_) => LoginScreen(),

    'home'     : (_) => HomeScreen(),
    'create'   : (_) => CreateAgentScreen(),
  };

}