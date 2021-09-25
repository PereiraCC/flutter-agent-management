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
      return _NoData();
    }
    
    // Old code 
    // return FutureBuilder(
    //   future: agentsProvider.getAllAgents(),
    //   builder : ( _ , AsyncSnapshot<List<Agent>> snapshot) {

    //     if(!snapshot.hasData) {
    //       return Center(
    //         child: CircularProgressIndicator(
    //           color: Colors.red.shade300,
    //         )
    //       );
    //     }

    //     if(snapshot.data!.length == 0){
    //       return _NoData();
    //     }

    //     final agents = snapshot.data;

    //     return ListView.builder(
    //       physics: BouncingScrollPhysics(),
    //       itemCount: agents?.length ?? 0,
    //       itemBuilder: ( _, i) {
    //         return CardAgent(agent: agents![i]);
    //       }
    //     );
    //   }
    // );
  }
}

class _NoData extends StatelessWidget {
  const _NoData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Container(  
          height: 200,
          margin: EdgeInsets.only(top: 80, right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 5),
              )
            ]
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 40, left: 120),
          child: ImageAgent(
            wid: 100,
            hei: 100,
            urlImage: 'assets/male-icon.jpg',
          )
        ),

        Container(
          margin: EdgeInsets.only(top: 150),
          // color: Colors.red,
          width: 400,
          child: Column(
            children: [

              TextCustom(  
                text: 'No agents',
                size: 20,
                font: FontWeight.bold,
                color: Colors.red.shade300,
              ),

              SizedBox(height: 10),

              TextCustom(  
                text: 'Please press the + button to add a new agent',
                size: 15,
                font: FontWeight.normal,
                color: Colors.grey
              ),

              Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

              TextCustom(  
                text: 'Please press the sync button to get new agents',
                size: 15,
                font: FontWeight.normal,
                color: Colors.grey
              ),
            ]
          )
        )

      ] ,
    );
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