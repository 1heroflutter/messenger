import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../../features/message/models/conversation_model.dart';
import '../../services/network_service.dart';

class ConversationRepository extends GetxService {
  final NetworkService _networkService = NetworkService();

  Future<List<ConversationModel>> getConversations() async {
    try {
      final response = await _networkService.get('/conversation/list', requiresAuth: true);

      if (response != null && response.statusCode == 200) {
        final List data = response.data;
        return data.map((e) => ConversationModel.fromJson(e)).toList();
      }
    } catch (e) {
      print("Error fetching conversations: $e");
    }
    return [];
  }
}