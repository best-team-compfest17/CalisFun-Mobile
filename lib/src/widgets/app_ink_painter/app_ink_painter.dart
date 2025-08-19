import 'package:flutter/material.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart'
as ml;

class InkCanvas extends StatelessWidget {
  const InkCanvas({
    super.key,
    required this.strokes,
    this.currentStroke,
    this.strokeColor = Colors.black,
    this.strokeWidth = 6.0,
  });

  final List<ml.Stroke> strokes;
  final ml.Stroke? currentStroke;

  final Color strokeColor;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: InkPainter(
          strokes: strokes,
          currentStroke: currentStroke,
          strokeColor: strokeColor,
          strokeWidth: strokeWidth,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class InkPainter extends CustomPainter {
  InkPainter({
    required this.strokes,
    required this.currentStroke,
    this.strokeColor = Colors.black,
    this.strokeWidth = 6.0,
  });

  final List<ml.Stroke> strokes;
  final ml.Stroke? currentStroke;

  final Color strokeColor;
  final double strokeWidth;

  late final Paint _paint = Paint()
    ..color = strokeColor
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    void draw(ml.Stroke s) {
      final pts = s.points;
      if (pts.length < 2) return;

      final path = Path()..moveTo(pts.first.x, pts.first.y);
      for (var i = 1; i < pts.length; i++) {
        path.lineTo(pts[i].x, pts[i].y);
      }
      canvas.drawPath(path, _paint);
    }

    for (final s in strokes) {
      draw(s);
    }
    if (currentStroke != null) {
      draw(currentStroke!);
    }
  }

  @override
  bool shouldRepaint(covariant InkPainter old) =>
      !identical(old.strokes, strokes) ||
          old.currentStroke != currentStroke ||
          old.strokeColor != strokeColor ||
          old.strokeWidth != strokeWidth;
}
