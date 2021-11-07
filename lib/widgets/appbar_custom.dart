part of 'widgets.dart'; 

enum Tabs {
  Home,
  Agents,
  Products,
  Profile
}

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {

  final String title;
  final Tabs screen;

  AppBarCustom(this.title, this.screen) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  _AppBarCustomState createState() => _AppBarCustomState(this.title, this.screen);

  @override
  final Size preferredSize;
}

class _AppBarCustomState extends State<StatefulWidget> {

  final String title;
  final Tabs screen;

  _AppBarCustomState(this.title, this.screen);

  @override
  Widget build(BuildContext context) {

    return AppBar(  
      title: Text('${this.title}', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.red.shade300,
      elevation: 10.0,
      leading: (this.screen == Tabs.Home) 
      ? IconButton(
        icon: Icon(Icons.login_outlined, color: Colors.white),
        onPressed: () {
          UserService.logout();
          Navigator.pushReplacementNamed(context, 'login');
        },  
      )
      : IconButton( 
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },  
      ),
      // toolbarHeight: 500,
      actions: [

        (this.screen != Tabs.Home) 
          ? IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context, 
                delegate: DataSearch()
              );
            }
          )
          : IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              print('button menu');
            }
          )
      ],
    );
  }
}