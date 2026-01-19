// Lỗi liên quan đến format
class BasicFormatException implements Exception {
  final String message;
  const BasicFormatException([this.message = 'An unexpected format error occurred. Please check your input.']);

  factory BasicFormatException.fromMessage(String message) {
    return BasicFormatException(message);
  }
}