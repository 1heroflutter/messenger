import 'package:flutter/material.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utils.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          OnBoardingController.instance.skipPage();
        },
        child: Text('Skip',style: TextStyle(color:HelperFunctions.isDarkMode(context)? AppColors.lightBlue:AppColors.darkBlue,fontSize: 14),));
  }
}
