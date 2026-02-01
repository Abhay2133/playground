import 'package:flutter/material.dart';

class DrawingPainter extends CustomPainter {
  final List<List<Offset>> strokes;

  DrawingPainter({required this.strokes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (final stroke in strokes) {
      if (stroke.length < 2) {
        // Single tap: draw a dot
        if (stroke.isNotEmpty) {
          canvas.drawCircle(stroke.first, paint.strokeWidth / 2, paint);
        }
        continue;
      }

      // Build a path from the stroke points
      final path = Path()..moveTo(stroke.first.dx, stroke.first.dy);
      for (int i = 1; i < stroke.length; i++) {
        path.lineTo(stroke[i].dx, stroke[i].dy);
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    // Repaint whenever stroke data changes
    return oldDelegate.strokes != strokes;
  }
}
