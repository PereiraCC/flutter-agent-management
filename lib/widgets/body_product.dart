part of 'widgets.dart';


class BodyProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context, listen: false);

    return Stack(
      children: [

        BoxBackgroundBody(height: 650),

        _ProductCircleImage(),

        PictureButton(category: TypeCategory.Products),
        
        Container(
          child: (productProvider.isUpdating ) 
                  ? DeleteButton(
                    category: TypeCategory.Products, 
                    name: '${productProvider.product.title}'
                  )
                  : Container(),
        ),

        _ContentProducts()

      ]
    );
  }
}

class _ProductCircleImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productPro = Provider.of<ProductProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 140, left: widthScreen * 0.35),
      child: (!productPro.isChangePhoto) ? ImageAgent(
        wid: 100,
        hei: 100,
        networkImage: (productPro.isUpdating) 
                      ? (productPro.product.profileImage == 'no-image') ? false : true 
                      : false,
        urlImage: (productPro.isUpdating) 
                    ? (productPro.product.profileImage != 'no-image') 
                          ? productPro.product.profileImage ?? 'assets/no-image.jpg'
                          : 'assets/no-image.jpg'
                    : 'assets/no-image.jpg',
      ) : UploadImage(photo: productPro.photo)
    );
  }
}

class _ContentProducts extends StatelessWidget {

  const _ContentProducts({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    
    return Container(
      margin: EdgeInsets.only(top: 250),
      width: 400,
      child: Column(
        children: [

          // Title
          TextCustom( 
            text: (productProvider.isUpdating) ? 'Update Product' :'New Product',
            size: 20,
            font: FontWeight.bold,
            color: Colors.red.shade300,
          ),

          SizedBox(height: 10),

          // SubTitle
          TextCustom(
            text: (productProvider.isUpdating) ? '${productProvider.product.title}' : 'Please complete the product information',
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),

          Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

          SizedBox(height: 15),

          _FormProducts(productProvider),
        ],
      ),
    );
  }
}

class _FormProducts extends StatelessWidget {

  final ProductProvider productProvider;

  const _FormProducts(this.productProvider);
    
  @override
  Widget build(BuildContext context) {

    // Create controller for eath input
    final TextEditingController _codeController  = new TextEditingController();
    final TextEditingController _titleController = new TextEditingController();
    final TextEditingController _priceController = new TextEditingController();

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          InputTitleCustom(text: 'Code'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (productProvider.isUpdating ? productProvider.product.code : ''), 
            helpText: 'Example: 105', 
            icon: Icons.pin_rounded, 
            controller: _codeController, 
            enable: productProvider.isUpdating ? false : true
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Title'),
          SizedBox(height: 10),
          CustomInput(
            hintText: productProvider.isUpdating ? productProvider.product.title : '',
            helpText: 'Example: Iphone X', 
            icon: Icons.title_outlined, 
            controller: _titleController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Price'),
          SizedBox(height: 10),
          CustomInput(
            hintText: productProvider.isUpdating ? productProvider.product.price.toString() : '',
            helpText: 'Example: 1000', 
            icon: Icons.attach_money_outlined, 
            controller: _priceController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Available'),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(
                  child: ProductsSwitch(),
                ),

                SizedBox(width: 45),

                Container(
                  child: _ProductsButton(
                    code: _codeController,
                    title: _titleController,
                    price: _priceController,
                  ),
                ),
              
              ],
            ),
            
          ),
        ],
      ),
    );
  }
}

class _ProductsButton extends StatelessWidget {
  
  final TextEditingController code;
  final TextEditingController title;
  final TextEditingController price;

  const _ProductsButton({
    Key? key, 
    required this.code, 
    required this.title, 
    required this.price, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<ProductProvider>(context);

    return TextButton(
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(  
          color: ( !productsProvider.isLoading ) ? Colors.red.shade300 : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 5),
            )
          ]
        ),
        child: Center(
          child: Text('Save', style: TextStyle(fontSize: 20, color: Colors.white))
        )
      ),
      onPressed: ( !productsProvider.isLoading ) ? () => createAndUpdateProducts(context) : () {}
    );
  }

  void _createProducts(BuildContext context, ProductProvider provider) async {

    provider.isLoading = true;
    bool resp;
    String userID = await UserService.readUserID();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final newProduct = new Product(
      code: code.text, 
      title: title.text,
      price: int.parse(price.text), 
      available: provider.isAvailable, 
      userID: userID
    );

    resp = await ProductsServices.createProduct(newProduct, userProvider.token);

    if(resp){

      if(provider.isChangePhoto){
        resp = await ProductsServices.uploadImage(newProduct.code ?? '', provider.photo, userProvider.token);
      }

      if(resp) {
        provider.isChangePhoto = false;
        showAlert(
          context     : context, 
          title       : 'Success', 
          subTitle    : 'Successfully created products', 
          urlImage    : 'assets/products.jpg', 
          userName    : '${newProduct.title}',
          status      : StatusAlert.Success,
          successPage : 'product',
          cancelPage  : 'productOptions'
        );
      } else {

        showAlert(
          context     : context, 
          title       : 'Error', 
          subTitle    : 'Failed to create an product', 
          urlImage    : 'assets/products.jpg', 
          userName    : '${newProduct.title}',
          status      : StatusAlert.Error,
          successPage : 'product',
          cancelPage  : 'productOptions'
        );  

      }
    } else {
      showAlert(
        context     : context, 
        title       : 'Error', 
        subTitle    : 'Failed to create an product', 
        urlImage    : 'assets/products.jpg', 
        userName    : '${newProduct.title}',
        status      : StatusAlert.Error,
        successPage : 'product',
        cancelPage  : 'productOptions'
      );
    }

    provider.isLoading = false;
  }

  // void _updateAgent(BuildContext context, AgentManamegentProvider provider) async {
    
  //   bool resp;
  //   Agent agent = provider.agent;
  //   String userID = await UserService.readUserID();
  //   final userProvider = Provider.of<UserProvider>(context, listen: false);

  //   final newAgent = new Agent(
  //     name           : (this.name.text == '') ? agent.name : this.name.text, 
  //     lastname       : (this.lastName.text == '') ? agent.lastname : this.lastName.text,
  //     email          : (this.email.text == '') ? agent.email : this.email.text, 
  //     phone          : (this.phone.text == '') ? agent.phone : this.phone.text, 
  //     identification : (this.identification.text == '') ? agent.identification : this.identification.text,
  //     userID         : userID
  //   );

  //   resp = await AgentService.updateAgent(newAgent, userProvider.token);

  //   if(resp){

  //     if(provider.isChangePhoto){
  //       resp = await AgentService.uploadImage(newAgent.identification ?? '', provider.photo, userProvider.token);
  //     }

  //     if(resp) {
  //       provider.isChangePhoto = false;
  //       showAlert(
  //         context  : context, 
  //         title    : 'Success', 
  //         subTitle : 'Successfully updated agent', 
  //         urlImage : 'assets/male-icon.jpg', 
  //         userName : '${newAgent.name} ${newAgent.lastname}',
  //         status   : StatusAlert.Success,
  //         successPage : 'agent',
  //         cancelPage  : 'agentsOptions'
  //       );
  //     } else {
  //       showAlert(
  //         context  : context, 
  //         title    : 'Error', 
  //         subTitle : 'Failed to update an agent', 
  //         urlImage : 'assets/male-icon.jpg', 
  //         userName : '${newAgent.name} ${newAgent.lastname}',
  //         status   : StatusAlert.Error,
  //         successPage : 'agent',
  //         cancelPage  : 'agentsOptions'
  //       );  
  //     }
  //   } else {
  //     showAlert(
  //       context  : context, 
  //       title    : 'Error', 
  //       subTitle : 'Failed to update an agent', 
  //       urlImage : 'assets/male-icon.jpg', 
  //       userName : '${newAgent.name} ${newAgent.lastname}',
  //       status   : StatusAlert.Error,
  //       successPage : 'agent',
  //       cancelPage  : 'agentsOptions'
  //     );
  //   }
  // }

  void createAndUpdateProducts(BuildContext context) {

    final productsProvider = Provider.of<ProductProvider>(context, listen: false);

    if(!productsProvider.isUpdating) {
      _createProducts(context, productsProvider);
    } else {
      // _updateAgent(context, agentProvider);      
    }
  }

}