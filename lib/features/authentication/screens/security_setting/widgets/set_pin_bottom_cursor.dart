import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/features/authentication/controllers/set_pin/pin_controller.dart';
import 'package:messenger/features/authentication/screens/signup/setup_profile.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';
import 'package:messenger/utils/validators/validation.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/colors.dart';

class SetPinBottomCursor extends StatelessWidget {
  const SetPinBottomCursor({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PinController.instance;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: Colors.grey.shade300),
        ),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border(
        bottom: BorderSide(width: 2, color: AppColors.primaryColor),
      ),
    );

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: controller.setPinFormKey,
                child: Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  controller: controller.pin,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  validator:(value) =>  Validator.validatePIN(value),
                  showCursor: true,
                  keyboardType: TextInputType.number,
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 20,
                        height: 3,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                  onCompleted: (pin) {
                    print("Mã OTP là: $pin");
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
