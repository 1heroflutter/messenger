import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/authentication/controllers/signup/signup_controller.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signupFormKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.spaceBtwSections,
        ),
        child: Column(
          children: [
            Text(
              AppTexts.loginHeader,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),

            TextFormField(
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validatePhoneNumber(value),
              onChanged: (value) => controller.phoneNo.text = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: AppTexts.phoneNo,
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwInputFields),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(AppTexts.rememberMe, style: Theme.of(context).textTheme.labelLarge,),
                Obx(
                  () => Checkbox(
                    value: controller.rememberMe.value,
                    onChanged: (value) {
                      controller.rememberMe.value =
                          !controller.rememberMe.value;
                    },
                  ),
                ),

              ],
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  controller.phoneNumberSignUp();
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
