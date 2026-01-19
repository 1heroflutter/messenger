import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../../data/repositories/chat/conversation_repository.dart';
import '../../../../data/repositories/friend/friend_repository.dart';
import '../../../personalization/models/user_model.dart';
import '../../models/conversation_model.dart';
class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  // 1. Repositories
  final friendRepository = Get.put(FriendRepository());
  final conversationRepository = Get.put(ConversationRepository()); // Thêm cái này

  // 2. State Data
  RxList<UserModel> friends = <UserModel>[].obs;
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllData();

    // TODO: Lắng nghe Socket để cập nhật lại list chat khi có tin nhắn mới
    // socket.on('new_message', (_) => fetchConversations());
  }

  // Gọi cả 2 API cùng lúc
  Future<void> fetchAllData() async {
    isLoading.value = true;

    await Future.wait([
      fetchFriends(),
      fetchConversations(),
    ]);

    isLoading.value = false;
  }

  Future<void> fetchFriends() async {
    try {
      final list = await friendRepository.getFriendList();
      friends.assignAll(list);
    } catch (e) {
      print("Lỗi fetch friends: $e");
    }
  }

  Future<void> fetchConversations() async {
    try {
      final list = await conversationRepository.getConversations();
      conversations.assignAll(list);
    } catch (e) {
      print("Lỗi fetch conversations: $e");
    }
  }
}