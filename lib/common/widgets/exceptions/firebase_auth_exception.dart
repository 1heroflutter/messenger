/// Exception cho các lỗi liên quan đến Firebase Authentication.
class BasicFirebaseAuthException implements Exception {
  final String code;

  BasicFirebaseAuthException({required this.code});

  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'This email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address provided is invalid. Please enter a valid email.';
      case 'weak-password':
        return 'The password is too weak. Please choose a stronger password.';
      case 'user-disabled':
        return 'This user account has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email. Please sign up first.';
      case 'wrong-password':
        return 'Incorrect password. Please check your password and try again.';
      case 'invalid-credential':
        return 'Invalid credential. Please check your email and password.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Contact support for assistance.';
      case 'requires-recent-login':
        return 'This operation is sensitive and requires recent authentication. Please log in again.';
      default:
        return 'An unexpected authentication error occurred. Please try again.';
    }
  }
}