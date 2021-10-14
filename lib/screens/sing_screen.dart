import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class SingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(  
          children: [
      
            Container(
              // color: Colors.red,
              height: 250,
              child: CurvedHeader( screen: Screens.Sing ),
            ), 
      
            ArrowBackIcon(
              top       : 90, 
              right     : 5, 
              bottom    : 0, 
              left      : 30, 
              onPressed : () => print('sing arrow back icon') //TODO: Add fuction
            ),
      
            _CreateBody(),
      
          ],
        ),
      )
   );
  }
}

class _CreateBody extends StatelessWidget {

  final  TextEditingController _nameController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 210, left: 25, right: 25),
      // color: Colors.green,
      width: 400,
      child: Column(
        children: [

          _Titles(),

          SizedBox(height: 20),

          _Input(
            hintText: 'Identification',
            helpText: 'Example: 00000000', 
            icon: Icons.badge, 
            controller: _nameController
          ),

          SizedBox(height: 15),

          _Input(
            hintText: 'Full Name',
            helpText: 'Example: Carlos Pereira', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 15),

          _Input(
            hintText: 'Email',
            helpText: 'Example: test@test.com', 
            icon: Icons.mail, 
            controller: _nameController
          ),

          SizedBox(height: 15),

          _Input(
            hintText: 'Password',
            helpText: '', 
            icon: Icons.password, 
            controller: _nameController
          ),
        ],
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  const _Titles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          width: 350,
          child: Text(
            'Create', 
            style: TextStyle(
              color: Colors.red.shade300, 
              fontSize: 25
            )
          )
        ),

        Container(
          width: 350,
          child: Text(
            'New account', 
            style: TextStyle(
              color: Colors.red.shade300, 
              fontSize: 25
            )
          )
        ),
      ],
    );
  }
}

// TODO: Create widget reusable
class _Input extends StatelessWidget {

  final String helpText;
  final String? hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool? enable;
  
  const _Input({
    Key? key, 
    required this.helpText, 
    required this.icon, 
    required this.controller,
    this.enable = true,
    this.hintText = ''
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(  
      controller: this.controller,
      textCapitalization: TextCapitalization.sentences,
      autofocus: false,
      cursorColor: Colors.red.shade300,
      decoration: InputDecoration( 
        focusedBorder: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.red.shade300, width: 2.0)
        ),
        border: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(15.0),
        ),
        helperText: this.helpText,
        hintText: this.hintText,
        prefixIcon: Icon(this.icon, color: Colors.red.shade300),
        enabled: this.enable ?? true
      ),
    );
  }
}