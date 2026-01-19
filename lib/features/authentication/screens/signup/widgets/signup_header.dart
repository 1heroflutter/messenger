import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/styles/spacing_style.dart';
import 'package:messenger/features/authentication/controllers/signup/signup_controller.dart';
import 'package:messenger/features/authentication/screens/login/login.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';

class SignupHeader extends StatelessWidget {
  const SignupHeader({super.key, required this.dark, required this.theme});

  final bool dark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: SpacingStyle.paddingWithAppBarHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
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
                  controller.currentPageIndex.value = 0;

                  Get.off(LoginScreen());
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
          const SizedBox(height: AppSizes.spaceBtwItems),
          Text(
            AppTexts.signupSubTitle,
            style: theme.textTheme.headlineMedium,
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
