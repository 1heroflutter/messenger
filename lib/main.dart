import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:messenger/common/bindings/general_bindings.dart';
import 'package:messenger/data/repositories/authentication/authentication_repository.dart';
import 'package:messenger/data/services/notification_service.dart';
import 'package:messenger/utils/config/env_config.dart';
import 'package:messenger/utils/constants/colors.dart';
import 'package:messenger/utils/theme/theme.dart';
import 'package:messenger/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await EnvConfig.init();
  await GetStorage.init();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService.init();
  Get.put(AuthenticationRepository());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.lightTheme,
      initialBinding: GeneralBindings(),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(child: CircularProgressIndicator(color: AppColors.white)),
      ),
    );
  }
}
