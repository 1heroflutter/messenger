import 'package:flutter/material.dart';

class CustomCurvedBottomEdges extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    // Bắt đầu từ góc trên bên trái
    path.lineTo(0, size.height-size.height/2.6); // Đi xuống cạnh trái, dừng trước đáy 100 đơn vị

    // Vẽ đường cong sóng
    // Điểm điều khiển (Control Point) nằm ở giữa chiều rộng và sát đáy (size.height)
    // Điểm kết thúc (End Point) nằm ở bên phải và cao lên lạiz
    final firstControlPoint = Offset(size.width / 2, size.height-size.height/4.2);
    final firstEndPoint = Offset(size.width, size.height-size.height/2.6);

    path.quadraticBezierTo(
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy
    );

    // Đi thẳng lên góc trên bên phải
    path.lineTo(size.width, 0);

    // Đóng path quay về (0,0)
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}