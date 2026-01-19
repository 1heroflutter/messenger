import '../../../utils/constants/enums.dart';

class MessageModel {
  final String? id;
  final String sender;
  final String recipient;
  final String content;
  final String messageType;
  final MessageStatus status;
  final DateTime createdAt;

  MessageModel({
    this.id,
    required this.sender,
    required this.recipient,
    required this.content,
    this.messageType = 'text',
    this.status = MessageStatus.pending,
    required this.createdAt,
  });
  MessageModel copyWith({
    String? id,
    String? sender,
    String? recipient,
    String? content,
    String? messageType,
    MessageStatus? status,
    DateTime? createdAt,
  }) {
    return MessageModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      recipient: recipient ?? this.recipient,
      content: content ?? this.content,
      messageType: messageType ?? this.messageType,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'],
      sender: json['sender'],
      recipient: json['recipient'],
      content: json['content'],
      messageType: json['messageType'] ?? 'text',
      status: MessageStatus.values.firstWhere(
            (e) => e.name == (json['status'] ?? 'sent'),
        orElse: () => MessageStatus.sent,
      ),
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt']).toLocal()
          : DateTime.now(),
    );
  }
// Trong MessageModel
  Map<String, dynamic> toJsonForSocket() {
    return {
      '_id': id,
      'sender': sender,
      'recipient': recipient,
      'content': content,
      'messageType': messageType,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  Map<String, dynamic> toJson() {
    return {
      'recipientId': recipient,
      'content': content,
      'messageType': messageType,
    };
  }
}