import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../../features/authentication/screens/login/login.dart';
import '../../../features/authentication/screens/onboarding/onboarding.dart';
import '../../../features/personalization/controllers/user/user_controller.dart';
import '../../../features/personalization/models/user_model.dart';
import '../../../navigation_menu.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../services/auth_service.dart';
import '../../services/network_service.dart';
import '../user/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final _authService = AuthService();

  String _verificationId = "";

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    var user = _auth.currentUser;
    final userController = Get.put(UserController(), permanent: true);
    if (user != null) {
      await LocalStorage.init(user.uid);
      await userController.fetchUserRecord();
      await UserRepository.instance.updateOnlineStatus(true);
      Get.offAll(() => const NavigationMenu());
    } else {
      deviceStorage.writeIfNull('IsFirstTime', true);
      deviceStorage.read('IsFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }


  /// BƯỚC 1: Gửi mã OTP
  Future<void> sendOtp(String phoneNumber, VoidCallback onSuccess) async {
    try {
      await _authService.verifyPhoneNumber(phoneNumber, (verificationId) {
        _verificationId = verificationId;
        onSuccess();
      });
    } catch (e) {
      throw 'Không thể gửi mã OTP. Vui lòng thử lại.';
    }
  }

  Future<void> verifyOtpAndLogin(String smsCode, VoidCallback onSuccess) async {
    try {
      final isSuccess = await _authService.loginWithOtp(_verificationId, smsCode);

      if (isSuccess) {
        Future.delayed(const Duration(milliseconds: 100), () {
          FullScreenLoader.stopLoading();
          onSuccess();
        });
      }
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar("Error", e.toString());
    }
  }
  Future<void> handleSetPIN(String pin, VoidCallback onSuccess) async{
    try{
      final isSuccess = await _authService.setPin(pin);
      if(isSuccess){
        FullScreenLoader.stopLoading();
        onSuccess();
      }
    }catch(e){
      FullScreenLoader.stopLoading();
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> verifyPin(String pin, VoidCallback onSuccess) async{
    try{
      final isSuccess = await _authService.verifyPin(pin);
      if(isSuccess){
        FullScreenLoader.stopLoading();
        onSuccess();
      }
    }catch(e){
      FullScreenLoader.stopLoading();
      Get.snackbar("Error", e.toString());
    }
  }

  /// Đăng xuất
  Future<void> logout() async {
    try {
      await UserRepository.instance.updateOnlineStatus(false);
      await _auth.signOut();
      if (Get.isRegistered<UserController>()) {
        UserController.instance.onLogout();
      }
      Get.delete<UserController>(force: true);
      Get.delete<NavigationController>(force: true);
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
