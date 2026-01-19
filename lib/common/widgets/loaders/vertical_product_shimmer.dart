import 'package:flutter/material.dart';
import 'package:messenger/common/widgets/loaders/shimmer.dart';

import '../../../utils/constants/sizes.dart';
import '../layouts/grid_layout.dart';
// Bạn cần import các file TGridLayout, TShimmerEffect, và TSizes

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      itemBuilder: (_, __) => const SizedBox(
        width: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ShimmerEffect(width: 180, height: 180),
            SizedBox(height: AppSizes.spaceBtwItems),

            /// Text
            ShimmerEffect(width: 160, height: 15),
            SizedBox(height: AppSizes.spaceBtwItems / 2),
            ShimmerEffect(width: 110, height: 15),
          ],
        ),
      ),
    );
  }
}