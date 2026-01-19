import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:messenger/data/services/network_service.dart';
import '../../../features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _networkService = NetworkService();

  Future<List<UserModel>> getUsersByPhoneNumber({required String phoneNumber}) async {
    try {
      final response = await _networkService.get(
        '/user/search',
        requiresAuth: true,
        queryParameters: {'phoneNumber': phoneNumber},
      );

      if (response?.statusCode == 200) {
        List<dynamic> data = response?.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Lỗi search: $e");
      return [];
    }
  }
  Future<void> updateFcmToken(String token) async {
    try {
      final response = await _networkService.post(
        '/user/me/update-fcm-token',
        data: {'fcmToken': token},
      );
      if (response?.statusCode != 200) {
        print("Không thể cập nhật Token lên Server");
      }
    } catch (e) {
      print("Lỗi updateFcmToken Repo: $e");
    }
  }
  Future<UserModel?> getMyProfile() async {
    try {
      final response = await _networkService.get('/user/me/profile', requiresAuth: true);

      if (response?.statusCode == 200) {
        return UserModel.fromJson(response?.data);
      }
      return null;
    } catch (e) {
      print("Lỗi lấy Profile: $e");
      return null;
    }
  }
  Future<UserModel?> uploadAvatar(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      dio.FormData formData = dio.FormData.fromMap({
        "avatar": await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _networkService.post(
        '/user/me/update-avatar',
        data: formData,
        requiresAuth: true,
      );

      if (response?.statusCode == 200) {
        return UserModel.fromJson(response?.data['user']);
      }
      return null;
    } catch (e) {
      print("Lỗi upload: $e");
      return null;
    }
  }
  Future<void> updateOnlineStatus(bool isOnline) async {
    await _networkService.patch(
      '/user/me/online-status',
      data: {'isOnline': isOnline},
      requiresAuth: true,
    );
  }
  Future<UserModel?> updateProfile(Map<String, dynamic> json) async {
    try {
      final response = await _networkService.patch(
        '/user/me/update-profile',
        data: json,
        requiresAuth: true,
      );

      if (response?.statusCode == 200) {
        return UserModel.fromJson(response?.data['user']);
      }
      return null;
    } catch (e) {
      print("Lỗi updateProfile: $e");
      return null;
    }
  }

}