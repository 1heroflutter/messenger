import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/data/repositories/chat/chat_repository.dart';
import 'package:messenger/features/message/controllers/chat/chat_controller.dart';
import 'package:messenger/features/message/models/message_model.dart';
import 'package:messenger/features/message/screens/chat/widgets/video_player.dart';
import 'package:messenger/utils/constants/enums.dart';

import '../../../../../common/widgets/loaders/shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.messageContent,
    required this.time,
    required this.isMe,
    required this.controller,
    required this.message,
  });

  final ChatController controller;
  final String messageContent;
  final MessageModel message;
  final String time;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final isDeleted =
        message.status == MessageStatus.deleted ||
        messageContent == "Tin nhắn đã bị thu hồi";

    final isImage = message.messageType == 'image' && !isDeleted;
    final isVideo = message.messageType == 'video' && !isDeleted;
    final dark = HelperFunctions.isDarkMode(context);

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: isImage ? null : () => _showChatOptions(context),
        child: Obx(() {
          Color myColor = controller.themeColor.value;
          Color bubbleColor = isMe
              ? myColor
              : (dark ? AppColors.dark : Colors.white);
          return Container(
            margin: const EdgeInsets.symmetric(vertical: AppSizes.xs),
            padding: isDeleted
                ? const EdgeInsets.all(4)
                : const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.sm,
                  ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: Radius.circular(isMe ? 15 : 4),
                bottomRight: Radius.circular(isMe ? 4 : 15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (isImage)
                  _buildImageContent(messageContent)
                else if (isVideo)
                  _buildVideoContent(context, messageContent)
                else
                  Padding(
                    padding: const EdgeInsets.only(right: 4, left: 4, top: 4),
                    child: Text(
                      messageContent,
                      style: TextStyle(
                        color: message.status == MessageStatus.deleted
                            ? Colors.white
                            : (isMe ? Colors.white : (dark ? Colors.white : Colors.black87)),
                        fontStyle: message.status == MessageStatus.deleted
                            ? FontStyle.italic
                            : FontStyle.normal,
                        fontSize: 14,
                      ),
                    ),
                  ),

                const SizedBox(height: 4),

                /// Phần thời gian và trạng thái
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        time,
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey,
                          fontSize: 10,
                          letterSpacing: 0.2,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        _buildStatusIcon(message.status),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  /// Widget hiển thị hình ảnh (Xử lý cả File local và URL mạng)
  Widget _buildImageContent(String path) {
    return GestureDetector(
      onTap: () => controller.showEnlargedImage(path),
      child: Container(
        height: 200,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: path.startsWith('http')
              ? CachedNetworkImage(
                  imageUrl: path,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const ShimmerEffect(width: 200, height: 160),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : Image.file(
                  File(path),
                  fit: BoxFit.cover,
                  width: 200,
                  height: 200,
                ),
        ),
      ),
    );
  }

  void _showChatOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Wrap(
          children: [
            // 1. Copy tin nhắn (Chỉ cho Text)
            if (message.messageType == 'text')
              ListTile(
                leading: const Icon(Icons.copy),
                title: const Text('Copy'),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: messageContent));
                  Get.back();
                },
              ),

            if (isMe && message.messageType == 'text')
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Edit'),
                onTap: () {
                  Get.back();
                  _showEditDialog(context);
                },
              ),
            if (isMe)
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  'Unsend',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Get.back();
                  _showDeleteConfirmation();
                },
              ),
          ],
        ),
      ),
    );
  }

  // Dialog Chỉnh sửa
  void _showEditDialog(BuildContext context) {
    final editController = TextEditingController(text: messageContent);
    Get.defaultDialog(
      title: "Sửa tin nhắn",
      content: TextField(controller: editController),
      confirm: ElevatedButton(
        onPressed: () async {
          final updatedMsg = await ChatRepository.instance.editMessage(
            message.id!,
            editController.text.trim(),
          );
          if (updatedMsg != null) {
            controller.handleUpdateMessage(updatedMsg);
          }
          Get.back();
        },
        child: const Text("Cập nhật"),
      ),
    );
  }

  // Dialog Xác nhận xóa
  void _showDeleteConfirmation() {
    Get.defaultDialog(
      buttonColor: AppColors.primaryColor,
      cancelTextColor: AppColors.primaryColor,
      title: "Thu hồi tin nhắn?",
      middleText: "Tin nhắn này sẽ bị xóa đối với mọi người.",
      textConfirm: "Xóa",
      onConfirm: () async {
        final deletedMsg = await ChatRepository.instance.deleteMessage(
          message.id!,
        );
        if (deletedMsg != null) {
          controller.handleUpdateMessage(
            deletedMsg.copyWith(messageType: "text"),
          );
        }
        Get.back();
      },
      textCancel: "Hủy",
    );
  }

  /// Widget hiển thị Video Thumbnail + Nút Play
  Widget _buildVideoContent(BuildContext context, String path) {
    bool isNetwork = path.startsWith('http');

    String thumbnailUrl = isNetwork
        ? path.replaceAll(RegExp(r'\.\w+$'), '.jpg')
        : path;

    return GestureDetector(
      onTap: () =>
          Get.to(() => VideoPlayerScreen(videoUrl: path, isNetwork: isNetwork)),
      child: Container(
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: isNetwork
                  ? CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Container(color: Colors.black),
                      placeholder: (context, url) =>
                          Container(color: Colors.black12),
                    )
                  : Container(color: Colors.black38, width: 200, height: 200),
            ),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black26,
              ),
            ),
            const Icon(
              Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 50,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStatusIcon(MessageStatus status) {
  switch (status) {
    case MessageStatus.pending:
      return const Icon(
        Icons.access_time_rounded,
        size: 12,
        color: Colors.white70,
      );
    case MessageStatus.sent:
      return const Icon(Icons.check, size: 12, color: Colors.white70);
    case MessageStatus.delivered:
      // Đã tới máy đối phương: 2 dấu tick xám
      return const Icon(Icons.done_all, size: 12, color: Colors.white70);
    case MessageStatus.read:
      return const Icon(Icons.done_all, size: 12, color: Colors.white70);
    case MessageStatus.failed:
      // Lỗi: Dấu chấm than đỏ
      return const Icon(Icons.error_outline, size: 12, color: Colors.redAccent);
    default:
      return const SizedBox.shrink();
  }
}
