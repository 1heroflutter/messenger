import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:messenger/utils/popups/full_screen_loader.dart';

import 'network_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final NetworkService _networkService = NetworkService();
  /// 1. Gửi mã OTP
  Future<void> verifyPhoneNumber(String phoneNumber, Function(String) onCodeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Lỗi gửi OTP: ${e.message}");
        Get.snackbar("Error:", "Your phone number is invalid.!");
        FullScreenLoader.stopLoading();
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// 2. Xác thực OTP và Đồng bộ với Backend
  Future<bool> loginWithOtp(String verificationId, String smsCode) async {
    try {
      // 1. Tạo credential
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      // 2. Đăng nhập vào Firebase
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        final response = await _networkService.post('/auth/verify', requiresAuth: true);

        if (response?.statusCode == 200 || response?.statusCode == 201) {
          return true;
        } else {
          throw 'Backend verify failed: ${response?.statusCode}';
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Mã OTP không chính xác.';
    } catch (e) {
      rethrow;
    }
  }

  /// 3. Thiết lập mã PIN mới
  Future<bool> setPin(String pin) async {
    try {
      final response = await _networkService.post(
        '/pin/set',
        requiresAuth: true,
        data: {'pin': pin},
      );

      if (response?.statusCode == 200) {
        return true;
      } else {
        // Lấy message lỗi từ backend nếu có
        throw response?.data['message'] ?? 'Không thể thiết lập mã PIN';
      }
    } catch (e) {
      print("Lỗi setPin: $e");
      rethrow;
    }
  }

  /// 4. Xác thực mã PIN đã có
  Future<bool> verifyPin(String pin) async {
    try {
      final response = await _networkService.post(
        '/pin/verify',
        requiresAuth: true,
        data: {'pin': pin},
      );

      if (response?.statusCode == 200) {
        return true;
      } else {
        throw response?.data['message'] ?? 'Mã PIN không chính xác';
      }
    } catch (e) {
      print("Lỗi verifyPin: $e");
      rethrow;
    }
  }
}