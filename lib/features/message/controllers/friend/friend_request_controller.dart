import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/repositories/friend/friend_repository.dart';
import '../../../personalization/models/user_model.dart';

class FriendRequestController extends GetxController {
  static FriendRequestController get instance => Get.find();

  final friendRepository = Get.put(FriendRepository());
  RxList<UserModel> pendingRequests = <UserModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPendingRequests();
  }

  // Lấy danh sách lời mời
  Future<void> fetchPendingRequests() async {
    isLoading.value = true;
    final results = await friendRepository.getPendingRequests();
    pendingRequests.assignAll(results);
    isLoading.value = false;
  }

  // Chấp nhận
  Future<void> handleAccept(UserModel user) async {
    if (user.requestId == null) return;
    // 1. Gọi API accept
    final success = await friendRepository.acceptFriendRequest(user.requestId!);

    if (success) {
      // 2. Xóa khỏi danh sách UI ngay lập tức
      pendingRequests.removeWhere((item) => item.requestId == user.requestId);
      Get.snackbar("Thành công", "Đã trở thành bạn bè với ${user.displayName}");
    }
  }

  // Từ chối/Xóa
  Future<void> rejectRequest(String userId) async {
    final success = await friendRepository.rejectFriendRequest(userId);
    if (success) {
      pendingRequests.removeWhere((u) => u.id == userId);
      Get.snackbar("Thông báo", "Đã xóa lời mời");
    }
  }
}