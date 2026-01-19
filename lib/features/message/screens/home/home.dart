import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/widgets/appbars/main_screen_appbar.dart';
import 'package:messenger/common/widgets/card_messenger/card_messenger.dart';
import 'package:messenger/features/message/controllers/home/home_controller.dart';
import 'package:messenger/features/message/screens/home/widgets/home_appbar.dart';
import 'package:messenger/features/personalization/controllers/user/user_controller.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/constants/image_string.dart';
import 'package:messenger/utils/constants/sizes.dart';
import 'package:messenger/utils/formatters/formaters.dart';

import '../../../../common/widgets/popup_menu/popup_add_menu_button.dart';
import '../../../../utils/constants/app_animations.dart';
import '../../../../utils/device/device_utils.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../chat/chat_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final userController = Get.put(UserController());
    final myId = UserController.instance.user.value.id;

    return Scaffold(
      appBar: const HomeAppbar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
        }
        if (controller.conversations.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Iconsax.message_add, size: 60, color: Colors.grey),
                const SizedBox(height: AppSizes.spaceBtwItems),
                const Text("Chưa có cuộc hội thoại nào"),
                TextButton(onPressed: () => controller.fetchAllData(), child: const Text("Tải lại")),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(AppSizes.sm),
          itemCount: controller.conversations.length,
          separatorBuilder: (_, __) => const SizedBox(height: AppSizes.spaceBtwItems),
          itemBuilder: (context, index) {
            final conversation = controller.conversations[index];
            final partner = conversation.participants.firstWhere((u) => u.id != myId, orElse: () => conversation.participants.first);
            final lastMsg = conversation.lastMessage;
            String messagePreview = "Bắt đầu trò chuyện";

            if (lastMsg != null) {
              String content = lastMsg.content;
              if (lastMsg.messageType == 'image') content = "[Hình ảnh]";
              if (lastMsg.messageType == 'video') content = "[Video]";
              messagePreview = (lastMsg.sender == myId) ? "Bạn: $content" : content;
            }
            return CardMessenger(
              name: partner.displayName.isNotEmpty ? partner.displayName : partner.phoneNumber,
              lastMessage: messagePreview,
              time: Formatters.formatDate(conversation.updatedAt),
              unreadCount: 0,
              image: partner.avatar,
              isOnline: partner.isOnline,
              onTap: () => Get.to(() => ChatDetailScreen(user: partner)),
            );
          },
        );
      }),
    );
  }
}