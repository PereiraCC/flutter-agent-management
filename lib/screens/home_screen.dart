import 'package:agent_management/helpers/loading_alert.dart';
import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/agent_provider.dart';
import 'package:agent_management/services/agent_service.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final agentsProvider = Provider.of<AgentManamegentProvider>(context);

    return Scaffold(
      appBar: AppBarCustom(),
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
    return FutureBuilder(
      future: agentsProvider.getAllAgents(),
      builder : ( _ , AsyncSnapshot<List<Agent>> snapshot) {

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.red.shade300,
            )
          );
        }

        if(snapshot.data!.length == 0){
          // TODO: Container no data
          return Center(
            child: Text('No agents')
          );
        }

        final agents = snapshot.data;

        return ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: agents?.length ?? 0,
          itemBuilder: ( _, i) {
            return CardAgent(agent: agents![i]);
          }
        );
      }
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