import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Management', Tabs.Home),
      body: Center(
        child: Text('Home Screen'),
     ),
   );
  }
}