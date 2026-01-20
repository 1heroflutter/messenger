import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../personalization/models/user_model.dart';
import '../../chat/chat_detail.dart';

class UserVertical extends StatelessWidget {
  const UserVertical({
    super.key,
    required this.friend,
  });

  final UserModel friend;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: GestureDetector(
        onTap: () => Get.to(
              () => ChatDetailScreen(user: friend),
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryColor,
              backgroundImage: NetworkImage(
                friend.avatar,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              friend.displayName,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
