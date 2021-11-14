
import 'package:flutter/material.dart';

import 'package:agent_management/screens/screens.dart';

Map<String, WidgetBuilder> getRoutes() {

  return <String, WidgetBuilder> {
    'checking'       : (_) => CheckAuthScreen(),

    'home'           : (_) => HomeScreen(),

    'sing'           : (_) => SingScreen(),
    'login'          : (_) => LoginScreen(),
    'editProfile'    : (_) => EditProfileScreen(),

    'agent'          : (_) => AgentScreen(),
    'agentsOptions'  : (_) => AgentsOptionsScreen(),    

    'product'        : (_) => ProductsScreen(),
    'productOptions' : (_) => ProductsOptionsScreen(),
  };

}