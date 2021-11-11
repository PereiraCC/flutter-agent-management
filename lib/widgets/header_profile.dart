part of 'widgets.dart';

class HeaderProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children :[
        Container(
          child: CurvedHeader( screen: Screens.Create )
        ),
        
        _ProfileTitle()
      ] 
    );
  }
}

class _ProfileTitle extends StatelessWidget {

  const _ProfileTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final userProvider = Provider.of<UserProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ArrowBackIcon(
          top       : 50, 
          right     : 0, 
          bottom    : 0, 
          left      : 10, 
          onPressed : () {
            userProvider.isChangePhoto = false;
            Navigator.pushNamed(context, 'home');
          } 
        ),

        // Title
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text('Edit Profile', 
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

