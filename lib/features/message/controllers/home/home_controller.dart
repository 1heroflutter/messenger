import 'package:flutter/cupertino.dart';
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
  final scrollController = ScrollController();
  final conversationRepository = Get.put(ConversationRepository());
  RxBool showScrollToTopBtn = false.obs;

  // 2. State Data
  RxList<UserModel> friends = <UserModel>[].obs;
  RxList<ConversationModel> conversations = <ConversationModel>[].obs;

  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    scrollController.addListener(() {
      if (scrollController.hasClients) {
        double offset = scrollController.offset;
        if (offset > 400 && !showScrollToTopBtn.value) {
          showScrollToTopBtn.value = true;
        } else if (offset <= 400 && showScrollToTopBtn.value) {
          showScrollToTopBtn.value = false;
        }
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchAllData();
    });
  }


  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  Future<void> refreshData() async {
    fetchAllData();
  }

  Future<void> fetchAllData() async {
    isLoading.value = true;
    try {
      await Future.wait([fetchFriends(), fetchConversations()]);
    } finally {
      isLoading.value = false;
    }
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
