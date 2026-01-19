import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/screens/add/widgets/add_button.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';
import 'package:messenger/features/message/screens/add/widgets/list_users.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
class Empty extends StatelessWidget {
  const Empty({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.spaceBtwSections * 2),
      child: Opacity(
        opacity: 0.3,
        child: Center(
          child: Column(
            children: [
              Icon(
                Iconsax.personalcard,
                size: 150,
                color: dark ? AppColors.white : AppColors.darkGrey,
              ),
              const SizedBox(height: AppSizes.sm),
              Text("Search for friends by phone number",style: Theme.of(Get.context!).textTheme.labelLarge,),
            ],
          ),
        ),
      ),
    );
  }
}

