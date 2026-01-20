import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/features/message/screens/home/widgets/user_vertical.dart';

import '../../../../../common/widgets/card_messenger/card_messenger.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/formatters/formaters.dart';
import '../../../../personalization/models/user_model.dart';
import '../../../controllers/home/home_controller.dart';
import '../../chat/chat_detail.dart';
class ListConversation extends StatelessWidget {
  const ListConversation({
    super.key,
    required this.controller,
    required this.myId,
  });

  final HomeController controller;
  final String myId;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final conversation = controller.conversations[index];
        final partner = conversation.participants.firstWhere(
              (u) => u.id != myId,
          orElse: () => conversation.participants.first,
        );

        final lastMsg = conversation.lastMessage;
        String messagePreview = "Bắt đầu trò chuyện";
        if (lastMsg != null) {
          messagePreview = (lastMsg.sender == myId)
              ? "Bạn: ${lastMsg.content}"
              : lastMsg.content;
        }
        return CardMessenger(
          name: partner.displayName.isNotEmpty
              ? partner.displayName
              : partner.phoneNumber,
          lastMessage: messagePreview,
          time: Formatters.formatDate(conversation.updatedAt),
          image: partner.avatar,
          isOnline: partner.isOnline,
          onTap: () =>
              Get.to(() => ChatDetailScreen(user: partner)),
        );
      }, childCount: controller.conversations.length),
    );
  }
}
