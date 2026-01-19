import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? '192.168.1.33';
}
