part of 'widgets.dart';

class ImageAgent extends StatelessWidget {

  final double hei;
  final double wid;
  final String urlImage;

  const ImageAgent({Key? key, 
    required this.hei,
    required this.wid,
    required this.urlImage
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.wid,
      height: this.hei,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(2.0),
      child: CircleAvatar(
        backgroundImage: AssetImage(this.urlImage),
        radius: 25.0,
      ),
    );
  }
}