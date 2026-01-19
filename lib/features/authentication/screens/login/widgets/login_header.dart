import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/styles/spacing_style.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../signup/signup.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key, required this.dark, required this.theme});

  final bool dark;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: SpacingStyle.paddingWithAppBarHeight ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppTexts.loginTitle, style: theme.textTheme.headlineLarge),
              ElevatedButton(
                style: ButtonStyle(
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20)),
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
                  controller.currentPageIndex.value =0;
                  Get.off(SignupScreen());
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.spaceBtwItems,),
          Text(AppTexts.loginSubTitle, style: theme.textTheme.headlineMedium),
        ],
      ),
    );
  }
}
