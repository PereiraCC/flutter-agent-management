import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:agent_management/models/user.dart';

import 'package:agent_management/providers/user_provider.dart';

import 'package:agent_management/services/user_service.dart';
import 'package:agent_management/helpers/show_alert.dart';

class SingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(  
            children: [
        
              Container(
                height: 250,
                child: CurvedHeader( screen: Screens.Sing ),
              ), 
        
              ArrowBackIcon(
                top       : 20, 
                right     : 5, 
                bottom    : 0, 
                left      : 30, 
                onPressed : () => Navigator.pushNamed(context, 'login')
              ),

              _Titles(),
        
              _CreateBody(),
        
            ],
          ),
        ),
      )
   );
  }
}

class _CreateBody extends StatelessWidget {

  final TextEditingController _identificationController = new TextEditingController();
  final TextEditingController _fullNameController       = new TextEditingController();
  final TextEditingController _emailController          = new TextEditingController();
  final TextEditingController _passController           = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 210, left: 25, right: 25),
      // color: Colors.green,
      width: 400,
      child: Column(
        children: [

          CustomInput(
            hintText: 'Identification',
            helpText: 'Example: 00000000', 
            icon: Icons.badge, 
            controller: _identificationController
          ),

          SizedBox(height: 15),

          CustomInput(
            hintText: 'Full Name',
            helpText: 'Example: Carlos Pereira', 
            icon: Icons.person, 
            controller: _fullNameController
          ),

          SizedBox(height: 15),

          CustomInput(
            hintText: 'Email',
            helpText: 'Example: test@test.com', 
            icon: Icons.mail, 
            controller: _emailController
          ),

          SizedBox(height: 15),

          CustomInput(
            hintText: 'Password',
            helpText: '', 
            icon: Icons.password, 
            controller: _passController,
            isPassword: true,
          ),

          _CreateAccountButton(
            identification: _identificationController,
            fullName      : _fullNameController,
            email         : _emailController,
            pass          : _passController,
          ),

          CustomSingleButton(
            title: 'Already a User? Log in', 
            onPressed: () => Navigator.pushNamed(context, 'login')
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 80, horizontal: 10),
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          Container(
            width: 350,
            child: Text(
              'Create', 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 25,
                fontWeight: FontWeight.bold
              )
            )
          ),

          Container(
            width: 350,
            child: Text(
              'New account', 
              style: TextStyle(
                color: Colors.white, 
                fontSize: 25,
                fontWeight: FontWeight.bold
              )
            )
          ),
        ],
      ),
    );
  }
}

class _CreateAccountButton extends StatelessWidget {
  
  final TextEditingController identification;
  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController pass;

  const _CreateAccountButton({
    Key? key, 
    required this.identification,  
    required this.fullName, 
    required this.email, 
    required this.pass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return TextButton(
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(  
          color:  ( !userProvider.isCreate ) ? Colors.red.shade300 : Colors.grey,
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
          child: Text('Create account', style: TextStyle(fontSize: 20, color: Colors.white))
        )
      ),
      onPressed: ( !userProvider.isCreate ) ? () => _createUser(context) : null
    );
  }

  void _createUser(BuildContext context) async {

    bool resp;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.isCreate = true;

    final newUser = new User(
      identification : this.identification.text,
      name           : this.fullName.text, 
      email          : this.email.text, 
      password       : this.pass.text, 
    );

    resp = await UserService.createUser(newUser);

    if(resp){

      showAlert(
        context  : context, 
        title    : 'Success', 
        subTitle : 'Successfully created user', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newUser.name}',
        status   : StatusAlert.Success,
        successPage: 'login',
        cancelPage: 'sing'
      );
      
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to create a user', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newUser.name}',
        status   : StatusAlert.Error,
        successPage: 'sing',
        cancelPage: 'sing'
      );
    }

    userProvider.isCreate = false;
  }

}