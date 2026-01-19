/// Exception cho các lỗi chung của Firebase.
class BasicFirebaseException implements Exception {
  final String code;

  BasicFirebaseException({required this.code});

  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-argument':
        return 'Invalid argument provided to the Firebase service.';
      case 'not-found':
        return 'The requested document or resource was not found.';
      case 'permission-denied':
        return 'You do not have permission to perform this action.';
      case 'unavailable':
        return 'The Firebase service is temporarily unavailable. Please try again later.';
      case 'unauthenticated':
        return 'You are unauthenticated. Please log in to perform this action.';
      case 'deadline-exceeded':
        return 'The operation timed out. Please check your connection and try again.';
      default:
        return 'A Firebase error occurred. Please try again.';
    }
  }
}