
part of 'widgets.dart';

class BodyScreenCreate extends StatelessWidget {

  const BodyScreenCreate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Stack(
      children: [

        _BoxBackgroundBody(),

        // Circle Image
        Container(
          margin: EdgeInsets.only(top: 100, left: widthScreen * 0.35),
          child: ImageAgent(
            wid: 100,
            hei: 100,
            urlImage: 'assets/male-icon.jpg',
          )
        ),

        _PictureIcon(),
        
        _DeleteIcon(),

        _Content()

      ]
    );
  }
}

class _BoxBackgroundBody extends StatelessWidget {
  const _BoxBackgroundBody({
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

class _DeleteIcon extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    
    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    final widthScreen = MediaQuery.of(context).size.width;
    
    return Container(
      height: 50,
      margin: EdgeInsets.only(top: 150, left: widthScreen - 80),
      child: (agentProvider.updating) ? IconButton(
        icon: Icon(Icons.delete, color: Colors.red.shade300),
        onPressed: () {
          showConfirmationAlert(
            context: context,
            title: 'Delete an agent',
            subtitle: 'Do you want to remove this agent?',
            urlImage: 'assets/male-icon.jpg',
            userName: '${agentProvider.agent.name} ${agentProvider.agent.lastname}',
            continueEvent: () async => deleteAgent(context),
            cancelEvent: () => Navigator.pop(context)
          );
        }, 
      )
      : Container()
    );
  }

  void deleteAgent(BuildContext context) async {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    final resp = await AgentService.deleteAgent(agentProvider.agent.identification ?? 'no-identification');

    if(agentProvider.updating) 
        agentProvider.updating = false;

    if(resp){
      showAlert(
        context  : context, 
        title    : 'Success', 
        subTitle : 'Successfully deleted agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${agentProvider.agent.name} ${agentProvider.agent.lastname}',
        status   : StatusAlert.Success
      );
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to delete an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${agentProvider.agent.name} ${agentProvider.agent.lastname}',
        status   : StatusAlert.Error
      );
    }
  }
}

class _PictureIcon extends StatelessWidget {

  const _PictureIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 150, left: widthScreen - 320),
      child: IconButton(
        icon: Icon(Icons.image, color: Colors.red.shade300),
        onPressed: () {  
          print('image button');
        },  
      ),
    );
  }
}

class _Content extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context);
    
    return Container(
      margin: EdgeInsets.only(top: 210),
      width: 400,
      child: Column(
        children: [

          // Title
          TextCustom( 
            text: (agentProvider.updating) ? 'Update Agent' :'New Agent',
            size: 20,
            font: FontWeight.bold,
            color: Colors.red.shade300,
          ),

          SizedBox(height: 10),

          // SubTitle
          TextCustom(
            text: (agentProvider.updating) ? '${agentProvider.agent.email}' : 'Please complete the agent information',
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),

          Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

          SizedBox(height: 15),

          _Form(),
        ],
      ),
    );
  }
}

class _Form extends StatelessWidget {
  
  // Create controller for eath input
  final TextEditingController _identificationController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
    
  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context);

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          _InputTitle(text: 'Identification'),
          SizedBox(height: 10),
          _Input(
            hintText: (agentProvider.updating) ? agentProvider.agent.identification : '', 
            helpText: 'Example: 101110222', 
            icon: Icons.badge, 
            controller: _identificationController, 
            enable: (agentProvider.updating) ? false : true
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Name'),
          SizedBox(height: 10),
          _Input(
            hintText: (agentProvider.updating) ? agentProvider.agent.name : '',
            helpText: 'Example: Carlos', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Last name'),
          SizedBox(height: 10),
          _Input(
            hintText: (agentProvider.updating) ? agentProvider.agent.lastname : '',
            helpText: 'Example: Pereira', 
            icon: Icons.person, 
            controller: _lastNameController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Email'),
          SizedBox(height: 10),
          _Input(
            hintText: (agentProvider.updating) ? agentProvider.agent.email : '',
            helpText: 'Example: carlos@pereira.com', 
            icon: Icons.mail, 
            controller: _emailController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Phone Number'),
          SizedBox(height: 10),
          _Input(
            hintText: (agentProvider.updating) ? agentProvider.agent.phone : '',
            helpText: 'Example: 11112222', 
            icon: Icons.phone, 
            controller: _phoneController
          ),

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
          hintText: this.hintText,
          suffixIcon: Icon(this.icon, color: Colors.red.shade300),
          enabled: this.enable ?? true
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
      onPressed: () => createAndUpdateAgent(context)
    );
  }

  void _createAgent(BuildContext context) async {

    bool resp;

    final newAgent = new Agent(
      name: this.name.text, 
      lastname: this.lastName.text, 
      email: this.email.text, 
      phone: this.phone.text, 
      identification: this.identification.text
    );

    resp = await AgentService.createAgent(newAgent);

    if(resp){
      showAlert(
        context  : context, 
        title    : 'Success', 
        subTitle : 'Successfully created agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Success
      );
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to create an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Error
      );
    }
  }

  void _updateAgent(BuildContext context, Agent agent) async {

    bool resp;

    final newAgent = new Agent(
      name: (this.name.text == '') ? agent.name : this.name.text, 
      lastname: (this.lastName.text == '') ? agent.lastname : this.lastName.text,
      email: (this.email.text == '') ? agent.email : this.email.text, 
      phone: (this.phone.text == '') ? agent.phone : this.phone.text, 
      identification: (this.identification.text == '') ? agent.identification : this.identification.text,
    );

    resp = await AgentService.updateAgent(newAgent);

    if(resp){
      showAlert(
        context  : context, 
        title    : 'Success', 
        subTitle : 'Successfully updated agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Success
      );
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to update an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Error
      );
    }
  }

  void createAndUpdateAgent(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);

    if(!agentProvider.updating) {
      _createAgent(context);
    } else {
      _updateAgent(context, agentProvider.agent);      
    }
  }

}