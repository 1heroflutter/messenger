import 'package:flutter/material.dart';
import 'package:messenger/common/widgets/loaders/shimmer.dart';

import '../layouts/grid_layout.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const ShimmerEffect(width: 300, height: 80),
    );
  }
}