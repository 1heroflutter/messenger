import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/features/authentication/screens/signup/setup_profile.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';
import 'package:messenger/utils/validators/validation.dart';
import 'package:pinput/pinput.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/colors.dart';

class OtpBottomCursor extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback ontap;

  const OtpBottomCursor({super.key, required this.ontap, required this.controller});

  @override
  Widget build(BuildContext context) {
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
        Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Iconsax.clock),
          const SizedBox(width: AppSizes.spaceBtwItems),
          Countdown(
            seconds: 60,
            build: (BuildContext context, double time) =>
                Text(
                  "${time.toInt()}s",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            interval: Duration(milliseconds: 100),
            onFinished: () {
              print('Hết thời gian OTP!');
            },
          ),
          const SizedBox(width: AppSizes.spaceBtwItems),
          Text('Resend Code', style: Theme
              .of(context)
              .textTheme
              .labelSmall),
        ],
      ),
      Pinput(
        length: 6,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        validator:(value) =>  Validator.validateOTP(value),
        showCursor: true,
        controller: controller,
        onChanged: (value) => controller.text = value,
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

      const SizedBox(height: AppSizes.spaceBtwSections,),
      SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              onPressed: ontap,
              child: const Text(AppTexts.signIn)),
    ),]
    ,
    )
    ,
    );
  }
}
