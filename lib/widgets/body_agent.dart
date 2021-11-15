
part of 'widgets.dart';


class BodyAgent extends StatelessWidget {

  const BodyAgent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context);
    
    return Stack(
      children: [

        BoxBackgroundBody(height: 880),

        _AgentCircleImage(),

        PictureButton(category: TypeCategory.Agents),
        
        Container(
          child: (agentProvider.updating ) 
                  ? DeleteButton(
                    category: TypeCategory.Agents, 
                    name: '${agentProvider.agent.name} ${agentProvider.agent.lastname}'
                  )
                  : Container(),
        ),

        _Content(agentProvider: agentProvider)

      ]
    );
  }
}

class _AgentCircleImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final agentPro = Provider.of<AgentManamegentProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 140, left: widthScreen * 0.35),
      child: (!agentPro.isChangePhoto) ? ImageAgent(
        wid: 100,
        hei: 100,
        networkImage: (agentPro.updating) 
                      ? (agentPro.agent.profileImage == 'no-image') ? false : true 
                      : false,
        urlImage: (agentPro.updating) 
                    ? (agentPro.agent.profileImage != 'no-image') 
                          ? agentPro.agent.profileImage ?? 'assets/no-image.jpg'
                          : 'assets/no-image.jpg'
                    : 'assets/no-image.jpg',
      ) : UploadImage(photo: agentPro.photo)
    );
  }
}

class _Content extends StatelessWidget {

  final AgentManamegentProvider agentProvider;

  const _Content({Key? key, required this.agentProvider}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    
    return Container(
      margin: EdgeInsets.only(top: 250),
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

          _Form(agentProvider: agentProvider),
        ],
      ),
    );
  }
}

class _Form extends StatelessWidget {

  final AgentManamegentProvider agentProvider;

  const _Form({
    required this.agentProvider, 
  });
    
  @override
  Widget build(BuildContext context) {

    // Create controller for eath input
    final  TextEditingController _identificationController = new TextEditingController();
    final  TextEditingController _nameController           = new TextEditingController();
    final  TextEditingController _lastNameController       = new TextEditingController();
    final  TextEditingController _emailController          = new TextEditingController();
    final  TextEditingController _phoneController          = new TextEditingController();

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          InputTitleCustom(text: 'Identification'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.identification : '', 
            helpText: 'Example: 101110222', 
            icon: Icons.badge, 
            controller: _identificationController, 
            enable: (agentProvider.updating) ? false : true
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.name : '',
            helpText: 'Example: Carlos', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Last name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.lastname : '',
            helpText: 'Example: Pereira', 
            icon: Icons.person, 
            controller: _lastNameController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Email'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.email : '',
            helpText: 'Example: carlos@pereira.com', 
            icon: Icons.mail, 
            controller: _emailController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Phone Number'),
          SizedBox(height: 10),
          CustomInput(
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

  void _createAgent(BuildContext context, AgentManamegentProvider provider) async {

    bool resp;
    String userID = await UserService.readUserID();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final newAgent = new Agent(
      name           : this.name.text, 
      lastname       : this.lastName.text, 
      email          : this.email.text, 
      phone          : this.phone.text, 
      identification : this.identification.text,
      userID         : userID
    );

    resp = await AgentService.createAgent(newAgent, userProvider.token);

    if(resp){
      if(provider.isChangePhoto){
        resp = await AgentService.uploadImage(newAgent.identification ?? '', provider.photo, userProvider.token);
      }

      if(resp) {
        provider.isChangePhoto = false;
        showAlert(
          context     : context, 
          title       : 'Success', 
          subTitle    : 'Successfully created agent', 
          urlImage    : 'assets/male-icon.jpg', 
          userName    : '${newAgent.name} ${newAgent.lastname}',
          status      : StatusAlert.Success,
          successPage : 'agent',
          cancelPage  : 'agentsOptions'
        );
      } else {

        showAlert(
          context  : context, 
          title    : 'Error', 
          subTitle : 'Failed to create an agent', 
          urlImage : 'assets/male-icon.jpg', 
          userName : '${newAgent.name} ${newAgent.lastname}',
          status   : StatusAlert.Error,
          successPage : 'agent',
          cancelPage  : 'agentsOptions'
        );  

      }
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to create an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Error,
        successPage : 'agent',
        cancelPage  : 'agentsOptions'
      );
    }
  }

  void _updateAgent(BuildContext context, AgentManamegentProvider provider) async {
    
    bool resp;
    Agent agent = provider.agent;
    String userID = await UserService.readUserID();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final newAgent = new Agent(
      name           : (this.name.text == '') ? agent.name : this.name.text, 
      lastname       : (this.lastName.text == '') ? agent.lastname : this.lastName.text,
      email          : (this.email.text == '') ? agent.email : this.email.text, 
      phone          : (this.phone.text == '') ? agent.phone : this.phone.text, 
      identification : (this.identification.text == '') ? agent.identification : this.identification.text,
      userID         : userID
    );

    resp = await AgentService.updateAgent(newAgent, userProvider.token);

    if(resp){

      if(provider.isChangePhoto){
        resp = await AgentService.uploadImage(newAgent.identification ?? '', provider.photo, userProvider.token);
      }

      if(resp) {
        provider.isChangePhoto = false;
        showAlert(
          context  : context, 
          title    : 'Success', 
          subTitle : 'Successfully updated agent', 
          urlImage : 'assets/male-icon.jpg', 
          userName : '${newAgent.name} ${newAgent.lastname}',
          status   : StatusAlert.Success,
          successPage : 'home',
          cancelPage  : 'create'
        );
      } else {
        showAlert(
          context  : context, 
          title    : 'Error', 
          subTitle : 'Failed to update an agent', 
          urlImage : 'assets/male-icon.jpg', 
          userName : '${newAgent.name} ${newAgent.lastname}',
          status   : StatusAlert.Error,
          successPage : 'home',
          cancelPage  : 'create'
        );  
      }
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to update an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Error,
        successPage : 'home',
        cancelPage  : 'create'
      );
    }
  }

  void createAndUpdateAgent(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);

    if(!agentProvider.updating) {
      _createAgent(context, agentProvider);
    } else {
      _updateAgent(context, agentProvider);      
    }
  }

}