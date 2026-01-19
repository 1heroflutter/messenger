import 'package:flutter/material.dart';

class CustomCurvedRightTopEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start top-left
    path.lineTo(0, size.height - 80);

    // Bottom left curve
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.55,
      size.height,
    );

    // Bottom right curve
    path.quadraticBezierTo(
      size.width * 0.90,
      size.height,
      size.width,
      size.height - 80,
    );

    // Go to top-right
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
