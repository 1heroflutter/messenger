import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_shapes/containers/custom_container.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import '../../../../utils/constants/colors.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  final Widget child;

  const PrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(
                  backgroundColor: Colors.red.withOpacity(0.5)),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(
                  backgroundColor: Colors.yellow.withOpacity(0.6)),
            ),
            child
          ],
        ), // Stack
      ),
    );
  }
}
