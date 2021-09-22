import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
      
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
            CardAgent(),
      
      
          ]),
      ),
      floatingActionButton: AddButton()
   );
  }
}

class AddButton extends StatelessWidget {

  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'create'),
      backgroundColor: Colors.red.shade300,
      child: Icon(Icons.add, color: Colors.white)
    );
  }
}