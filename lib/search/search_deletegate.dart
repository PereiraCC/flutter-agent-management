
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
    return _ShowResults(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _ShowResults(query: query);
  }

}

class _ShowResults extends StatelessWidget {

  final String query;

  const _ShowResults({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final agentProvider = Provider.of<AgentManamegentProvider>(context);


    if ( query.isEmpty ) {
      return NoData(
        title: 'Search agents',
        subtitle: 'Please enter a search term', 
        secondSubtitle: 'You can find an agent by: ID, first and last name'
      );
    }

    return FutureBuilder(
      future: agentProvider.getSearchAgents(query),
      builder: (BuildContext context, AsyncSnapshot<List<Agent>> snapshot) {

          if( snapshot.hasData && snapshot.data!.length > 0 ) {
            
            final agents = snapshot.data!;

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: agents.length,
              itemBuilder: ( _, i) {
                return CardAgent(agent: agents[i]);
              },
            );

          } else {
            return NoData(
              title: 'No agents found',
              subtitle: 'Please press the sync button to get new agents', 
              secondSubtitle: 'You can find an agent by: ID, first and last name'
            );
          }

      },
    );
  }
}