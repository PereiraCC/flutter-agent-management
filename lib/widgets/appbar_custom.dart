part of 'widgets.dart'; 

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {

  AppBarCustom() : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  _AppBarCustomState createState() => _AppBarCustomState();

  @override
  final Size preferredSize;
}

class _AppBarCustomState extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(  
      title: Text('Create Agent', style: TextStyle(color: Colors.red.shade300)),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 10.0,
      leading: Icon(Icons.menu, color: Colors.red.shade300),
      // toolbarHeight: 500,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.red.shade300),
          onPressed: () {
            print('search button');
          }
        ),
      ],
    );
  }
}