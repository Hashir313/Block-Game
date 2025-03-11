// 🌿 Leaf Class for Animation
import 'dart:math';

import 'package:flutter/material.dart';

class Leaf {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double size = Random().nextDouble() * 15 + 5;
  double speed = Random().nextDouble() * 2 + 1;
  double angle = Random().nextDouble() * 360;
}

// 🍃 Falling Leaves Painter
class FallingLeavesPainter extends CustomPainter {
  List<Leaf> leaves;
  double animationValue;

  FallingLeavesPainter(this.leaves, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.brown.shade700;

    for (var leaf in leaves) {
      double newY = leaf.y + (leaf.speed * animationValue * 10);
      if (newY > size.height) {
        newY = 0; // Reset leaf position
      }
      canvas.drawOval(
        Rect.fromLTWH(leaf.x, newY, leaf.size, leaf.size / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FallingLeavesPainter oldDelegate) => true;
}
