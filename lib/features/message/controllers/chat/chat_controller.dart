import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../data/repositories/chat/chat_repository.dart';
import '../../../../data/repositories/user_information/user_information_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personalization/controllers/user/user_controller.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/message_model.dart';

class ChatController extends GetxController {
  final UserModel partner;
  ChatController(this.partner);

  static ChatController get instance => Get.find();

  final chatRepo = Get.put(ChatRepository());
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  Rx<Color> themeColor = AppColors.primaryColor.obs;
  RxString backgroundImage = ''.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  int currentPage = 1;
  bool canLoadMore = true;
  final userRepo = Get.put(UserInformationRepository());
  // State
  RxList<MessageModel> messages = <MessageModel>[].obs;
  late IO.Socket socket;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(_scrollListener);

    isLoading.value = true;
    await fetchConversationSettings();
    await loadMessages();
    setupSocket();
    isLoading.value = false;
  }

  @override
  void dispose() {
    textController.clear();
  }
  Future<void> fetchConversationSettings() async {
    final data = await userRepo.getConversationDetails(partner.id);
    if (data != null) {
      if (data['themeColor'] != null) {
        try {
          themeColor.value = Color(int.parse(data['themeColor']));
        } catch (_) {}
      }
      if (data['backgroundImage'] != null) {
        backgroundImage.value = data['backgroundImage'];
      }
    }
  }
  Future<void> loadMessages() async {
    isLoading.value = true;
    currentPage = 1;
    canLoadMore = true;

    final history = await chatRepo.getChatHistory(partner.id, page: 1);

    messages.assignAll(history);
    isLoading.value = false;
  }
  @override
  void onClose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    textController.dispose();
    super.onClose();
  }

  /// Hàm lắng nghe cuộn
  void _scrollListener() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent &&
        !isMoreLoading.value &&
        canLoadMore) {
      loadMoreMessages();
    }
  }

  // 2. Thiết lập Socket
  void setupSocket() {
    final myId = UserController.instance.user.value.id;

    socket = IO.io('http://192.168.1.233:3000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'userId': myId})
            .build()
    );

    socket.on('receive_message', (data) {
      final newMessage = MessageModel.fromJson(data);
      if (newMessage.sender == partner.id) {
        messages.insert(0, newMessage);
      }
    });
  }
  Future<void> loadMoreMessages() async {
    print("[LOAD MORE CHECK]: success");
    isMoreLoading.value = true;
    int nextPage = currentPage + 1;

    final oldMessages = await chatRepo.getChatHistory(partner.id, page: nextPage);

    if (oldMessages.isNotEmpty) {
      currentPage = nextPage;
      messages.addAll(oldMessages);
    } else {
      canLoadMore = false;
    }

    isMoreLoading.value = false;
  }
  // 3. Logic gửi tin nhắn
  Future<void> handleSendMessage() async {
    final content = textController.text.trim();
    if (content.isEmpty) return;

    final myId = UserController.instance.user.value.id;

    // Tạo một ID tạm thời duy nhất
    final String tempId = DateTime.now().millisecondsSinceEpoch.toString();

    final pendingMsg = MessageModel(
      id: tempId,
      sender: myId,
      recipient: partner.id,
      content: content,
      status: MessageStatus.pending,
      createdAt: DateTime.now(),
    );

    messages.insert(0, pendingMsg);
    textController.clear();

    // Gọi Repo để lưu DB
    final savedMsg = await chatRepo.sendMessage(pendingMsg);

    int index = messages.indexOf(pendingMsg);

    if (index != -1) {
      if (savedMsg != null) {
        messages[index] = savedMsg;
        socket.emit('send_message', savedMsg.toJsonForSocket());
      } else {
        messages[index] = pendingMsg.copyWith(status: MessageStatus.failed);
      }
      messages.refresh();
    }
  }

  Future<void> pickAndSendImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 70,
      );

      if (pickedFile == null) return;

      File imageFile = File(pickedFile.path);
      final myId = UserController.instance.user.value.id;

      final pendingMsg = MessageModel(
        sender: myId,
        recipient: partner.id,
        content: pickedFile.path,
        messageType: 'image',
        status: MessageStatus.pending,
        createdAt: DateTime.now(),
      );

      messages.insert(0, pendingMsg);

      // 2. Gọi Repo upload
      final savedMsg = await chatRepo.sendImageMessage(partner.id, imageFile);

      if (savedMsg != null) {
        messages[0] = savedMsg;
        socket.emit('send_message', savedMsg.toJsonForSocket());
      } else {
        messages[0] = pendingMsg.copyWith(status: MessageStatus.failed);
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể chọn ảnh: $e");
    }
  }

  Future<void> pickAndSendVideo(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickVideo(
        source: source,
        maxDuration: const Duration(minutes:15),
      );

      if (pickedFile == null) return;

      File videoFile = File(pickedFile.path);
      final myId = UserController.instance.user.value.id;

      final pendingMsg = MessageModel(
        sender: myId,
        recipient: partner.id,
        content: pickedFile.path,
        messageType: 'video',
        status: MessageStatus.pending,
        createdAt: DateTime.now(),
      );

      messages.insert(0, pendingMsg);
      isLoading.value = true;

      final savedMsg = await chatRepo.sendVideoMessage(partner.id, videoFile);

      if (savedMsg != null) {
        int index = messages.indexOf(pendingMsg);
        if (index != -1) {
          messages[index] = savedMsg;
        } else {
          // Fallback an toàn
          messages[0] = savedMsg;
        }

        socket.emit('send_message', savedMsg.toJsonForSocket());
      } else {
        // 6. Thất bại
        int index = messages.indexOf(pendingMsg);
        if (index != -1) {
          messages[index] = pendingMsg.copyWith(status: MessageStatus.failed);
        }
        Get.snackbar("Lỗi", "Gửi video thất bại");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể chọn hoặc gửi video: $e");
      print("Error picking video: $e");
    } finally {
      isLoading.value = false;
    }
  }
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
          () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: MediaQuery.of(Get.context!).size.height*0.7,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSizes.defaultSpace * 2, horizontal: AppSizes.defaultSpace),
                child: CachedNetworkImage(imageUrl: image),
              ),
            ),
            const SizedBox(height: AppSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(onPressed: () => Get.back(), child: const Text('Close')),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void handleUpdateMessage(MessageModel updatedMsg) {
    int index = messages.indexWhere((m) => m.id == updatedMsg.id);
    if (index != -1) {
      messages[index] = updatedMsg;
      socket.emit('message_update', updatedMsg.toJsonForSocket());
      messages.refresh();
    }
  }

}