part  of 'widgets.dart';

class NoData extends StatelessWidget {
  
  final String title;
  final String subtitle;
  final String secondSubtitle;

  const NoData({
    Key? key, 
    required this.title, 
    required this.subtitle, 
    required this.secondSubtitle
  }) : super(key: key);

 @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;
    
    return Stack(
      children: [
        
        _BoxBackground(),

        // Circle avatar
        Container(
          margin: EdgeInsets.only(top: 40, left: widthScreen * 0.37 ),
          child: ImageAgent(
            wid: 100,
            hei: 100,
            urlImage: 'assets/male-icon.jpg',
          )
        ),

        _Labels(title: this.title, subtitle: this.subtitle, secondSubtitle: this.secondSubtitle)

      ] ,
    );
  }
}

class _Labels extends StatelessWidget {

  final String title;
  final String subtitle;
  final String secondSubtitle;

  const _Labels({
    Key? key, 
    required this.title,
    required this.subtitle, 
    required this.secondSubtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 150),
      width: 400,
      child: Column(
        children: [

          TextCustom(  
            text: this.title,
            size: 20,
            font: FontWeight.bold,
            color: Colors.red.shade300,
          ),

          SizedBox(height: 10),

          TextCustom(  
            text: this.subtitle,
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),

          Divider(thickness: 1, height: 20, endIndent: 40, indent: 40),

          TextCustom(  
            text: this.secondSubtitle,
            size: 15,
            font: FontWeight.normal,
            color: Colors.grey
          ),
        ]
      )
    );
  }
}

class _BoxBackground extends StatelessWidget {
  
  const _BoxBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: 200,
      margin: EdgeInsets.only(top: 80, right: 10, left: 10),
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