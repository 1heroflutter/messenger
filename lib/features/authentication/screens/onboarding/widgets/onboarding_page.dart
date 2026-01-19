import 'package:flutter/material.dart';
import 'package:messenger/utils/constants/colors.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({
    super.key,
    required this.theme,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  final ThemeData theme;
  final String image, title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.defaultSpace),
      child: Column(
        children: [
          Image(
            width: HelperFunctions.screenWidth(),
            height: HelperFunctions.screenHeight() * 0.4,
            image: AssetImage(image),
            fit: BoxFit.contain,
          ),
          Text(
            title,
            style: TextStyle(color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 24),
            textAlign: TextAlign.center,

          ),
          const SizedBox(
            height: AppSizes.spaceBtwItems,
          ),
          Text(
            subTitle,
            style: TextStyle(color: AppColors.primaryColor,fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
