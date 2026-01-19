import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';
import '../../security_setting/pin_setup.dart';

class NameForm extends StatelessWidget {
  const NameForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.spaceBtwSections),

            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validatePhoneNumber(value),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: AppTexts.yourName,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // controller.emailAndPasswordSignIn();
                  Get.to(PinSetupScreen());
                },
                child: const Text('Next'),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),
          ],
        ),
      ),
    );
  }
}
