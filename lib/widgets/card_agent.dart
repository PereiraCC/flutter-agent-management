part of 'widgets.dart';

// This function sets the Agent to the provider and navigates to create the screen.
void setAgent({required BuildContext context, required Agent agent}) {

  final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
  agentProvider.updating = true;
  agentProvider.agent = agent;
  Navigator.pushNamed(context, 'agentsOptions');

}

class CardAgent extends StatelessWidget {

  final Agent agent;
  const CardAgent({Key? key, required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setAgent(context: context, agent: this.agent),
      child:
        Container(
          width: 350,
          height: 100,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
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
          child: Row(  
            children: [
              ImageAgent(
                wid: 100,
                hei: 70,
                urlImage: (this.agent.profileImage != 'no-image') 
                          ? this.agent.profileImage ?? 'assets/no-image.jpg'
                          : 'assets/no-image.jpg',
                networkImage: (this.agent.profileImage != 'no-image') ? true : false          
              ),
              _DataAgent( 
                completeName: '${this.agent.name} ${this.agent.lastname}',
                identification: this.agent.identification ?? 'No identification', 
              ),
              Expanded(child: _ArrowIcon(agent: this.agent))
            ],
          ),
        ),
    );
  }
}

class _DataAgent extends StatelessWidget {

  final String completeName;
  final String identification;

  const _DataAgent({
    Key? key, 
    required this.completeName, 
    required this.identification
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Column( 
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
          Container(
            width: 180,
            child: Text(this.identification,
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold,
                color: Colors.red.shade300
              ),
              textAlign: TextAlign.left,
            ),
          ),

          SizedBox(height: 10),

          Container(
            width: 180,
            child: Text(this.completeName,
              style: TextStyle(
                fontSize: 15, 
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {

  final Agent agent;

  const _ArrowIcon({Key? key, required this.agent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      width: 50,
      child: IconButton(
        onPressed: () => setAgent(context: context, agent: this.agent),
        icon: Icon(Icons.arrow_forward_ios, color: Colors.red.shade300)
      ),
    );
  }
}