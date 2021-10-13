
import 'package:flutter/material.dart';

import 'package:agent_management/screens/sing_screen.dart';
import 'package:agent_management/screens/home_screen.dart';
import 'package:agent_management/screens/create_agent_screen.dart';

Map<String, WidgetBuilder> getRoutes() {

  return <String, WidgetBuilder> {
    'sing'   : (_) => SingScreen(),
    'home'   : (_) => HomeScreen(),
    'create' : (_) => CreateAgentScreen(),
  };

}