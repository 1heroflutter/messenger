import 'package:flutter/material.dart';
import '../../../../utils/constants/sizes.dart';

class GridLayout extends StatelessWidget {
  final int itemCount;
  final double? mainAxisExtent;
  final Widget? Function(BuildContext, int) itemBuilder;

  const GridLayout(
      {super.key,
      required this.itemCount,
      this.mainAxisExtent=246,
      required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.zero,
        itemCount: itemCount,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:2,
            crossAxisSpacing: AppSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent,
            mainAxisSpacing: AppSizes.gridViewSpacing),
        itemBuilder: itemBuilder);
  }
}
