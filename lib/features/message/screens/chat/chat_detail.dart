import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:messenger/features/message/screens/chat/widgets/app_bar.dart';
import 'package:messenger/features/message/screens/chat/widgets/chat_input.dart';
import 'package:messenger/features/message/screens/chat/widgets/chat_bubble.dart';
import 'package:messenger/features/message/screens/chat/widgets/date_header.dart';
import 'package:messenger/features/personalization/models/user_model.dart';
import 'package:messenger/utils/device/device_utils.dart';
import 'package:messenger/utils/formatters/formaters.dart';
import 'package:messenger/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/appbars/main_screen_appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/controllers/user/user_controller.dart';
import '../../controllers/chat/chat_controller.dart';
import '../user_information/user_information.dart';

class ChatDetailScreen extends StatelessWidget {
  final UserModel user;

  const ChatDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final chatController = Get.put(ChatController(user), tag: user.id);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(DeviceUtils.getAppBarHeight()),
        child: Obx(
          () => MainScreenAppbar(
            backgroundColor: chatController.themeColor.value,
            title: AppBarTittle(user: user),
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            suffer: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.videocam_outlined, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.call_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: dark ? AppColors.dark : AppColors.softGrey,
            image: chatController.backgroundImage.value.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(chatController.backgroundImage.value),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  )
                : null,
          ),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    reverse: true,
                    controller: chatController.scrollController,
                    padding: const EdgeInsets.all(AppSizes.defaultSpace),
                    itemCount: chatController.messages.length + 1,
                    itemBuilder: (context, index) {
                      if (index == chatController.messages.length) {
                        return Obx(
                          () => chatController.isMoreLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        );
                      }
                      final message = chatController.messages[index];
                      final isMe =
                          message.sender ==
                          UserController.instance.user.value.id;
                      bool showDateHeader = false;
                      if (index == chatController.messages.length - 1) {
                        showDateHeader = true;
                      } else {
                        final prevMessage = chatController.messages[index + 1];
                        final DateTime date1 = message.createdAt;
                        final DateTime date2 = prevMessage.createdAt;

                        if (date1.year != date2.year ||
                            date1.month != date2.month ||
                            date1.day != date2.day) {
                          showDateHeader = true;
                        }
                      }

                      return Column(
                        children: [
                          if (showDateHeader)
                            DateHeader(date: message.createdAt),
                          ChatBubble(
                            message: message,
                            controller: chatController,
                            messageContent: message.content,
                            time: Formatters.formatMessageTime(
                              message.createdAt,
                            ),
                            isMe: isMe,
                          ),

                        ],
                      );
                    },
                  ),
                ),
              ),

              ChatInput(controller: chatController),
            ],
          ),
        ),
      ),
    );
  }
}
