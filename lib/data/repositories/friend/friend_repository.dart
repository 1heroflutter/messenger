import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../features/personalization/models/user_model.dart';
import '../../services/network_service.dart';

class FriendRepository extends GetxController {
  static FriendRepository get instance => Get.find();
  final _networkService = NetworkService();

  Future<List<UserModel>> getPendingRequests() async {
    try {
      final response = await _networkService.get('/friend/getPendingRequests', requiresAuth: true);
      if (response?.statusCode == 200) {
        List<dynamic> data = response?.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Lỗi getPendingRequests: $e");
      return [];
    }
  }
  // Gửi lời mời kết bạn
  Future<bool> sendFriendRequest(String userId) async {
    try {
      final response = await _networkService.post(
        '/friend/request/$userId',
        requiresAuth: true,
      );
      return response?.statusCode == 200;
    } catch (e) {
      print("Lỗi sendFriendRequest: $e");
      return false;
    }
  }

  // Chấp nhận lời mời
  Future<bool> acceptFriendRequest(String userId) async {
    print(userId);
    try {
      final response = await _networkService.post(
        '/friend/accept/$userId',
        requiresAuth: true,
      );
      return response?.statusCode == 200;
    } catch (e) {
      print("Lỗi acceptFriendRequest: $e");
      return false;
    }
  }

  // Từ chối lời mời
  Future<bool> rejectFriendRequest(String userId) async {
    try {
      final response = await _networkService.post(
        '/friend/reject/$userId',
        requiresAuth: true,
      );
      return response?.statusCode == 200;
    } catch (e) {
      print("Lỗi rejectFriendRequest: $e");
      return false;
    }
  }

  // Lấy danh sách bạn bè
  Future<List<UserModel>> getFriendList() async {
    try {
      final response = await _networkService.get('/friend/list', requiresAuth: true);
      if (response?.statusCode == 200) {
        List<dynamic> data = response?.data;
        return data.map((json) => UserModel.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      print("Lỗi getFriendList: $e");
      return [];
    }
  }
}