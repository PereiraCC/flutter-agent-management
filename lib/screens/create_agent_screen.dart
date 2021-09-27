import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class CreateAgentScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
      
            HeaderCreate(),
      
            BodyScreenCreate(),

          ],
        ),
      ),
    );
  }
}

