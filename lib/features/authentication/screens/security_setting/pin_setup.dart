import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/widgets/appbars/basic_appbar.dart';
import 'package:messenger/common/widgets/success_screen/success_screen.dart';
import 'package:messenger/features/authentication/screens/security_setting/widgets/set_pin_bottom_cursor.dart';
import 'package:messenger/navigation_menu.dart';
import 'package:messenger/utils/constants/app_texts.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/image_string.dart';
import 'package:messenger/utils/constants/sizes.dart';

import '../../../message/screens/home/home.dart';
import '../../controllers/set_pin/pin_controller.dart';

class PinSetupScreen extends StatelessWidget {
  const PinSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PinController());
    return Scaffold(
      appBar: BasicAppbar(title: "PIN Security"),
      body: Padding(
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppTexts.setPinSecurity,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            SetPinBottomCursor(),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.offAll(NavigationMenu());
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const StadiumBorder(),
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child:  Text(
                      'Skip',
                      style: TextStyle(fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // --- NÚT CONTINUE ---
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.handleSetPIN();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Continue',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
