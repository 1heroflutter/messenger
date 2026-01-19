
import 'package:get/get.dart';
import 'package:messenger/features/authentication/controllers/login/login_controller.dart';
import 'package:messenger/features/message/controllers/add/add_controller.dart';
import 'package:messenger/features/personalization/controllers/user/user_controller.dart';

import '../../data/repositories/authentication/authentication_repository.dart';
import '../../utils/network/network_manager.dart';


class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepository(),);
    Get.put(NetworkManager());
    Get.put(LoginController());
    Get.lazyPut(() => AddController());
  }
}