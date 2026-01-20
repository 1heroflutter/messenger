import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../data/repositories/user_information/user_information_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../personalization/models/user_model.dart';
import '../chat/chat_controller.dart';
// Import UserModel và Repository

class UserInformationController extends GetxController {
  final UserModel user;

  UserInformationController({required this.user});
  final ImagePicker _picker = ImagePicker();
  final repo = Get.put(UserInformationRepository());

  // --- Observables (State) ---
  RxBool isMuted = false.obs;
  RxBool isProtected = true.obs;
  RxBool isHidden = false.obs;
  RxBool isHistoryHidden = false.obs;
  RxBool isBlocked = false.obs;
  Rx<Color> themeColor = const Color(0xFF2196F3).obs;
  RxString backgroundImage = ''.obs;
  String? conversationId;
  // --- Logic Methods ---
  @override
  void onInit() {
    super.onInit();
    fetchConversationSettings();
  }
  void fetchConversationSettings() async {
    final data = await repo.getConversationDetails(user.id);
    if (data != null) {
      conversationId = data['_id'];
      if (data['themeColor'] != null) {
        try {
          themeColor.value = Color(int.parse(data['themeColor']));
        } catch (_) {}
      }
      // Parse ảnh nền
      if (data['backgroundImage'] != null) {
        backgroundImage.value = data['backgroundImage'];
      }
    }
  }
  void copyPhoneNumber() {
    Clipboard.setData(ClipboardData(text: user.phoneNumber));
    Get.snackbar("Success", "Copied phone number to clipboard",
        snackPosition: SnackPosition.BOTTOM, margin: const EdgeInsets.all(10));
  }

  void toggleMute(bool value) async {
    isMuted.value = value;
    final success = await repo.toggleMuteUser(user.id, value);
    if (!success) isMuted.value = !value;
  }

  void toggleProtected(bool value) => isProtected.value = value;

  void toggleHideChat(bool value) => isHidden.value = value;

  void toggleHideHistory(bool value) => isHistoryHidden.value = value;

  void onBlockUser() {
    Get.defaultDialog(
      title: "Block User",
      middleText: "Are you sure you want to block ${user
          .displayName}? You won't receive any messages from them.",
      textConfirm: "Block",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back(); // Đóng dialog
        final success = await repo.blockUser(user.id);
        if (success) {
          isBlocked.value = true;
          Get.snackbar("Blocked", "${user.displayName} has been blocked.");
        } else {
          Get.snackbar("Error", "Failed to block user.");
        }
      },
    );
  }

  void onReportUser() {
    Get.defaultDialog(
      title: "Report User",
      middleText: "Select a reason to report this user.",
      // Có thể custom thêm nội dung chọn lý do ở đây
      textConfirm: "Report Spam",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () async {
        Get.back();
        final success = await repo.reportUser(user.id, "spam");
        if (success) {
          Get.snackbar("Reported", "Thanks for your report.");
        }
      },
    );
  }

  void showColorPickerDialog(BuildContext context) {
    Color tempColor = themeColor.value;

    Get.defaultDialog(
      title: "Change message color",
      titlePadding: const EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.all(20),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: tempColor,
          onColorChanged: (value) {
            tempColor = value;
          },
          enableAlpha: false,
          labelTypes: const [],
          pickerAreaHeightPercent: 0.7,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
          onPressed: () {
            _applyNewColor(tempColor);
            Get.back();
          },
          child: const Text('Choose', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
  void _applyNewColor(Color color) async {
    if (conversationId == null) return;

    Color oldColor = themeColor.value;
    themeColor.value = color;

    String colorString = '0x${color.value.toRadixString(16).toUpperCase()}';

    // 3. Gọi API
    final success = await repo.updateThemeColor(conversationId!, colorString);

    if (!success) {
      if (Get.isRegistered<ChatController>(tag: user.id)) {
        final chatController = Get.find<ChatController>(tag: user.id);
        chatController.themeColor.value = color;
      }
    }
  }

  /// 3. Hàm chọn và đổi hình nền
  void pickAndUploadBackground() async {
    if (conversationId == null) return;

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      File file = File(image.path);

      // Hiển thị loading...
      Get.dialog(const Center(child: CircularProgressIndicator()), barrierDismissible: false);

      final newUrl = await repo.updateBackgroundImage(conversationId!, file);

      Get.back(); // Tắt loading

      if (newUrl != null) {
        backgroundImage.value = newUrl;
        if (Get.isRegistered<ChatController>(tag: user.id)) {
          final chatController = Get.find<ChatController>(tag: user.id);
          chatController.backgroundImage.value = newUrl;
        }
        Get.snackbar("Success", "Background updated");
      } else {
        Get.snackbar("Error", "Failed to upload background");
      }
    } catch (e) {
      Get.back();
      print(e);
    }
  }
  void viewMedia() {
    // Get.to(() => UserMediaScreen(userId: user.id));
    Get.snackbar("Feature", "View Media Screen");
  }

  void makeCall(bool isVideo) {
    Get.snackbar("Call", "Calling ${user.displayName}...");
  }
}