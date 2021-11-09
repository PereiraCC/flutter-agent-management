part of 'widgets.dart';


class InputTitleCustom extends StatelessWidget {

  final String text;

  const InputTitleCustom({
    Key? key, required this.text,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 20),
      child: TextCustom(  
        text: this.text,
        size: 15,
        font: FontWeight.bold,
        color: Colors.red.shade300,
      ),
    );
  }
}