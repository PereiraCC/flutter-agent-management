import 'package:agent_management/services/products_service.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Products list', Tabs.Agents),
      body: Center(
        child: TextButton(
          child: Text('Get products'),
          onPressed: () {
            ProductsServices.getAllProducts(context);
          },
        )
      ),
   );
  }
}