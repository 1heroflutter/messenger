import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:messenger/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:messenger/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:messenger/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:messenger/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:messenger/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/app_texts.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utils.dart';
import '../../controllers/onboarding/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());
    final dark = HelperFunctions.isDarkMode(context);
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: dark?AppColors.darkBlue.withOpacity(0.5):AppColors.lightBlue.withAlpha(700),
      body: Stack(
        children: [
          CurvedEdgesWidget(
            isTop: false,
            child: Container(
              color: dark?AppColors.dark:AppColors.lightContainer,
              padding: const EdgeInsets.all(0),
              child: PageView(
                controller: controller.pageController,
                onPageChanged: (value) => controller.updatePageIndicator(value),
                children: [
                  OnBoardingPage(
                    theme: theme,
                    image: AppImages.onBoardingImage1,
                    title: AppTexts.onBoardingTitle1,
                    subTitle: AppTexts.onBoardingSubTitle1,
                  ),
                  OnBoardingPage(
                    theme: theme,
                    image: AppImages.onBoardingImage2,
                    title: AppTexts.onBoardingTitle2,
                    subTitle: AppTexts.onBoardingSubTitle2,
                  ),
                  OnBoardingPage(
                    theme: theme,
                    image: AppImages.onBoardingImage3,
                    title: AppTexts.onBoardingTitle3,
                    subTitle: AppTexts.onBoardingSubTitle3,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: AppSizes.defaultSpace,
            left: AppSizes.defaultSpace,
            bottom: DeviceUtils.getBottomNavigationBarHeight(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const OnBoardingSkip(),
                const OnBoardingDotNavigation(),
                const OnBoardingNextButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
