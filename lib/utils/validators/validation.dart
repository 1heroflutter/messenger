class Validator{
  static String? validateEmptyText(String? fieldName, String? value){
    if(value==null||value.isEmpty) return "$fieldName is required.";
    return null;
  }

  static String? validateOTP(String? value){
    if(value==null||value.isEmpty){
      return "Pin is required.";
    }
    if(value.length<6){
      return "Pin must be at least 6 characters long.";
    }
  }
  static String? validatePIN(String? value){
    if(value==null||value.isEmpty){
      return "Pin is required.";
    }
    if(value.length<4){
      return "Pin must be at least 4 characters long.";
    }
  }
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) return 'Vui lòng nhập số điện thoại';

    // Kiểm tra độ dài cơ bản (từ 9-11 số)
    final phoneRegExp = RegExp(r'^\d{9,11}$');
    if (!phoneRegExp.hasMatch(value.replaceAll(RegExp(r'\D'), ''))) {
      return 'Số điện thoại không hợp lệ';
    }
    return null;
  }
  
}