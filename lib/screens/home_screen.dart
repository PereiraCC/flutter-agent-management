import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:agent_management/widgets/widgets.dart';
import 'package:agent_management/providers/user_provider.dart';
// import 'package:agent_management/services/user_service.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Management', Tabs.Home),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(  
            children: [
        
              _Header(),
        
              _Body(),
        
            ],
          ),
        )
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

    final user = Provider.of<UserProvider>(context, listen: false).user;
    final size = MediaQuery.of(context).size;

    return Container(
      // color: Colors.red,
      height: 150,
      margin: EdgeInsets.all(10),
      child: Row(  
        children: [

          // message and name
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: [

                Container(
                  // color: Colors.green,
                  height: 100,
                  width: size.width - 140,
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        width: 280,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          greeting(),
                          style: TextStyle(  
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),

                      SizedBox(height: 10),

                      Container(
                        width: 280,
                        child:  Text(
                          user.name ?? 'No name',
                          style: TextStyle(  
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ),

                    ],
                  ),
                ),
              ]
            ),
          ),

          // Picture
          Container(
            child: ImageAgent(
              hei: 80, 
              wid: 80, 
              networkImage: (user.profileImage != null) ? true : false,
              urlImage: user.profileImage ?? 'assets/no-image.jpg'
            ),
            

          ),

        ],
      ),
    );
  }

  String greeting() {

    final hour = DateTime.now().hour;
    
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }

  }
}

class _Body extends StatelessWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      // color: Colors.red,
      margin: EdgeInsets.all(10),
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Message
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              'My Company Management', 
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 25),
        
          // Widget Card
          _CategoryCard(
            color: Colors.blue.shade50,
            urlImage: 'assets/agents.jpg',
            title: 'Agents',
            subtitle: 'Total 6 Agents',
            text: 'Management your agents',
            event: () => Navigator.pushNamed(context, 'agent'),
          ),

          SizedBox(height: 20),

          _CategoryCard(
            color: Colors.purple.shade50,
            urlImage: 'assets/products.jpg',
            title: 'Products',
            subtitle: 'Total 5 Products',
            text: 'Management your products',
            event: () => Navigator.pushNamed(context, 'agent'),
          ),

          SizedBox(height: 20),

          _CategoryCard(
            color: Colors.orange.shade50,
            urlImage: 'assets/users.jpg',
            title: 'Profile',
            subtitle: 'Carlos Pereira',
            text: 'Management your account',
            event: () => Navigator.pushNamed(context, 'agent'),
          ),

          SizedBox(height: 20),

        ],
      ),

    );
  }
}

class _CategoryCard extends StatelessWidget {

  final Color color;
  final String urlImage;
  final String title;
  final String subtitle;
  final String text;
  final Function event;

  const _CategoryCard({
    Key? key, 
    required this.color, 
    required this.urlImage, 
    required this.title, 
    required this.subtitle, 
    required this.text, 
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(left: 10),
        height: 175,
        width: size.width - 25,
        decoration: BoxDecoration(  
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(  
          children: [
    
            // Image
            Container(
              height: 80,
              width: 100,
              // color: Colors.green,
              margin: EdgeInsets.only(left: 20, bottom: 70),
              child: ImageAgent(
                hei: 70, 
                wid: 70, 
                urlImage: this.urlImage
              ),
            ),
    
            // Text
            Container(
              width: size.width - 165,
              height: 162,
              // color: Colors.green,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [
    
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      this.title,
                      style: TextStyle( 
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
    
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      this.subtitle,
                      style: TextStyle( 
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
    
                  SizedBox(height: 8),
    
                  Container(
                    margin: EdgeInsets.all(10),
                    // color: Colors.green,
                    child: Text(
                      this.text,
                      style: TextStyle( 
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
    
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () { this.event(); }
    );
  }
}
