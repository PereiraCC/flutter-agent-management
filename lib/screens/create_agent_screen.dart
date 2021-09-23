import 'package:agent_management/models/agent.dart';
import 'package:agent_management/providers/agent_provider.dart';
import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CreateAgentScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBarCustom(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
      
            _Header(),
      
            _BoxForm(),

          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children :[
        Container(
          // height: 800,
          child: CurvedHeader()
        ),
        _Title(),
      ] 
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
          margin: EdgeInsets.only(top: 25, right: 5),
          // color: Colors.red,
          height: 40,
          width: 100,
          child: IconButton(
            padding: EdgeInsets.only(right: 50),
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, 'home');
            },
          ),
        ),

        Container(
          // color: Colors.green,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          // margin: EdgeInsets.symmetric(horizontal: 25),
          child: Text('Profile', 
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold,
              color: Colors.white
            )
          )
        )
      ],
    );
  }
}

class _BoxForm extends StatelessWidget {

  const _BoxForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        _BoxBackground(),

        Container(
          margin: EdgeInsets.only(top: 100, left: 120),
          child: ImageAgent(
            wid: 100,
            hei: 100,
            urlImage: 'assets/male-icon.jpg',
          )
        ),

        _InputsForm()

      ]
    );
  }
}

class _BoxBackground extends StatelessWidget {
  const _BoxBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 880,
      margin: EdgeInsets.only(top: 150, right: 10, left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 5),
          )
        ]
      ),
    );
  }
}

class _InputsForm extends StatelessWidget {

  final _identificationController = TextEditingController();
  final _nameController           = TextEditingController();
  final _lastNameController       = TextEditingController();
  final _emailController          = TextEditingController();
  final _phoneController          = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 210),
      // color: Colors.red,
      width: 400,
      child: Column(
        children: [

          TextCustom(  
            text: 'New Agent',
            size: 20,
            font: FontWeight.bold,
            color: Colors.red.shade300,
          ),

          SizedBox(height: 10),

          TextCustom(  
            text: 'Please complete the agent information',
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),

          Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

          SizedBox(height: 15),

          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [

                _InputTitle(text: 'Identification'),
                SizedBox(height: 10),
                _Input(helpText: 'Example: 101110222', icon: Icons.badge, controller: _identificationController),

                SizedBox(height: 20),

                _InputTitle(text: 'Name'),
                SizedBox(height: 10),
                _Input(helpText: 'Example: Carlos', icon: Icons.person, controller: _nameController),

                SizedBox(height: 20),

                _InputTitle(text: 'Last name'),
                SizedBox(height: 10),
                _Input(helpText: 'Example: Pereira', icon: Icons.person, controller: _lastNameController),

                SizedBox(height: 20),

                _InputTitle(text: 'Email'),
                SizedBox(height: 10),
                _Input(helpText: 'Example: carlos@pereira.com', icon: Icons.mail, controller: _emailController),

                SizedBox(height: 20),

                _InputTitle(text: 'Phone Number'),
                SizedBox(height: 10),
                _Input(helpText: 'Example: 11112222', icon: Icons.phone, controller: _phoneController),

                SizedBox(height: 20),

                _SaveButton(
                  identification: _identificationController,
                  name: _nameController,
                  lastName: _lastNameController,
                  email: _emailController,
                  phone: _phoneController,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InputTitle extends StatelessWidget {

  final String text;

  const _InputTitle({
    Key? key, required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      padding: EdgeInsets.only(left: 20),
      child: TextCustom(  
        text: this.text,
        size: 15,
        font: FontWeight.bold,
        color: Colors.red.shade300,
      ),
    );
  }
}

class _Input extends StatelessWidget {

  final String helpText;
  final IconData icon;
  final TextEditingController controller;
  
  const _Input({
    Key? key, 
    required this.helpText, 
    required this.icon, 
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(  
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
          suffixIcon: Icon(this.icon, color: Colors.red.shade300),
          // focusColor: Colors.red.shade300
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  
  final TextEditingController identification;
  final TextEditingController name;
  final TextEditingController lastName;
  final TextEditingController email;
  final TextEditingController phone;

  const _SaveButton({
    Key? key, 
    required this.identification, 
    required this.name, 
    required this.lastName, 
    required this.email, 
    required this.phone,
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
          child: Text('Save', style: TextStyle(fontSize: 20, color: Colors.white))
        )
      ),
      onPressed: () async {

        final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);

        final newAgent = new Agent(
          name: this.name.text, 
          lastname: this.lastName.text, 
          email: this.email.text, 
          phone: this.phone.text, 
          identification: this.identification.text
        );

        final resp = await agentProvider.createAgent(newAgent);

        if(resp){
          print('Show alert with success message');
        } else {
          print('Show alert with error message');
        }
      }, 
    );
  }
}





