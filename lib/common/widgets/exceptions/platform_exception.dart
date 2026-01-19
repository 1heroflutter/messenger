/// Exception cho các lỗi liên quan đến nền tảng (Platform-specific).
class BasicPlatformException implements Exception {
  final String code;

  BasicPlatformException({required this.code});

  String get message {
    switch (code) {
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'network-request-failed':
        return 'Network request failed. Please check your internet connection.';
      case 'sign_in_failed':
        return 'Sign-in failed. Please try again or use a different method.';
      case 'operation-in-progress':
        return 'An operation is already in progress. Please wait.';
      case 'user-cancelled':
        return 'The operation was cancelled by the user.';
      default:
        return 'An unexpected platform error occurred. Please try again.';
    }
  }
}
