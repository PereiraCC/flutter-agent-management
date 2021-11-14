part of 'widgets.dart';

// This function sets the Agent to the provider and navigates to create the screen.
void setAgent({required BuildContext context, required Agent agent}) {

  if(agent.identification == null) {
    
    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    agentProvider.updating = true;
    agentProvider.agent = agent;
    Navigator.pushNamed(context, 'agentsOptions');

  }

}

class CategoryCard extends StatelessWidget {

  final Agent? agent;
  final Product? product;
  final TypeCategory category;
  const CategoryCard({
    Key? key, 
    this.agent, 
    this.product, 
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (this.category == TypeCategory.Agents) 
             ? () => setAgent(context: context, agent: this.agent ?? new Agent.empty())
             : () {},//TODO: Create function for products
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
                urlImage: (this.category == TypeCategory.Agents )

                          ? (this.agent!.profileImage != 'no-image') 
                              ? this.agent!.profileImage ?? 'assets/no-image.jpg'
                              : 'assets/no-image.jpg'

                          : (this.product!.profileImage != 'no-image') 
                              ? this.product!.profileImage ?? 'assets/no-image.jpg'
                              : 'assets/no-image.jpg',

                networkImage: (this.category == TypeCategory.Agents )
                              ? (this.agent!.profileImage != 'no-image') ? true : false          
                              : (this.product!.profileImage != 'no-image') ? true : false          
              ),

              _Data( 
                completeName: (this.category == TypeCategory.Agents )
                              ? '${this.agent!.name} ${this.agent!.lastname}'
                              : '${this.product!.title}',
                
                identification: (this.category == TypeCategory.Agents )
                                ? this.agent!.identification ?? 'No identification'
                                : this.product!.code ?? 'No code', 
              ),

              Expanded(
                child: (this.category == TypeCategory.Agents )
                       ? _ArrowIcon(category: this.category, agent: this.agent ?? new Agent.empty())
                       : _ArrowIcon(category: this.category, product: this.product ?? new Product.empty())
              ),

            ],
          ),
        ),
    );
  }
}

class _Data extends StatelessWidget {

  final String completeName;
  final String identification;

  const _Data({
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

  final Agent? agent;
  final Product? product;
  final TypeCategory category;

  const _ArrowIcon({
    Key? key, 
    this.agent,
    this.product,
    required this.category
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      width: 50,
      child: IconButton(
        onPressed: (this.category == TypeCategory.Agents) 
             ? () => setAgent(context: context, agent: this.agent ?? new Agent.empty())
             : () {},//TODO: Create function for products
        icon: Icon(Icons.arrow_forward_ios, color: Colors.red.shade300)
      ),
    );
  }
}