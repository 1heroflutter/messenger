
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/widgets/rounded_images/rounded_images.dart';
import 'package:messenger/features/message/screens/user_information/user_information.dart';
import 'package:messenger/utils/constants/sizes.dart';

import '../../../../personalization/models/user_model.dart';

class AppBarTittle extends StatelessWidget {
  const AppBarTittle({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(UserInformationScreen(user: user)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedImage(imageUrl: user.avatar, isNetworkImage: true, height: 42,width: 42,borderRadius: 100,),
          SizedBox(width: AppSizes.sm,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.displayName.isNotEmpty ? user.displayName : user.phoneNumber,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
              Text(user.isOnline ? "Online" : "Offline",
                  style: TextStyle(color: user.isOnline ? Colors.green : Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}