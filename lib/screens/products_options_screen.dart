import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class ProductsOptionsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(  
        physics: BouncingScrollPhysics(),
        child: Stack(  
          children: [

            HeaderCreate(category: TypeCategory.Products),

            BodyProduct(),

          ],
        ),
      )
   );
  }
}