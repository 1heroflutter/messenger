import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:messenger/utils/network/network_manager.dart';

import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../data/repositories/friend/friend_repository.dart';
import '../../../../data/repositories/user/user_repository.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/formatters/formaters.dart';
import '../../../personalization/models/user_model.dart';

class AddController extends GetxController {
  static AddController get instance => Get.find();

  final phoneNo = TextEditingController();
  final userRepository = Get.put(UserRepository());
  final friendRepository = FriendRepository.instance;

  RxList<UserModel> featuredUsers = <UserModel>[].obs;
  RxBool isLoading = false.obs;
  GlobalKey<FormState> addFormKey = GlobalKey<FormState>();

  Future<void> sendRequest(String userId) async {
    final success = await friendRepository.sendFriendRequest(userId);

    if (success) {
      int index = featuredUsers.indexWhere((u) => u.id == userId);
      if (index != -1) {
        UserModel user = featuredUsers[index];
        featuredUsers[index] = UserModel(
          id: user.id,
          uid: user.uid,
          phoneNumber: user.phoneNumber,
          displayName: user.displayName,
          avatar: user.avatar,
          relationship: FriendRelationship.pending,
        );
      }
      Get.snackbar("Thành công", "Đã gửi lời mời kết bạn");
    } else {
      Get.snackbar("Lỗi", "Không thể gửi lời mời, vui lòng thử lại");
    }
  }

  @override
  void onClose() {
    phoneNo.dispose();
    super.onClose();
  }

  Future<void> searchUser() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        Get.snackbar("Lỗi", "Không có kết nối mạng");
        return;
      }
      // 2. Validate Form
      if (!addFormKey.currentState!.validate()) {
        return;
      }
      isLoading.value = true;
      String rawPhone = phoneNo.text.trim();
      String formattedPhone = Formatters.formatPhoneNumber(rawPhone);
      final results = await userRepository.getUsersByPhoneNumber(phoneNumber: formattedPhone);
      // 5. Cập nhật danh sách hiển thị
      featuredUsers.assignAll(results);
      if (results.isEmpty) {
        print("Không tìm thấy người dùng");
      }
    } catch (e) {
      Get.snackbar("Lỗi", "Đã xảy ra lỗi khi tìm kiếm: $e");
    } finally {
      // Kết thúc Loading
      isLoading.value = false;
    }
  }
}
