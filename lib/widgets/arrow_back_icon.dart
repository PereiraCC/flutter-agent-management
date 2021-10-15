part of 'widgets.dart';

class ArrowBackIcon extends StatelessWidget {
    
  final double top, right, bottom, left;
  final Function onPressed;

  const ArrowBackIcon({
    Key? key, 
    required this.top, 
    required this.right, 
    required this.bottom, 
    required this.left,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: this.top, right: this.right, left: this.left, bottom: this.bottom),
      height: 40,
      width: 100,
      child: IconButton(
        padding: EdgeInsets.only(right: 50),
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => this.onPressed(),
      ),
    );
  }
}