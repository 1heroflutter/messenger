import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Định nghĩa Channel cho Android (Phải khớp với ID 'chat_messages_channel' ở Backend)
  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'chat_messages_channel',
    'Tin nhắn mới',
    description: 'Thông báo khi có tin nhắn chat mới',
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> init() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // Kiểm tra trạng thái quyền (Optional - dùng để debug)
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Người dùng đã cấp quyền thông báo');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('Người dùng cấp quyền tạm thời');
    } else {
      print('Người dùng từ chối cấp quyền');
    }

    // 2. Đặc biệt cho Android: Xin quyền hiện popup (Heads-up)
    if (Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission(); // Dòng này cực kỳ quan trọng cho Android 13+
    }
    // 1. Xin quyền thông báo
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    await _localNotifications
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    // 3. Cấu hình InitializationSettings
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings();

    await _localNotifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    // 4. Lắng nghe tin nhắn khi đang mở App (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    // 5. Lắng nghe khi nhấn vào thông báo từ Background
    FirebaseMessaging.onMessageOpenedApp.listen(_onNotificationTapFromMessage);

    // 6. Xử lý trường hợp App bị đóng hẳn (Terminated) và được mở lại từ notify
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _navigateToChat(initialMessage.data);
    }
  }

  static void _showLocalNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.max,
          priority: Priority.high,
          icon: '@drawable/splash_logo_light', // Đảm bảo icon này tồn tại
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  static void _onNotificationTap(NotificationResponse response) {
    if (response.payload != null) {
      final Map<String, dynamic> data = jsonDecode(response.payload!);
      _navigateToChat(data);
    }
  }

  static void _onNotificationTapFromMessage(RemoteMessage message) {
    _navigateToChat(message.data);
  }

  static void _navigateToChat(Map<String, dynamic> data) {
    final senderId = data['senderId'];
    if (senderId != null) {
      print("Điều hướng tới chat với: $senderId");
      // Ví dụ dùng GetX để điều hướng:
      // Get.to(() => ChatScreen(partnerId: senderId));
    }
  }
}