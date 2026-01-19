import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/styles/spacing_style.dart';
import 'package:messenger/common/widgets/rounded_images/rounded_images.dart';
import 'package:messenger/features/authentication/screens/login/login.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/image_string.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';

class SetupProfileHeader extends StatelessWidget {
  const SetupProfileHeader({
    super.key,
    required this.dark,
    required this.theme,
  });

  final bool dark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: SpacingStyle.paddingWithAppBarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(
                    EdgeInsets.symmetric(horizontal: 20),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    dark ? AppColors.darkContainer : AppColors.lightContainer,
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(30),
                    ),
                  ),
                ),
                onPressed: () {
                  Get.to(LoginScreen());
                },
                child: Row(
                  children: [
                    Icon(Icons.arrow_back, color: AppColors.primaryColor),
                    const SizedBox(width: AppSizes.spaceBtwItems),
                    Text(
                      'Login',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
              Text(AppTexts.signupTitle, style: theme.textTheme.headlineLarge),
            ],
          ),
          const SizedBox(width: AppSizes.spaceBtwSections),
          Center(
            child: RoundedImage(
              height: 120,
              width: 120,
              borderRadius: 100,
              imageUrl:"https://yt3.ggpht.com/yti/ANjgQV-umpCVm5pUpu3Ok5BkTmbwh3J8ngPN8er5ZLrww5GthYoL=s88-c-k-c0x00ffffff-no-rj"),
          ),
        ],
      ),
    );
  }
}
