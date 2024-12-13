import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class PieChart extends CustomPainter {
  PieChart({
    required this.width,
    required this.buckets,
  });

  final List<ExpenseBucket> buckets;
  final double width;
  

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width/2, size.height/2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width/2;

    double total = buckets.fold(0, (sum, bucket) => sum + bucket.totalExpenses);
    double startRadian = -pi/2;

    for (var index = 0; index < buckets.length; index++) {
      var bucket = buckets[index];
      // Amount of length to paint is a percentage of the perimeter of a circle (2 x pi)
      final sweepRadian = bucket.totalExpenses / total * 2 * pi;
      paint.color = categoryColors[bucket.category]!;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        sweepRadian,
        false,
        paint,
      );
      startRadian += sweepRadian;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
