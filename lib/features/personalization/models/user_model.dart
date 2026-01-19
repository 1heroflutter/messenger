import '../../../utils/constants/enums.dart';
class UserModel {
  final String id;
  final String uid;
  final String phoneNumber;
  final String displayName;
  final String avatar;
  final bool pinEnabled;
  final bool isOnline;
  final DateTime? lastSeen;
  final List<String> friends;
  final FriendRelationship relationship;
  final String fcmToken;
  UserModel({
    required this.id,
    required this.uid,
    required this.phoneNumber,
    this.displayName = "",
    this.avatar = "",
    this.pinEnabled = false,
    this.isOnline = false, // Mặc định là offline
    this.lastSeen,
    this.friends = const [],
    this.relationship = FriendRelationship.none,
    this.fcmToken = ""
  });

  static UserModel empty() => UserModel(id: "", uid: "", phoneNumber: "");

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      uid: json['uid'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      displayName: json['displayName'] ?? '',
      avatar: json['avatar'] ?? '',
      pinEnabled: json['pinEnabled'] ?? false,
      isOnline: json['isOnline'] ?? false,
      lastSeen: json['lastSeen'] != null ? DateTime.parse(json['lastSeen']) : null,
      friends: json['friends'] != null
          ? List<String>.from(json['friends'].map((x) => x is Map ? x['_id'] : x))
          : [],
      relationship: _parseRelationship(json['relationship']),
      fcmToken: json['fcmToken'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'uid': uid,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'avatar': avatar,
      'pinEnabled': pinEnabled,
      'isOnline': isOnline,
      'lastSeen': lastSeen?.toIso8601String(),
      'friends': friends,
      'relationship': relationship.name,
      'fcmToken' : fcmToken,
    };
  }

  UserModel copyWith({
    String? displayName,
    String? avatar,
    bool? pinEnabled,
    bool? isOnline, // <--- Thêm vào copyWith
    DateTime? lastSeen,
    FriendRelationship? relationship,
    String? fcmToken,
  }) {
    return UserModel(
      id: id,
      uid: uid,
      phoneNumber: phoneNumber,
      displayName: displayName ?? this.displayName,
      avatar: avatar ?? this.avatar,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      friends: friends,
      relationship: relationship ?? this.relationship,
      fcmToken: fcmToken ?? this.fcmToken
    );
  }

  static FriendRelationship _parseRelationship(String? status) {
    switch (status) {
      case 'pending': return FriendRelationship.pending;
      case 'friend': return FriendRelationship.friend;
      default: return FriendRelationship.none;
    }
  }
}