
part of 'widgets.dart';

class HeaderCreate extends StatelessWidget {
  
  const HeaderCreate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children :[
        Container(
          child: CurvedHeader( screen: Screens.Create )
        ),
        _Title(),
      ] 
    );
  }
}

class _Title extends StatelessWidget {
    
  const _Title({
    Key? key,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {

    void eventBack() {
      final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
      agentProvider.back = true;
      if(agentProvider.updating){
        agentProvider.updating = false;
        agentProvider.agent = Agent.empty();
      }
      Navigator.pushNamed(context, 'home');
    }

    return Column(
      children: [

        ArrowBackIcon(
          top       : 25, 
          right     : 5, 
          bottom    : 0, 
          left      : 0, 
          onPressed : () => eventBack()
        ),

        // Title
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text('Profile', 
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          )
        )
      ],
    );
  }
}

// class _ArrowBackIcon extends StatelessWidget {
    
//   const _ArrowBackIcon({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(top: 25, right: 5),
//       height: 40,
//       width: 100,
//       child: IconButton(
//         padding: EdgeInsets.only(right: 50),
//         icon: Icon(Icons.arrow_back_ios, color: Colors.white),
//         onPressed: () {
//           final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
//           agentProvider.back = true;
//           if(agentProvider.updating){
//             agentProvider.updating = false;
//             agentProvider.agent = Agent.empty();
//           }
//           Navigator.pushNamed(context, 'home');
//         },
//       ),
//     );
//   }
// }