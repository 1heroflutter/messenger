import '../../personalization/models/user_model.dart';
import 'message_model.dart';

class ConversationModel {
  final String id;
  final List<UserModel> participants;
  final MessageModel? lastMessage;
  final String themeColor;
  final DateTime updatedAt;

  ConversationModel({
    required this.id,
    required this.participants,
    this.lastMessage,
    required this.themeColor,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      participants: (json['participants'] as List)
          .map((e) => UserModel.fromJson(e))
          .toList(),
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson(json['lastMessage'])
          : null,
      themeColor: json['themeColor'] ?? "0xFF2196F3",
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}