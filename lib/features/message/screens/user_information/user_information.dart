import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/common/widgets/rounded_images/rounded_images.dart';
import 'package:messenger/features/message/screens/user_information/widgets/info_tile.dart';
import 'package:messenger/features/personalization/models/user_model.dart';

import '../../../../common/widgets/appbars/basic_appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../controllers/user_information/user_information_controller.dart';

class UserInformationScreen extends StatelessWidget {
  final UserModel user;

  const UserInformationScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserInformationController(user: user));
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? const Color(0xFF1F222A) : AppColors.white,
      appBar: BasicAppbar(
        title: "",
        suffer: [
          IconButton(
            onPressed: () => controller.makeCall(true),
            icon: const Icon(Icons.videocam_outlined),
          ),
          IconButton(
            onPressed: () => controller.makeCall(false),
            icon: const Icon(Icons.call_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. Avatar & Name Section
            const SizedBox(height: AppSizes.spaceBtwSections),
            RoundedImage(
              isNetworkImage: true,
              imageUrl: user.avatar,
              height: 160,
              width: 160,
              borderRadius: 100,
            ),
            const SizedBox(height: AppSizes.spaceBtwItems),

            Text(
              user.displayName,
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(color: dark?Colors.white:Colors.black),
            ),
            const SizedBox(height: AppSizes.xs),

            GestureDetector(
              onTap: controller.copyPhoneNumber,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.phoneNumber.toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(width: AppSizes.sm),

                    const Icon(Icons.copy, size: 16, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            const Divider(color: Colors.grey, indent: 20, endIndent: 20),

            /// 2. Settings List
            InfoTile(
              icon: Icons.image_outlined,
              title: "Media, Links & Documents",
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text("152", style: TextStyle(color: Colors.grey)),
                  Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                ],
              ),
              onTap: () => controller.viewMedia(),
            ),
            Obx(
              () => InfoTile(
                icon: Icons.notifications_none,
                title: "Mute Notification",
                trailing: Switch(
                  value: controller.isMuted.value,
                  onChanged: controller.toggleMute,
                  activeThumbColor: AppColors.primaryColor,
                ),
              ),
            ),
            InfoTile(
              icon: Icons.notifications_active_outlined,
              title: "Custom Notification",
              onTap: () {},
            ),

            const Divider(color: Colors.grey, indent: 20, endIndent: 20),

            Obx(
              () => InfoTile(
                icon: Icons.security_outlined,
                title: "Protected Chat",
                trailing: Switch(
                  value: controller.isProtected.value,
                  onChanged: controller.toggleProtected,
                ),
              ),
            ),
            Obx(
              () => InfoTile(
                icon: Icons.remove_red_eye_outlined,
                title: "Hide Chat",
                trailing: Switch(
                  value: controller.isHidden.value,
                  onChanged: controller.toggleHideChat,
                ),
              ),
            ),
            Obx(
              () => InfoTile(
                icon: Icons.history,
                title: "Hide Chat History",
                trailing: Switch(
                  value: controller.isHistoryHidden.value,
                  onChanged: controller.toggleHideHistory,
                ),
              ),
            ),

            const Divider(color: Colors.grey, indent: 20, endIndent: 20),

            InfoTile(
              icon: Icons.group_add_outlined,
              title: "Add To Group",
              onTap: () {},
            ),
            InfoTile(
              icon: Icons.palette_outlined,
              title: "Custom Color Chat",
              trailing: Obx(() => Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                      color: controller.themeColor.value,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)
                  )
              )),
              onTap: () => controller.showColorPickerDialog(context),
            ),
            InfoTile(
              icon: Icons.wallpaper_outlined,
              title: "Custom Background Chat",
              trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              // Gọi hàm chọn ảnh
              onTap: () => controller.pickAndUploadBackground(),
            ),

            const Divider(color: Colors.grey, indent: 20, endIndent: 20),

            InfoTile(
              icon: Icons.report_gmailerrorred_outlined,
              title: "Report",
              titleColor: Colors.red,
              onTap: controller.onReportUser,
            ),
            Obx(
              () => InfoTile(
                icon: Icons.block_flipped,
                title: controller.isBlocked.value
                    ? "Unblock User"
                    : "Block User",
                titleColor: Colors.red,
                onTap: controller.onBlockUser,
              ),
            ),

            const SizedBox(height: AppSizes.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}
