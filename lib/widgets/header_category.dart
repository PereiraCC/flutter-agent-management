
part of 'widgets.dart';

class HeaderCreate extends StatelessWidget {
  
  final TypeCategory category;

  const HeaderCreate({
    Key? key, 
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children :[
        Container(
          child: CurvedHeader( screen: Screens.Create )
        ),
        _Title(this.category),
      ] 
    );
  }
}

class _Title extends StatelessWidget {
  
  final TypeCategory category;
  
  const _Title(this.category);

  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    void eventBack() {

      if(this.category == TypeCategory.Agents ){

        agentProvider.back = true;
        if(agentProvider.updating){
          agentProvider.updating = false;
          agentProvider.agent = Agent.empty();
        }
        Navigator.pushNamed(context, 'agent');

      } else {
        // TODO: Come back here when updated product
        // productProvider.back = true;
        // if(productProvider.updating){
        //   productProvider.updating = false;
        //   productProvider.product = Product.empty();
        // }
        productProvider.product = Product.empty();
        Navigator.pushNamed(context, 'product');

      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ArrowBackIcon(
          top       : 50, 
          right     : 0, 
          bottom    : 0, 
          left      : 10, 
          onPressed : () => eventBack()
        ),

        // Title
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            (this.category == TypeCategory.Agents) 
            ? (agentProvider.updating) ? 'Edit' : 'Create'
            : 'Create',
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