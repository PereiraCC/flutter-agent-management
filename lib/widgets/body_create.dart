
part of 'widgets.dart';


class BodyScreenCreate extends StatelessWidget {

  const BodyScreenCreate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    
    return Stack(
      children: [

        _BoxBackgroundBody(),

        _CircleImage(),

        _PictureIcon(),
        
        _DeleteIcon(agentProvider: agentProvider),

        _Content(agentProvider: agentProvider)

      ]
    );
  }
}

class _CircleImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final agentPro = Provider.of<AgentManamegentProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 100, left: widthScreen * 0.35),
      child: (!agentPro.changePhoto) ? ImageAgent(
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
  
  final AgentManamegentProvider agentProvider;

  const _DeleteIcon({Key? key, required this.agentProvider}) : super(key: key);
    
  @override
  Widget build(BuildContext context) {
    
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
        status   : StatusAlert.Success,
        successPage : 'home',
        cancelPage  : 'create'
      );
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to delete an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${agentProvider.agent.name} ${agentProvider.agent.lastname}',
        status   : StatusAlert.Error,
        successPage : 'home',
        cancelPage  : 'create'
      );
    }
  }
}

class _PictureIcon extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 150, left: widthScreen * 0.15),
      child: IconButton(
        icon: Icon(Icons.image, color: Colors.red.shade300),
        onPressed: () async {  
          await  _imageProcess(context);
        },  
      ),
    );
  }

  _imageProcess(BuildContext context) async {

    final agentPro = Provider.of<AgentManamegentProvider>(context, listen: false);

    final _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery
    );

    if (pickedFile?.path != null) {
      agentPro.photo = File(pickedFile!.path);
      agentPro.changePhoto = true;
    }

  }
}

class _Content extends StatelessWidget {

  final AgentManamegentProvider agentProvider;

  const _Content({Key? key, required this.agentProvider}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context, listen: false);
    
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

          _InputTitle(text: 'Identification'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.identification : '', 
            helpText: 'Example: 101110222', 
            icon: Icons.badge, 
            controller: _identificationController, 
            enable: (agentProvider.updating) ? false : true
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.name : '',
            helpText: 'Example: Carlos', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Last name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.lastname : '',
            helpText: 'Example: Pereira', 
            icon: Icons.person, 
            controller: _lastNameController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Email'),
          SizedBox(height: 10),
          CustomInput(
            hintText: (agentProvider.updating) ? agentProvider.agent.email : '',
            helpText: 'Example: carlos@pereira.com', 
            icon: Icons.mail, 
            controller: _emailController
          ),

          SizedBox(height: 20),

          _InputTitle(text: 'Phone Number'),
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

    final newAgent = new Agent(
      name: this.name.text, 
      lastname: this.lastName.text, 
      email: this.email.text, 
      phone: this.phone.text, 
      identification: this.identification.text
    );

    resp = await AgentService.createAgent(newAgent);

    if(resp){
      if(provider.changePhoto){
        resp = await AgentService.uploadImage(newAgent.identification ?? '', provider.photo);
      }

      if(resp) {
        provider.changePhoto = false;
        showAlert(
          context     : context, 
          title       : 'Success', 
          subTitle    : 'Successfully created agent', 
          urlImage    : 'assets/male-icon.jpg', 
          userName    : '${newAgent.name} ${newAgent.lastname}',
          status      : StatusAlert.Success,
          successPage : 'home',
          cancelPage  : 'create'
        );
      } else {

        showAlert(
          context  : context, 
          title    : 'Error', 
          subTitle : 'Failed to create an agent', 
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
        subTitle : 'Failed to create an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newAgent.name} ${newAgent.lastname}',
        status   : StatusAlert.Error,
        successPage : 'home',
        cancelPage  : 'create'
      );
    }
  }

  void _updateAgent(BuildContext context, AgentManamegentProvider provider) async {
    
    bool resp;
    Agent agent = provider.agent;

    final newAgent = new Agent(
      name: (this.name.text == '') ? agent.name : this.name.text, 
      lastname: (this.lastName.text == '') ? agent.lastname : this.lastName.text,
      email: (this.email.text == '') ? agent.email : this.email.text, 
      phone: (this.phone.text == '') ? agent.phone : this.phone.text, 
      identification: (this.identification.text == '') ? agent.identification : this.identification.text,
    );

    resp = await AgentService.updateAgent(newAgent);

    if(resp){

      if(provider.changePhoto){
        resp = await AgentService.uploadImage(newAgent.identification ?? '', provider.photo);
      }

      if(resp) {
        provider.changePhoto = false;
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