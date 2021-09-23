import 'package:agent_management/providers/agent_provider.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
      
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
      
      
          ]),
      ),
      floatingActionButton: FloatiangButton()
   );
  }
}

class FloatiangButton extends StatelessWidget {

  const FloatiangButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 550),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [

          FloatingActionButton(
            // onPressed: () => Navigator.pushNamed(context, 'create'),
            onPressed: () async {

              final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);

              await agentProvider.getAllAgents();

            },
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.sync, color: Colors.white)
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, 'create'),
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.add, color: Colors.white)
          ),
        ],
      ),
    );
  }
}