import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';

import '../../../../../common/widgets/user/horizontal_user_card.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/add/add_controller.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({
    super.key,
    required this.controller,
  });

  final AddController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.featuredUsers.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceBtwItems),
      itemBuilder: (_, index) {
        final user = controller.featuredUsers[index];
        return UserCard(user: user, controller: controller);
      },
    );
  }
}
