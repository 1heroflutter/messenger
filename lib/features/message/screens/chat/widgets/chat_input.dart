import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/features/message/controllers/chat/chat_controller.dart';
import '../../../../../common/widgets/popup_menu/popup_chat_box_menu_button.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
class ChatInput extends StatelessWidget {
  final ChatController controller;
  const ChatInput({
    super.key, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.md),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.1),
            child: CustomChatBoxPopupMenu(controller: controller,),
          ),

          const SizedBox(width: AppSizes.sm),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onTapOutside:(event) => FocusScope.of(Get.context!).unfocus() ,
                controller: controller.textController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: "Type a message ...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.sm),
          CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: IconButton(onPressed:() => controller.handleSendMessage(), icon: const Icon(Iconsax.send_1, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}