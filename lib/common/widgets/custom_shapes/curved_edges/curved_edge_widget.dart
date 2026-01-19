import 'package:flutter/material.dart';
import 'package:messenger/utils/theme/custom_themes/curved_bottom_edgets.dart';
import 'package:messenger/utils/theme/custom_themes/curved_center_top_edgets.dart';
import 'package:messenger/utils/theme/custom_themes/curved_left_top_edgets.dart';
import 'package:messenger/utils/theme/custom_themes/curved_right_top_edgets.dart';
class CurvedEdgesWidget extends StatelessWidget {
  final bool isTop;
  final bool isLeft;
  final bool isCenter;
  final Widget child;

  const CurvedEdgesWidget({
    super.key,
    required this.child, this.isTop = true, this.isLeft= true,  this.isCenter= false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(clipper: isTop?isCenter?CustomCurvedCenterTopEdges():isLeft?CustomCurvedLeftTopEdges():CustomCurvedRightTopEdges():CustomCurvedBottomEdges(), child: child);
  }
}
