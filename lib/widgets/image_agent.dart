part of 'widgets.dart';

class ImageAgent extends StatelessWidget {

  final double hei;
  final double wid;
  final bool? networkImage;
  final String urlImage;

  const ImageAgent({Key? key, 
    required this.hei,
    required this.wid,
    required this.urlImage, 
    this.networkImage = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.wid,
      height: this.hei,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(2.0),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey.shade300,
        child: ClipOval(  
          child: (networkImage == true) 
                  ? _NetworkPicture(urlImage: urlImage, wid: this.hei,)
                  : _AssetPicture(urlImage: urlImage, wid: this.hei),
        ),
      ),
    );
  }
}

class _AssetPicture extends StatelessWidget {
  const _AssetPicture({
    Key? key,
    required this.urlImage,
    required this.wid,
  }) : super(key: key);

  final String urlImage;
  final double wid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image(
        image: AssetImage(this.urlImage),
        width: this.wid,
        height: 100,
        fit: BoxFit.cover,
      )
    );
  }
}

class _NetworkPicture extends StatelessWidget {

  const _NetworkPicture({
    Key? key,
    required this.urlImage, 
    required this.wid,
  }) : super(key: key);

  final String urlImage;
  final double wid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child : FadeInImage(
        placeholder: AssetImage('assets/loading.gif'),
        image: NetworkImage(this.urlImage),
        width: this.wid,
        height: 100,
        fit: BoxFit.cover,
      )
    );
  }
}