import 'package:agent_management/providers/product_provider.dart';
import 'package:agent_management/services/products_service.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: AppBarCustom('Products list', Tabs.Agents),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: ( _ , i) {
          return ListTile(
            title: Text(products[i].title ?? 'no-data'),
          );
        }
      ),
      floatingActionButton: FloatingActionButton( 
        child: Icon(Icons.update),
        onPressed: () {
          ProductsServices.getAllProducts(context);
        },
      ),
   );
  }
}