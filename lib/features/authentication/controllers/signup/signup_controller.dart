import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messenger/data/repositories/authentication/authentication_repository.dart';
import 'package:messenger/features/authentication/screens/security_setting/pin_setup.dart';
import 'package:messenger/features/authentication/screens/signup/setup_profile.dart';
import 'package:messenger/features/authentication/screens/signup/signup.dart';
import '../../../../common/widgets/loaders/loaders.dart';
import '../../../../utils/constants/app_animations.dart';
import '../../../../utils/network/network_manager.dart';
import '../../../../utils/popups/full_screen_loader.dart';

class SignupController extends GetxController {
  static SignupController get instance =>Get.find();
  // Variables
  final rememberMe = true.obs;
  final localStorage = GetStorage();
  final authRepo = AuthenticationRepository.instance;
  final phoneNo = TextEditingController();
  final otp = TextEditingController();
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  void updatePageIndicator(index)=>currentPageIndex.value = index;

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
  // final userController= UserController();


  @override
  void onInit() {
    phoneNo.text = localStorage.read("REMEMBER_ME_PHONENUMBER");
    super.onInit();
  } // --- Email and Pas
  @override
  void onClose() {
    phoneNo.dispose();
    otp.dispose();
    pageController.dispose();
    super.onClose();
  }
  void nextPage() {
    // Kiểm tra xem controller đã gắn vào PageView chưa
    // if (pageController.hasClients) {
      if (currentPageIndex.value >= 1) {
        Get.to(SetupProfileScreen());
      } else {
        int page = currentPageIndex.value + 1;
        pageController.animateToPage(
          page,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    // } else {
    //   print("PageController chưa sẵn sàng");
    // }
  }
  void phoneNumberSignUp() async {
    FullScreenLoader.openLoadingDialog(
      'Verifying your phone number...',
      AppAnimations.loading,
    );
    final isConnected = await NetworkManager.instance.isConnected();
    if (!isConnected) {
      FullScreenLoader.stopLoading();
      return;
    }
    if (!signupFormKey.currentState!.validate()) {
      FullScreenLoader.stopLoading();
      return;
    }
    if(rememberMe.value){
      await localStorage.write('REMEMBER_ME_PHONENUMBER', phoneNo.text.trim());
    }
    String rawPhone = phoneNo.text.trim();
    String formattedPhone = rawPhone;

    if (rawPhone.startsWith('0')) {
      formattedPhone = '+84${rawPhone.substring(1)}';
    } else if (!rawPhone.startsWith('+')) {
      formattedPhone = '+84$rawPhone';
    }

    try {
      await authRepo.sendOtp(formattedPhone, () async {
        pageController.animateToPage(
          1,
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        );
        FullScreenLoader.stopLoading();
      });
    } catch (e) {
      FullScreenLoader.stopLoading();
      Get.snackbar("Lỗi", e.toString());
    }
  }

  void verifyOtp() async {
    try {
      // Start Loading
      FullScreenLoader.openLoadingDialog(
        'OTP verification in progress...',
        AppAnimations.loading,
      );

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        FullScreenLoader.stopLoading();
        return;
      }

      await authRepo.verifyOtpAndLogin(otp.text, () => Get.to(PinSetupScreen()),);
      // await userController.saveUserRecord(userCredentials);
    } catch (e) {
      FullScreenLoader.stopLoading();
      Loaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
