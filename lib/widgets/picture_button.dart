part of 'widgets.dart';

class PictureButton extends StatelessWidget {

  final TypeCategory category;
  final double? top;

  const PictureButton({
    Key? key, 
    required this.category, 
    this.top = 190
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: this.top ?? 190, left: widthScreen * 0.15),
      child: IconButton(
        icon: Icon(Icons.image, color: Colors.red.shade300),
        onPressed: () async {  
          await  _imageProcess(context);
        },  
      ),
    );
  }

  _imageProcess(BuildContext context) async {

    var provider;
    
    switch (this.category) {
      case TypeCategory.Agents:
        provider = Provider.of<AgentManamegentProvider>(context, listen: false);
        break;

      case TypeCategory.Products:
        provider = Provider.of<ProductProvider>(context, listen: false);
        break;

      case TypeCategory.Users:
        provider = Provider.of<UserProvider>(context, listen: false);
        break;
      
      default:
    }
    

    final _picker = ImagePicker();

    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery
    );

    if (pickedFile?.path != null) {
      provider.photo = File(pickedFile!.path);
      provider.isChangePhoto = true;
    }

  }
}