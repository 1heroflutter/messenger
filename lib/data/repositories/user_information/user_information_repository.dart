import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

import '../../services/network_service.dart';

class UserInformationRepository extends GetxService {
  static UserInformationRepository get instance => Get.find();

  final NetworkService _networkService = NetworkService();

  /// 1. Chặn người dùng (Block)
  /// Giả định Backend route: POST /api/users/block
  Future<bool> blockUser(String targetUserId) async {
    try {
      final response = await _networkService.post(
        '/user/block',
        data: {
          'targetId': targetUserId,
        },
        requiresAuth: true,
      );

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error blocking user: $e");
      return false;
    }
  }

  /// 2. Báo cáo người dùng (Report)
  /// Giả định Backend route: POST /api/users/report
  Future<bool> reportUser(String targetUserId, String reason) async {
    try {
      final response = await _networkService.post(
        '/user/report',
        data: {
          'targetId': targetUserId,
          'reason': reason,
        },
        requiresAuth: true,
      );

      if (response != null && (response.statusCode == 200 || response.statusCode == 201)) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error reporting user: $e");
      return false;
    }
  }

  /// 3. Tắt thông báo (Mute)
  Future<bool> toggleMuteUser(String targetUserId, bool isMuted) async {
    try {
      final response = await _networkService.patch(
        '/user/mute',
        data: {
          'targetId': targetUserId,
          'isMuted': isMuted,
        },
        requiresAuth: true,
      );

      if (response != null && response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print("Error muting user: $e");
      return false;
    }
  }
  Future<Map<String, dynamic>?> getConversationDetails(String targetUserId) async {
    try {
      final response = await _networkService.post(
        '/conversation/get-or-create',
        data: {'partnerId': targetUserId},
        requiresAuth: true,
      );

      if (response != null && response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      print("Error fetching conversation: $e");
    }
    return null;
  }
  /// 5. Cập nhật màu chủ đạo
  Future<bool> updateThemeColor(String conversationId, String colorHex) async {
    try {
      final response = await _networkService.patch(
        '/conversation/theme',
        data: {
          'conversationId': conversationId,
          'themeColor': colorHex, // Gửi mã hex dạng string (vd: "0xFF2196F3")
        },
        requiresAuth: true,
      );
      return response != null && response.statusCode == 200;
    } catch (e) {
      print("Error updating theme: $e");
      return false;
    }
  }

  /// 6. Cập nhật hình nền
  Future<String?> updateBackgroundImage(String conversationId, File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      dio.FormData formData = dio.FormData.fromMap({
        "conversationId": conversationId,
        "background": await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _networkService.patch(
        '/conversation/background',
        data: formData,
        requiresAuth: true,
      );

      if (response != null && response.statusCode == 200) {
        return response.data['backgroundImage'];
      }
    } catch (e) {
      print("Error updating background: $e");
    }
    return null;
  }
}