import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';
import 'package:messenger/utils/constants/image_string.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../features/message/controllers/add/add_controller.dart';
import '../../../features/message/screens/add/widgets/add_button.dart';
import '../../../features/personalization/models/user_model.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    required this.controller,
  });

  final UserModel user;
  final AddController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: user.avatar.isNotEmpty
            ? NetworkImage(user.avatar)
            : const AssetImage(AppImages.lightAppLogo) as ImageProvider,
      ),
      title: Text(
        user.displayName.isNotEmpty ? user.displayName : "Người dùng Messenger",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(user.phoneNumber),
      trailing: AddButton(user: user, controller: controller),
    );
  }
}


