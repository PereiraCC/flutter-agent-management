
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/providers/providers.dart';
import 'package:agent_management/services/services.dart';

import 'package:agent_management/widgets/widgets.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    ProductsServices.getAllProducts(context);
    final productsProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBarCustom('Products list', Tabs.Agents),
      body: (!productsProvider.isLoading) 
            ? _CreateBody()
            : Center(
              child: CircularProgressIndicator(
                color: Colors.red.shade300,
              )
            ),
      floatingActionButton: _FloatingButtons(),
   );
  }
}

class _FloatingButtons extends StatelessWidget {

  const _FloatingButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final heightScreen = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: heightScreen - 140),
      child: Column(
        children: [

          FloatingActionButton( 
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.sync, color: Colors.white),
            onPressed: () async {
              final productsProvider = Provider.of<ProductProvider>(context, listen: false);
              productsProvider.isLoading = true;
              await ProductsServices.getAllProducts(context);
              productsProvider.isLoading = false;
            },
          ), 

          SizedBox(height: 10),

          FloatingActionButton(
            // TODO: Change route name
            onPressed: () => Navigator.pushNamed(context, 'product'),
            backgroundColor: Colors.red.shade300,
            child: Icon(Icons.add, color: Colors.white),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}

class _CreateBody extends StatelessWidget {

  const _CreateBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<ProductProvider>(context);

    if(productsProvider.products.length > 0) {

      return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: productsProvider.products.length,
        itemBuilder: ( _, i) {
          return CategoryCard(category: TypeCategory.Products, product: productsProvider.products[i]);
        },
      );

    } else if( !productsProvider.isSuccess ) { 

      return Center(
        child: CircularProgressIndicator(
          color: Colors.red.shade300,
        ),
      );

    }
    else if( productsProvider.products.length == 0 ) {

      return NoData(
        title: 'No products',
        subtitle: 'Please press the + button to add a new product',
        secondSubtitle: 'Please press the sync button to get new products',
        category: TypeCategory.Products
      );

    } 
    else {
      return Container();
    }
  }
}

