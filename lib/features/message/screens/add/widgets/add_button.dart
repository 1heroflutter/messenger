import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/screens/add/widgets/search_input.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../personalization/models/user_model.dart';
import '../../../controllers/add/add_controller.dart';
class AddButton extends StatelessWidget {
  const AddButton({
    super.key,
    required this.user,
    required this.controller,
  });

  final UserModel user;
  final AddController controller;

  @override
  Widget build(BuildContext context) {
    switch (user.relationship) {
      case FriendRelationship.friend:
        return IconButton(
          onPressed: () {
            // Chuyển hướng sang màn hình Chat với user này
            // Get.to(() => ChatScreen(receiver: user));
          },
          icon: const Icon(Icons.chat_bubble_outline, color: AppColors.primaryColor),
        );

      case FriendRelationship.pending:
        return const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.access_time_filled, color: Colors.grey),
        );

    // 3. Nếu chưa có quan hệ: Hiển thị nút Thêm bạn
      case FriendRelationship.none:
      default:
        return IconButton(
          onPressed: () => _handleSendRequest(),
          icon: const Icon(Icons.person_add_alt_1, color: AppColors.primaryColor),
        );
    }
  }
  void _handleSendRequest() async {
    await controller.sendRequest(user.id);
  }
}