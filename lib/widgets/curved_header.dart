part of 'widgets.dart';

enum Screens {
  Sing,
  Create
}

class CurvedHeader extends StatelessWidget {

  final Screens screen;

  const CurvedHeader({Key? key, required this.screen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (this.screen == Screens.Create) ? 1080 : 0,
      width: double.infinity,
      child: CustomPaint(  
        painter: _HeaderCurvoPainter( screen ),
      ),
    );
  }
}

class _HeaderCurvoPainter extends CustomPainter {

  final Screens screen;

  const _HeaderCurvoPainter(this.screen);

  @override
  void paint(Canvas canvas, Size size) {

    final lapiz = new Paint();

    // Pencil property
    lapiz.color = Colors.red.shade300;
    lapiz.style =PaintingStyle.fill; //.fill .stroke
    lapiz.strokeWidth = 20;

    final path = new Path();

    // Drawing with the path and the pencil
    if(this.screen == Screens.Create) {

      path.lineTo(0, size.height * 0.30);
      path.quadraticBezierTo(size.width * 0.5, size.height * 0.40 ,size.width, size.height * 0.30);
      path.lineTo(size.width, 0);

    } else {

      path.lineTo(0, size.height * 0.75);
      path.quadraticBezierTo(size.width * 0.5, size.height * 0.85 ,size.width, size.height * 0);

    }

    canvas.drawPath(path, lapiz);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}