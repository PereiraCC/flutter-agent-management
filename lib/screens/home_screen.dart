import 'package:flutter/material.dart';

import 'package:agent_management/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom('Management', Tabs.Home),
      body: Container(
        child: Column(  

          children: [

            // Header
            _Header()

          ],

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
                  width: 250,
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
                          'Carlos Pereira',
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
              networkImage: true,
              urlImage: 'https://lh3.googleusercontent.com/a-/AOh14GjYi1RFAcHsx-ptoaBkTWPTzNpJgcJ35mwvbwrwuw=s96-c'
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