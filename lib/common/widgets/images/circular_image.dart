
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../loaders/shimmer.dart';

class CircularImage extends StatelessWidget {
  const CircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.fill,
    this.padding = AppSizes.sm,
    this.isNetworkImage = false,
  });

  final BoxFit fit;
  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ?? (HelperFunctions.isDarkMode(context) ? AppColors.black : AppColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(100),
        child: isNetworkImage
            ? CachedNetworkImage(
          fit: fit,
          color: overlayColor,
          imageUrl: image,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
          ShimmerEffect(width: width, height: height),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        )
            : Image(
          fit: fit,
          image: AssetImage(image) ,
          color: overlayColor,
        ),
      ),
    );
  }
}