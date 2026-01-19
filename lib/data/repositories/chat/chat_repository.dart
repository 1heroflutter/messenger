import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../features/message/models/message_model.dart';
import '../../services/network_service.dart';

class ChatRepository extends GetxController {
  static ChatRepository get instance => Get.find();
  final _networkService = NetworkService();

  Future<List<MessageModel>> getChatHistory(String partnerId, {int page = 1}) async {
    try {
      final response = await _networkService.get(
          '/chat/history/$partnerId',
          queryParameters: {'page': page}
      );
      if (response?.statusCode == 200) {
        final List<dynamic> data = response?.data;
        return data.map((json) => MessageModel.fromJson(json)).toList();
      }
    } catch (e) {
      print("Lỗi ChatRepository: $e");
    }
    return [];
  }

// ChatRepository
  Future<MessageModel?> sendMessage(MessageModel message) async {
    try {
      final response = await _networkService.post(
        '/chat/messages',
        data: {
          'recipientId': message.recipient,
          'content': message.content,
          'messageType': message.messageType,
        },
        requiresAuth: true,
      );

      if (response != null && (response.statusCode == 201 || response.statusCode == 200)) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }
        if (responseData is Map) {
          return MessageModel.fromJson(Map<String, dynamic>.from(responseData));
        }
      }
    } catch (e) {
      // In log chi tiết để biết chính xác lỗi tại dòng nào
      print("Lỗi ChatRepository (sendMessage): $e");
    }
    return null;
  }

  Future<MessageModel?> sendImageMessage(String recipientId, File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;

      // Tạo FormData để gửi file
      dio.FormData formData = dio.FormData.fromMap({
        "recipientId": recipientId,
        "messageType": "image",
        "content": "image_placeholder",
        "image": await dio.MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _networkService.post(
        '/chat/messages/image',
        data: formData,
        requiresAuth: true,
      );

      if (response?.statusCode == 201) {
        return MessageModel.fromJson(response?.data);
      }
    } catch (e) {
      print("Lỗi upload ảnh: $e");
    }
    return null;
  }

  Future<MessageModel?> sendVideoMessage(String recipientId, File videoFile) async {
    try {
      String fileName = videoFile.path.split('/').last;

      // Tạo FormData để gửi file
      dio.FormData formData = dio.FormData.fromMap({
        "recipientId": recipientId,
        "messageType": "video",
        "content": "video_placeholder",
        "video": await dio.MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
        ),
      });

      final response = await _networkService.post(
        '/chat/messages/video',
        data: formData,
        requiresAuth: true,
      );

      if (response?.statusCode == 201) {
        return MessageModel.fromJson(response?.data);
      }
    } catch (e) {
      print("Lỗi upload video: $e");
    }
    return null;
  }

  Future<MessageModel?> editMessage(String messageId, String newContent) async {
    final response = await _networkService.patch(
      '/chat/messages/$messageId',
      data: {'newContent': newContent},
    );
    if (response?.statusCode == 200) return MessageModel.fromJson(response?.data);
    return null;
  }

  Future<MessageModel?> deleteMessage(String messageId) async {
    final response = await _networkService.delete('/chat/messages/$messageId');
    if (response?.statusCode == 200) return MessageModel.fromJson(response?.data);
    return null;
  }
}