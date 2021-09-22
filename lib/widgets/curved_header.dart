part of 'widgets.dart';

class CurvedHeader extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      // Especificamos el canvas
      height: 1080,
      width: double.infinity,
      child: CustomPaint(  
        painter: _HeaderCurvoPainter(),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = new Paint();

    // Propiedades del lapiz
    lapiz.color = Colors.red.shade300;
    lapiz.style =PaintingStyle.fill; //.fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.30);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.40 ,size.width, size.height * 0.30);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}