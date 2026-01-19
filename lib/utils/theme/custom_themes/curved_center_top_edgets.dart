import 'package:flutter/material.dart';

class CustomCurvedCenterTopEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start top-left
    path.lineTo(0, size.height - 60);

    // Left bottom curve
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.5,
      size.height,
    );

    // Right bottom curve
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height,
      size.width,
      size.height - 60,
    );

    // Go up to top-right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
