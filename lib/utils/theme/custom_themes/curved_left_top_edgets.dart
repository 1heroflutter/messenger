import 'package:flutter/material.dart';

class CustomCurvedLeftTopEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final curveHeight = size.height * 0.08;
    // Start top-left
    path.lineTo(0, size.height - 50);

    // Bottom left curve (mềm)
    path.quadraticBezierTo(
      size.width * 0.15,
      size.height,
      size.width * 0.45,
      size.height,
    );

    // Bottom right curve
    path.quadraticBezierTo(
      size.width * 0.75,
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
