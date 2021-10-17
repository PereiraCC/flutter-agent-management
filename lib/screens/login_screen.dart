import 'package:agent_management/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:agent_management/services/user_service.dart';

import 'package:agent_management/helpers/show_alert.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(  
        physics: BouncingScrollPhysics(),
        child: Stack(  
          children: [

            Container(
              height: 250,
              child: CurvedHeader( screen: Screens.Sing ),
            ), 

            _CreateBody(),

          ],
        ),
      )
   );
  }
}

class _CreateBody extends StatelessWidget {

  final TextEditingController _emailController    = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 210, left: 25, right: 25),
      child: Column(  
        children: [

          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            width: 350,
            child: Text(
              'Log in', 
              style: TextStyle(
                color: Colors.red.shade300, 
                fontSize: 25
              )
            )
          ),

          SizedBox(height: 20),

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
              Buttons.GoogleDark,
              text: "Sign in with Google",
              onPressed: () {},
              shape: StadiumBorder()
            ),
          ),

          SizedBox(height: 80),

          CustomSingleButton(
            title: 'New user? Create account', 
            onPressed: () => Navigator.pushNamed(context, 'sing')
          ),
        ],
      ),
    );
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
    return TextButton(
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(  
          color: Colors.red.shade300,
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
      onPressed: () => login(context)
    );
  }

  void login(BuildContext context) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);
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

  }

}

