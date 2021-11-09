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

    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 140, left: widthScreen * 0.35),
      child: ImageAgent(
        wid: 100,
        hei: 100,
        networkImage: false,
        urlImage: 'assets/no-image.jpg',
      )
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
        onPressed: () {}
      ),
    );
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
            hintText: '', 
            helpText: 'Example: 101110222', 
            icon: Icons.badge, 
            enable: false
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Full Name'),
          SizedBox(height: 10),
          CustomInput(
            hintText: '',
            helpText: 'Example: Carlos', 
            icon: Icons.person, 
            controller: _nameController
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Email'),
          SizedBox(height: 10),
          CustomInput(
            hintText: '',
            helpText: 'Example: carlos@pereira.com', 
            icon: Icons.mail,
            enable: false 
          ),

          SizedBox(height: 20),

          InputTitleCustom(text: 'Password'),
          SizedBox(height: 10),
          CustomInput(
            hintText: '',
            helpText: '', 
            isPassword: true,
            icon: Icons.password, 
            controller: _passworController
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
      onPressed: () => {}
    );
  }

}