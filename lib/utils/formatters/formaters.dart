import 'package:intl/intl.dart';

class Formatters {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatMessageTime(DateTime date) {
    return DateFormat('HH:mm').format(date);
  }
  static String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
    ).format(amount);
  }

  static String formatPhoneNumber(String rawPhone) {
    String phone = rawPhone.trim().replaceAll(' ', '');

    // Nếu người dùng nhập bắt đầu bằng 084... hoặc 84...
    if (phone.startsWith('084')) {
      return '+${phone.substring(1)}'; // 084301... -> +84301...
    } else if (phone.startsWith('84') && !phone.startsWith('+')) {
      return '+$phone'; // 84301... -> +84301...
    } else if (phone.startsWith('0')) {
      return '+84${phone.substring(1)}'; // 0398... -> +84398...
    } else if (!phone.startsWith('+')) {
      return '+84$phone'; // 398... -> +84398...
    }

    return phone; // Đã có sẵn dấu +
  }

  static String internationalFormatPhoneNumber(String phoneNumber) {
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return formattedNumber.toString();
  }
}
