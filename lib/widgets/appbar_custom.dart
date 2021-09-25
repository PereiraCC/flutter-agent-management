part of 'widgets.dart'; 

class AppBarCustom extends StatefulWidget implements PreferredSizeWidget {

  final String title;

  AppBarCustom(this.title) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  _AppBarCustomState createState() => _AppBarCustomState(this.title);

  @override
  final Size preferredSize;
}

class _AppBarCustomState extends State<StatefulWidget> {

  final String title;

  _AppBarCustomState(this.title);

  @override
  Widget build(BuildContext context) {

    final agentProvider = Provider.of<AgentManamegentProvider>(context);

    return AppBar(  
      title: Text('${this.title} (${agentProvider.countAgent})', style: TextStyle(color: Colors.white)),
      centerTitle: true,
      backgroundColor: Colors.red.shade300,
      elevation: 10.0,
      leading: Icon(Icons.menu, color: Colors.white),
      // toolbarHeight: 500,
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {
            showSearch(
              context: context, 
              delegate: DataSearch()
            );
            print('search button');
          }
        ),
      ],
    );
  }
}