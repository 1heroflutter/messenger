import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/navigation_menu.dart';

import '../../../../../utils/constants/app_texts.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controllers/login/login_controller.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
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
              controller: controller.phoneNo,
              keyboardType: TextInputType.number,
              validator: (value) => Validator.validatePhoneNumber(value),
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
                  controller.phoneNumberSignIn();
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
