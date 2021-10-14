part of 'widgets.dart';

class CustomSingleButton extends StatelessWidget {

  final String title;
  final Function onPressed;

  const CustomSingleButton({
    Key? key, 
    required this.title, 
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Container(
        width: 450,
        height: 50,
        decoration: BoxDecoration(  
          color: Colors.white,
          border: Border.all(color: Colors.red.shade300),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Center(
          child: Text(this.title, style: TextStyle(fontSize: 15, color: Colors.red.shade300))
        )
      ),
      onPressed: () => this.onPressed()
    );
  }
}