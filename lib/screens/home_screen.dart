import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/widgets/widgets.dart';

import 'package:agent_management/providers/agent_provider.dart';
import 'package:agent_management/services/agent_service.dart';


class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final agentsProvider = Provider.of<AgentManamegentProvider>(context);

    return Scaffold(
      appBar: AppBarCustom('Agents list'),
      body: (!agentsProvider.loading) 
              ? _CreateBody(agentsProvider: agentsProvider) 
              : Center(
                child: CircularProgressIndicator(
                  color: Colors.red.shade300,
                )
              ),
      floatingActionButton: FloatiangButton()
   );
  }
}

class _CreateBody extends StatelessWidget {

  const _CreateBody({
    Key? key,
    required this.agentsProvider,
  }) : super(key: key);

  final AgentManamegentProvider agentsProvider;

  @override
  Widget build(BuildContext context) {

    this.agentsProvider.getAllAgents();

    if(agentsProvider.agents.length > 0) {

      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: agentsProvider.agents.length,
        itemBuilder: ( _, i) {
          return  CardAgent(agent: agentsProvider.agents[i]);
        },
      );

    } else {
      return NoData(
        title: 'No agents',
        subtitle: 'Please press the + button to add a new agent',
        secondSubtitle: 'Please press the sync button to get new agents',
      );
    }
  }
}

class FloatiangButton extends StatelessWidget {

  const FloatiangButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final heightScreen = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: heightScreen - 140),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [

          FloatingActionButton(
            // onPressed: () => Navigator.pushNamed(context, 'create'),
            onPressed: () async {

              final agentP = Provider.of<AgentManamegentProvider>(context, listen: false);
              agentP.loading = true;
              await AgentService.getAllAgentsServices();
              agentP.loading = false;

            },
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.sync, color: Colors.white)
          ),

          SizedBox(height: 10),

          FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, 'create'),
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.add, color: Colors.white),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}