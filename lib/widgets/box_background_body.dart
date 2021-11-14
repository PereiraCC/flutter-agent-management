part of 'widgets.dart';

class BoxBackgroundBody extends StatelessWidget {

  final double height;
  final double? top;
  final double? right;
  final double? left;
  
  const BoxBackgroundBody({
    Key? key, 
    required this.height, 
    this.top = 190, 
    this.right = 10, 
    this.left = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(  
      height: this.height,
      margin: EdgeInsets.only(top: this.top ?? 190, right: this.right ?? 10, left: this.left ?? 10),
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