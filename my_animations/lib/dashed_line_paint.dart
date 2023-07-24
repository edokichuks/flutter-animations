import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpacing;

  DashedLinePainter({
    required this.color,
    this.dashWidth = 5.0,
    this.dashSpacing = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    print('data size ${size.height}, ${size.width}');
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final dashCount = (size.width / (dashWidth + dashSpacing)); //.floor();

    for (int i = 0; i < dashCount; i++) {
      final startX = i * (dashWidth + dashSpacing);
      canvas.drawLine(
        Offset(startX, size.height / 2),
        Offset(startX + dashWidth, size.height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedLine extends StatelessWidget {
  final Color color;

  const DashedLine({Key? key, this.color = Colors.red}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.5,
      width: MediaQuery.sizeOf(context).width,
      child: CustomPaint(
        painter: DashedLinePainter(color: color),
      ),
    );
  }
}

// Usage
// Use the DashedLine widget wherever you want to display the dashed horizontal line.

// Example:
// DashedLine(
//   color: Colors.blue,
// ),
