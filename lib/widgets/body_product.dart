part of 'widgets.dart';


class BodyProduct extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final productProvider = Provider.of<ProductProvider>(context);

    return Stack(
      children: [

        BoxBackgroundBody(height: 800),

        _ProductCircleImage(),

        PictureButton(category: TypeCategory.Products),
        
        Container(
          child: (productProvider.isUpdating ) 
                  ? DeleteButton(
                    category: TypeCategory.Products, 
                    name: '${productProvider.product.title}'
                  )
                  : Container(),
        ),

        // _Content(agentProvider: agentProvider)

      ]
    );
  }
}

class _ProductCircleImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final agentPro = Provider.of<AgentManamegentProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: 140, left: widthScreen * 0.35),
      child: (!agentPro.isChangePhoto) ? ImageAgent(
        wid: 100,
        hei: 100,
        networkImage: (agentPro.updating) 
                      ? (agentPro.agent.profileImage == 'no-image') ? false : true 
                      : false,
        urlImage: (agentPro.updating) 
                    ? (agentPro.agent.profileImage != 'no-image') 
                          ? agentPro.agent.profileImage ?? 'assets/no-image.jpg'
                          : 'assets/no-image.jpg'
                    : 'assets/no-image.jpg',
      ) : UploadImage(photo: agentPro.photo)
    );
  }
}