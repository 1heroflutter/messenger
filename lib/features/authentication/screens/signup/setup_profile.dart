import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/features/authentication/controllers/signup/signup_controller.dart';
import 'package:messenger/features/authentication/screens/login/widgets/login_form.dart';
import 'package:messenger/features/authentication/screens/login/widgets/login_header.dart';
import 'package:messenger/features/authentication/screens/login/widgets/otp_bottom_cursor.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/name_form.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/setup_profile_header.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:messenger/features/authentication/screens/signup/widgets/signup_header.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/theme/custom_themes/curved_left_top_edgets.dart';

import '../../../../common/styles/spacing_style.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';


class SetupProfileScreen extends StatelessWidget {
  const SetupProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CurvedEdgesWidget(
              isCenter: true,
              child: Container(
                height: 280,
                color: dark ? AppColors.darkBlue : AppColors.lightBlue,
                child: SetupProfileHeader(dark: dark, theme: theme),
              ),
            ),
            Padding(
              padding: SpacingStyle.paddingWithAppBarHeight,
              child: NameForm(),
            ),
          ],
        ),
      ),
    );
  }
}
