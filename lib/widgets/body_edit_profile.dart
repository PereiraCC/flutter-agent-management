part of 'widgets.dart';


class BodyEditProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(

      children: [

        _Back(),

        _Image(),

        _Picture(),

        _ContentCustom()

      ],

    );
  }
}

class _Back extends StatelessWidget {

  const _Back({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 800,
      margin: EdgeInsets.only(top: 190, right: 10, left: 10),
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

class _Image extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 140, left: widthScreen * 0.35),
      child: (!userProvider.isChangePhoto) 
        ? ImageAgent(
          wid: 100,
          hei: 100,
          networkImage: (userProvider.user.profileImage == null) ? false : true,
          urlImage: (userProvider.user.profileImage == null) ? 'assets/no-image.jpg' : userProvider.user.profileImage ?? '',
        )
        : UploadImage(photo: userProvider.photo)
    );
  }
}

class _Picture extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 190, left: widthScreen * 0.15),
      child: IconButton(
        icon: Icon(Icons.image, color: Colors.red.shade300),
        onPressed: () async {
          await _imageProcess(context);
        }
      ),
    );
  }

  _imageProcess(BuildContext context) async {

    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery
    );

    if (pickedFile?.path != null) {
      userProvider.photo = File(pickedFile!.path);
      userProvider.isChangePhoto = true;
    }

  }
}

class _ContentCustom extends StatelessWidget {

  const _ContentCustom({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.only(top: 250),
      width: 400,
      child: Column(
        children: [

          // Title
          TextCustom( 
            text: 'Edit Profile',
            size: 20,
            font: FontWeight.bold,
            color: Colors.red.shade300,
          ),

          SizedBox(height: 10),

          // SubTitle
          TextCustom(
            text: 'Please complete your information',
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),

          Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

          SizedBox(height: 15),

          _FormProfile(),
        ],
      ),
    );
  }
}

class _FormProfile extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<UserProvider>(context, listen: false).user;

    // Create controller for eath input
    final  TextEditingController _nameController    = new TextEditingController();
    final  TextEditingController _passworController = new TextEditingController();

    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [

          InputTitleCustom(text: 'Identification'),
          SizedBox(height: 10),
          CustomInput(
            hintText: user.identification ?? '', 
            helpText: 'Example: 101110222', 
            icon: Icons.badge, 
            enable: false
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Full Name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: user.name ?? '',
            helpText: 'Example: Carlos', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Email'),
          SizedBox(height: 10),
          CustomInput(
            hintText: user.email ?? '',
            helpText: 'Example: carlos@pereira.com', 
            icon: Icons.mail,
            enable: false 
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Password'),
          SizedBox(height: 10),
          CustomInput(
            hintText: '**************',
            helpText: '', 
            isPassword: true,
            icon: Icons.password, 
            controller: _passworController,
            enable: (user.identification == 'google-id') ? false : true,
          ),

          SizedBox(height: 20),

          _SaveProfile(
            name     : _nameController,
            password : _passworController,
          )
        ],
      ),
    );
  }
}

class _SaveProfile extends StatelessWidget {

  final TextEditingController name;
  final TextEditingController password;

  const _SaveProfile({
    Key? key, 
    required this.name, 
    required this.password
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return TextButton(
      child: Container(
        width: 250,
        height: 50,
        decoration: BoxDecoration(  
          color: ( !userProvider.isUpdate ) ? Colors.red.shade300 : Colors.grey,
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
      onPressed:  ( !userProvider.isLogin ) ? () => _updateUser(context, userProvider) : null,
    );
  }

   void _updateUser(BuildContext context, UserProvider provider) async {
    
    provider.isUpdate = true;
    bool resp;
    User user = provider.user;

    final newUser = new User(
      identification : user.identification,
      name           : (this.name.text == '') ? user.name : this.name.text, 
      email          : user.email,
      password       : (this.password.text == '') ? user.password : this.password.text,
    );

    resp = await UserService.updateUser(context, newUser);

    if(resp){

      if(provider.isChangePhoto){
        resp = await UserService.uploadImageUser(newUser.identification ?? '', provider.photo, provider.token);
      }

      if(resp) {
        UserService.readUser(context);
        provider.isChangePhoto = false;
        provider.isUpdate = false;
        showAlert(
          context  : context, 
          title    : 'Success', 
          subTitle : 'Successfully updated agent', 
          urlImage : 'assets/male-icon.jpg', 
          userName : '${newUser.name}',
          status   : StatusAlert.Success,
          successPage : 'home',
          cancelPage  : 'editProfile'
        );
      } else {
        showAlert(
          context  : context, 
          title    : 'Error', 
          subTitle : 'Failed to update an agent', 
          urlImage : 'assets/male-icon.jpg', 
          userName : '${newUser.name}',
          status   : StatusAlert.Error,
          successPage : 'home',
          cancelPage  : 'editProfile'
        );  
      }
    } else {
      showAlert(
        context  : context, 
        title    : 'Error', 
        subTitle : 'Failed to update an agent', 
        urlImage : 'assets/male-icon.jpg', 
        userName : '${newUser.name}',
        status   : StatusAlert.Error,
        successPage : 'home',
        cancelPage  : 'editProfile'
      );
    }
  }

}