
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/agent_provider.dart';

class DataSearch extends SearchDelegate {

  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon( Icons.clear ),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close( context, null );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.red,
        child: Text(query),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context);


    if ( query.isEmpty ) {
      return Container();
    }

    return FutureBuilder(
      future: agentProvider.getAllAgents(),
      builder: (BuildContext context, AsyncSnapshot<List<Agent>> snapshot) {

          if( snapshot.hasData ) {
            
            final agents = snapshot.data!;

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: agents.length,
              itemBuilder: ( _, i) {
                return CardAgent(agent: agents[i]);
              },
            );

          } else {
            return Center(
              child: CircularProgressIndicator()
            );
          }

      },
    );
  }



}