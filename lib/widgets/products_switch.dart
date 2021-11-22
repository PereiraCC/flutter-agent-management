part of 'widgets.dart';

class ProductsSwitch extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final productsProvider = Provider.of<ProductProvider>(context);

    return Switch(
      activeColor: Colors.red.shade300,
      value: productsProvider.isAvailable, 
      onChanged: (value) => {
        if(!productsProvider.isAvailable){
          productsProvider.isAvailable = true
        } else {
          productsProvider.isAvailable = false
        }
      }
    );
  }
}