import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final Color color;

  DashedBorderPainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0) // Top line
      ..lineTo(size.width, size.height) // Right line
      ..lineTo(0, size.height) // Bottom line
      ..close();

    final dashCount = (size.width / (dashWidth + dashSpace)).floor();
    print('dashcount $dashCount');
    for (int i = 0; i < dashCount; i++) {
      final startX = i * (dashWidth + dashSpace);
      final endX = startX + dashWidth;
      final dash = Path()
        ..moveTo(startX, 0)
        ..lineTo(endX, 0);

      canvas.drawPath(dash, paint);
      
      

      canvas.drawPath(dash.shift(Offset(0, size.height)), paint);
    }
    final dashCountY = (size.height / (dashWidth + dashSpace)).floor();
    print('dashcount $dashCountY');
    for (int i = 0; i < dashCountY; i++) {
      final startX = i * (dashWidth + dashSpace);
      final endX = startX + dashWidth;
      final dash = Path()
        ..moveTo(0, startX)
        ..lineTo(0, endX);

      canvas.drawPath(dash, paint);

      canvas.drawPath(dash.shift(Offset(size.width, 0)), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedBorder extends StatelessWidget {
  final Widget child;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedBorder({
    Key? key,
    required this.child,
    this.dashWidth = 5.0,
    this.dashSpace = 5.0,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        color: color,
      ),
      child: child,
    );
  }
}

// Usage
// Use the DashedBorder widget to wrap the desired content in a container with dashed border.

// Example:
// DashedBorder(
//   dashWidth: 4.0,
//   dashSpace: 4.0,
//   color: Colors.blue,
//   child: Container(
//     width: 200,
//     height: 100,
//     color: Colors.white,
//     child: Text('Dashed Border'),
//   ),
// ),
