part of 'widgets.dart';

class UploadImage extends StatelessWidget {

  final File photo;

  const UploadImage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width:  100,
      height: 100,
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(2.0),
      child: CircleAvatar(
        radius: 50.0,
        backgroundColor: Colors.grey.shade300,
        child: ClipOval(  
          child: Image.file(
            photo,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
        ),
      )
    );
  }
}