import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/features/authentication/controllers/signup/signup_controller.dart';
import 'package:messenger/features/authentication/screens/login/widgets/login_form.dart';
import 'package:messenger/features/authentication/screens/login/widgets/login_header.dart';
import 'package:messenger/features/authentication/screens/login/widgets/otp_bottom_cursor.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/theme/custom_themes/curved_left_top_edgets.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    final theme = Theme.of(context);
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CurvedEdgesWidget(
              isLeft: false,
              child: Container(
                height: 245,
                color: dark ? AppColors.darkBlue : AppColors.lightBlue,
                child: SignupHeader(dark: dark, theme: theme),
              ),
            ),
            Padding(
              padding: SpacingStyle.paddingWithAppBarHeight,
              child: SizedBox(
                height: 400,
                child: PageView(
                    controller: controller.pageController,
                    onPageChanged: (value) =>controller.updatePageIndicator(value),
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      SignupForm(),
                      OtpBottomCursor(ontap: controller.verifyOtp,controller: controller.otp,),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
