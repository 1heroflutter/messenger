import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/repositories/user/user_repository.dart';
import '../../../personalization/models/user_model.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  final userRepository = Get.put(UserRepository());

  Rx<UserModel> user = UserModel.empty().obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;
      final data = await userRepository.getMyProfile();
      if (data != null) {
        user.value = data;
      }
    } finally {
      isLoading.value = false;
    }
  }
}