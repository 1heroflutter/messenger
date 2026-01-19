import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messenger/features/message/controllers/chat/chat_controller.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';

import '../../../features/message/screens/add/add_friends.dart';
import '../../../features/message/screens/chat/widgets/menu_item.dart';
import '../../../utils/constants/colors.dart';

class CustomChatBoxPopupMenu extends StatelessWidget {
  final ChatController controller;

  const CustomChatBoxPopupMenu({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return PopupMenuButton<String>(
      icon: const Icon(Icons.add, color: AppColors.primaryColor),
      color: dark ? AppColors.black : AppColors.white,
      constraints: const BoxConstraints(minWidth: 280, maxWidth: 280),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),

      itemBuilder: (context) => [
        PopupMenuItem(
          enabled: false,
          child: SizedBox(
            width: 280,
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MenuItem(
                  context: context,
                  icon: Icons.camera_alt,
                  label: "Camera",
                  onTap: () => controller.pickAndSendImage(ImageSource.camera),
                ),
                MenuItem(
                  context: context,
                  icon: Icons.mic,
                  label: "Record",
                  onTap: () {},
                ),
                MenuItem(
                  context: context,
                  icon: Icons.account_circle,
                  label: "Contact",
                  onTap: () {},
                ),
                MenuItem(
                  context: context,
                  icon: Icons.image,
                  label: "Gallery",
                  onTap: () => controller.pickAndSendImage(ImageSource.gallery),
                ),
                MenuItem(
                  context: context,
                  icon: Icons.pin_drop,
                  label: "Location",
                  onTap: () {},
                ),
                MenuItem(
                  context: context,
                  icon: Icons.video_settings,
                  label: "Video",
                  onTap: () => controller.pickAndSendVideo(ImageSource.gallery),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
