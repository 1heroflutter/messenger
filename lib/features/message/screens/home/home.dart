import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:messenger/common/widgets/appbars/main_screen_appbar.dart';
import 'package:messenger/common/widgets/card_messenger/card_messenger.dart';
import 'package:messenger/features/message/controllers/home/home_controller.dart';
import 'package:messenger/features/message/screens/home/widgets/home_appbar.dart';
import 'package:messenger/features/message/screens/home/widgets/horizontal_friend_list.dart';
import 'package:messenger/features/message/screens/home/widgets/list_conversation.dart';
import 'package:messenger/features/message/screens/home/widgets/scroll_to_top_btn.dart';
import 'package:messenger/features/message/screens/home/widgets/user_vertical.dart';
import 'package:messenger/features/personalization/controllers/user/user_controller.dart';
import 'package:messenger/features/personalization/models/user_model.dart';
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

    return Scaffold(
      appBar: const HomeAppbar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final myId = UserController.instance.user.value.id;

        return Stack(
          children: [
            RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () => controller.refreshData(),
              child: CustomScrollView(
                controller: controller.scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  // 1. DANH SÁCH BẠN BÈ (HÀNG NGANG)
                  if (controller.friends.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.only(top: AppSizes.md),
                      sliver: HorizontalFriendList(controller: controller),
                    ),

                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(AppSizes.sm),
                      child: Text(
                        "Đoạn chat",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),

                  if (controller.conversations.isEmpty)
                    const SliverFillRemaining(
                      child: Center(child: Text("Chưa có tin nhắn")),
                    )
                  else
                    ListConversation(controller: controller, myId: myId),
                ],
              ),
            ),
            ScrollToTopBtn(controller: controller),
          ],
        );
      }),
    );
  }
}
