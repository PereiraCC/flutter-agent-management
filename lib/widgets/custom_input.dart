part of 'widgets.dart';

class CustomInput extends StatelessWidget {

  final String helpText;
  final String? hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool? enable;
  final bool? isPassword;
  
  const CustomInput({
    Key? key, 
    required this.helpText, 
    required this.icon, 
    required this.controller,
    this.enable = true,
    this.hintText = '',
    this.isPassword = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(  
        controller: this.controller,
        textCapitalization: TextCapitalization.sentences,
        autofocus: false,
        cursorColor: Colors.red.shade300,
        obscureText: this.isPassword ?? false,
        decoration: InputDecoration( 
          focusedBorder: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.red.shade300, width: 2.0)
          ),
          border: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(15.0),
          ),
          helperText: this.helpText,
          hintText: this.hintText,
          prefixIcon: Icon(this.icon, color: Colors.red.shade300),
          enabled: this.enable ?? true
        ),
      ),
    );
  }
}