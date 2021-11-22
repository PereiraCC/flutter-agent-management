part of 'widgets.dart';

class DeleteButton extends StatelessWidget {

  final TypeCategory category;
  final String? name;
  
  const DeleteButton({
    Key? key, 
    required this.category, 
    this.name, 
  }) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    
    final widthScreen = MediaQuery.of(context).size.width;
    
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 190, left: widthScreen - 80),
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.red.shade300),
        onPressed: () {
          showConfirmationAlert(
            context       : context,
            title         : ( category == TypeCategory.Agents ) ? 'Delete an agent' : 'Delete a product',
            subtitle      : ( category == TypeCategory.Agents ) ? 'Do you want to remove this agent?' : 'Do you want to remove this product?',
            urlImage      : ( category == TypeCategory.Agents ) ? 'assets/agents.jpg' : 'assets/products.jpg',
            userName      : this.name ?? '',
            continueEvent : () async => remove(context),
            cancelEvent   : () => Navigator.pop(context)
          );
        }, 
      )
    );
  }

  void remove(BuildContext context) async {

    switch (this.category) {
      case TypeCategory.Agents:
          removeAgent(context);
        break;
      
      case TypeCategory.Products:
          removeProduct(context);
        break;

      default:
    }

    
  }

  void removeAgent(BuildContext context) async {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final resp = await AgentService.deleteAgent(agentProvider.agent.identification ?? 'no-identification', userProvider.token);


    if(resp){
      
      String fullName = '${agentProvider.agent.name} ${agentProvider.agent.lastname}';

      if(agentProvider.updating) 
        agentProvider.isChangePhoto = false;
        agentProvider.agent = Agent.empty();
        agentProvider.updating = false;

      showAlert(
        context     : context, 
        title       : 'Success', 
        subTitle    : 'Successfully deleted agent', 
        urlImage    : 'assets/agents.jpg', 
        userName    : fullName,
        status      : StatusAlert.Success,
        successPage : 'agent',
        cancelPage  : 'agentsOptions'
      );

    } else {
      showAlert(
        context     : context, 
        title       : 'Error', 
        subTitle    : 'Failed to delete an agent', 
        urlImage    : 'assets/agents.jpg', 
        userName    : '${agentProvider.agent.name} ${agentProvider.agent.lastname}',
        status      : StatusAlert.Error,
        successPage : 'agent',
        cancelPage  : 'agentsOptions'
      );
    }
  }

  void removeProduct(BuildContext context) async {

    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final resp = await ProductsServices.deleteProduct(productProvider.product.code ?? 'no-code', userProvider.token);


    if(resp){

      String title = productProvider.product.title ?? 'no-name';

      if(productProvider.isUpdating) 
          productProvider.isChangePhoto = false;
          productProvider.product = Product.empty();
          productProvider.isUpdating = false;
          productProvider.isAvailable = false;


      showAlert(
        context     : context, 
        title       : 'Success', 
        subTitle    : 'Successfully deleted product', 
        urlImage    : 'assets/products.jpg', 
        userName    : '$title',
        status      : StatusAlert.Success,
        successPage : 'product',
        cancelPage  : 'productOptions'
      );
    } else {
      showAlert(
        context     : context, 
        title       : 'Error', 
        subTitle    : 'Failed to delete a product', 
        urlImage    : 'assets/products.jpg', 
        userName    : '${productProvider.product.title}',
        status      : StatusAlert.Error,
        successPage : 'product',
        cancelPage  : 'productOptions'
      );
    }
  }
}