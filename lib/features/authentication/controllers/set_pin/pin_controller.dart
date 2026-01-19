
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:messenger/navigation_menu.dart';

import '../../../../data/repositories/authentication/authentication_repository.dart';
import '../../../../utils/constants/app_animations.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/validators/validation.dart';

class PinController extends GetxController {
  static PinController get instance =>Get.find();
  // Variables
  final rememberMe = true.obs;
  final authRepo = AuthenticationRepository.instance;
  final pin = TextEditingController();

  GlobalKey<FormState> setPinFormKey = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();
  } // --- Email and Pas
  @override
  void onClose() {
    pin.clear();
    super.onClose();
  }
  void handleSetPIN() async {
    FullScreenLoader.openLoadingDialog(
      'Setting up PIN code...',
      AppAnimations.loading,
    );
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      FullScreenLoader.stopLoading();
      return;
    }
    final error = Validator.validatePIN(pin.text);
    if (error != null) {
      FullScreenLoader.stopLoading();
      Get.snackbar("Lỗi", error);
      return;
    }

    try {
      await authRepo.handleSetPIN(pin.text, () async {
        FullScreenLoader.stopLoading();
        Get.offAll(NavigationMenu());
      });
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar("Lỗi", e.toString());
    }
  }


}
