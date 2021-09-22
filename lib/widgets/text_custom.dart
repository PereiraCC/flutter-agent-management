part of 'widgets.dart';

class TextCustom extends StatelessWidget {

  final String text;
  final double size;
  final Color color;
  final FontWeight font;

  const TextCustom({Key? key, 
    required this.text, 
    required this.size, 
    required this.font,
    required this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.text, 
      style: TextStyle(
        fontSize: this.size, 
        fontWeight: this.font, 
        color: this.color
      )
    );
  }
}