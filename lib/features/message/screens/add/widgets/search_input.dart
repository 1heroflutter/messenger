import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/add/add_controller.dart';
class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AddController.instance;
    final dark = HelperFunctions.isDarkMode(context);
    return Form(
      key: controller.addFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.md, vertical: AppSizes.xs),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: dark ? AppColors.darkGrey : AppColors.grey),
        ),
        child: Row(
          children: [
            // Country Code Picker (Placeholder)
            Row(
              children: [
                const Text("🇻🇳", style: TextStyle(fontSize: 24)),
                const SizedBox(width: AppSizes.xs),
                const Icon(Icons.keyboard_arrow_down, size: 18),
                const SizedBox(width: AppSizes.sm),
                Text("(+84)", style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            const SizedBox(width: AppSizes.spaceBtwItems),

            // Input Field
            Expanded(
              child: TextFormField(
                controller: controller.phoneNo,
                keyboardType: TextInputType.phone,
                onChanged: (value) => controller.searchUser(), // Tìm kiếm khi gõ
                decoration: InputDecoration(
                  hintText: "Enter Phone Number",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintStyle: TextStyle(color: dark ? AppColors.darkGrey : AppColors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}