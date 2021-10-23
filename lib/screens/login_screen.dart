import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:agent_management/services/user_service.dart';
import 'package:agent_management/providers/user_provider.dart';

import 'package:agent_management/helpers/show_alert.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: SingleChildScrollView(  
          physics: BouncingScrollPhysics(),
          child: Stack(  
            children: [
          
              Container(
                height: 250,
                child: CurvedHeader( screen: Screens.Sing ),
              ), 
          
              Container(
                margin: EdgeInsets.symmetric(vertical: 75, horizontal: 25),
                padding: EdgeInsets.only(left: 20, right: 20),
                width: 350,
                child: Text(
                  'Log in', 
                  style: TextStyle(
                    color: Colors.white, 
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )
                )
              ),
          
              _CreateBody(),
          
            ],
          ),
        ),
      ),
   );
  }
}

class _CreateBody extends StatelessWidget {

  final TextEditingController _emailController    = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    final sizeHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: 210, left: 25, right: 25),
      child: Column(  
        children: [

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
            controller: _passwordController,
            isPassword: true,
          ),

          SizedBox(height: 15),

          _LoginButton(
            email: _emailController,
            pass: _passwordController,
          ),

          SizedBox(height: 15),

          Divider(height: 5, thickness: 5),

          SizedBox(height: 15),

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: 350,
            child: Text(
              'Log in with', 
              style: TextStyle(
                color: Colors.red.shade300, 
                fontSize: 20
              )
            )
          ),

          SizedBox(height: 15),

          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(  
              borderRadius: BorderRadius.all(Radius.circular(50)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 5),
                )
              ]
            ),
            child: SignInButton(
              ( !userProvider.isLogin ) ? Buttons.GoogleDark : Buttons.Google,
              text: ( !userProvider.isLogin ) ? "Sign in with Google" : 'Wait google',
              onPressed: ( !userProvider.isLogin ) ? () => loginGoogle(context) : () => null,
              shape: StadiumBorder()
            ),
          ),

          SizedBox(height: sizeHeight * 0.05),

          CustomSingleButton(
            title: 'New user? Create account', 
            onPressed: () => Navigator.pushNamed(context, 'sing')
          ),
        ],
      ),
    );
  }

  // TODO: Refactor
  void loginGoogle(BuildContext context) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.isLogin = true;

    final resp = await UserService.googleSing(context);

    if(resp){

      Navigator.pushReplacementNamed(context, 'home');
      
    } else {

      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to log in', 
        urlImage : 'assets/male-icon.jpg', 
        userName : userProvider.msgError,
        status   : StatusAlert.Error,
        successPage: 'login',
        cancelPage: 'login'
      );
    }

    userProvider.isLogin = false;
  }
}

class _LoginButton extends StatelessWidget {
  
  final TextEditingController email;
  final TextEditingController pass;

  const _LoginButton({
    Key? key, 
    required this.email, 
    required this.pass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    final userProvider = Provider.of<UserProvider>(context);

    return TextButton(
      autofocus: true,
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(  
          color: ( !userProvider.isLogin ) ? Colors.red.shade300 : Colors.grey,
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
          child: Text('Log in with your account', style: TextStyle(fontSize: 20, color: Colors.white))
        )
      ),
      onPressed: ( !userProvider.isLogin ) ? () => login( context ): null,
    );
  }

  // TODO: Refactor
  void login(BuildContext context) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.isLogin = true;

    final resp = await UserService.login(this.email.text, this.pass.text, context);

    if(resp){

      Navigator.pushReplacementNamed(context, 'home');
      
    } else {

      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to log in', 
        urlImage : 'assets/male-icon.jpg', 
        userName : userProvider.msgError,
        status   : StatusAlert.Error,
        successPage: 'login',
        cancelPage: 'login'
      );
    }

    userProvider.isLogin = false;

  }

}

