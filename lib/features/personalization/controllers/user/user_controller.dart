import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../models/user_model.dart';

class UserController extends GetxController with WidgetsBindingObserver{
  static UserController get instance => Get.find();
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());
  final displayNameController = TextEditingController();
  final phoneController = TextEditingController();
  RxBool isLoading = false.obs;
  @override
  void onInit(){
    super.onInit();
    WidgetsBinding.instance.removeObserver(this);
    fetchUserRecord().then((_){
      updateFCMToken();
    });
  }
  @override
  void onClose() {
    displayNameController.dispose();
    phoneController.dispose();
    WidgetsBinding.instance.addObserver(this);
    super.onClose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      userRepository.updateOnlineStatus(true);
    }
    else if (state == AppLifecycleState.paused || state == AppLifecycleState.detached) {
      userRepository.updateOnlineStatus(false);
    }
  }
  // Hàm xử lý FCM Token
  Future<void> updateFCMToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        user.value = user.value.copyWith(fcmToken: token);
        await userRepository.updateFcmToken(token);
        print('FCM Token updated successfully: $token');
      }
    } catch (e) {
      print("Lỗi lấy FCM Token: $e");
    }
  }
  Future<void> fetchUserRecord() async {
    try {
      isLoading.value = true;
      final userRecord = await userRepository.getMyProfile();
      if (userRecord != null) {
        user.value = userRecord;
        displayNameController.text= user.value.displayName;
        phoneController.text= user.value.phoneNumber;
      }
    } catch (e) {
      user.value = UserModel.empty();
    } finally {
      isLoading.value = false;
    }
  }
  Future<void> changeAvatar() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 70);

      if (image != null) {
        isLoading.value = true;
        final updatedUser = await userRepository.uploadAvatar(File(image.path));

        if (updatedUser != null) {
          user.value = updatedUser;
          Get.snackbar("Thành công", "Đã cập nhật ảnh đại diện");
        }
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Không thể cập nhật ảnh");
    } finally {
      isLoading.value = false;
    }
  }
  void refreshTextFields() {
    displayNameController.text = user.value.displayName;
    phoneController.text = user.value.phoneNumber.replaceAll("+84", "");
  }
  Future<void> updateUserProfile() async {
    try {
      final name = displayNameController.text.trim();
      if (name.isEmpty) {
        Get.snackbar("Thông báo", "Tên không được để trống");
        return;
      }

      isLoading.value = true;
      final Map<String, dynamic> data = {'displayName': name};

      final updatedUser = await userRepository.updateProfile(data);
      if (updatedUser != null) {
        user.value = updatedUser;
        refreshTextFields();
        Get.snackbar("Thành công", "Đã cập nhật hồ sơ");
        if (Get.isBottomSheetOpen ?? false) {
          Get.back();
        }
      }
    } catch (e) {
      Get.snackbar("Lỗi", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void onLogout() {
    user.value = UserModel.empty();
  }
}