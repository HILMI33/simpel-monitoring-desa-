import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'api_service.dart';

class NotificationService extends GetxService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  Future<NotificationService> init() async {
    // Request permission
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    }

    // Initialize local notifications (mostly for Android/iOS)
    if (!GetPlatform.isWeb) {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');
      const InitializationSettings initSettings =
          InitializationSettings(android: androidSettings);

      try {
        await _localNotifications.initialize(settings: initSettings);
        
        // Create the channel on the device (if a channel with an id already exists, it will be updated)
        const AndroidNotificationChannel channel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          description: 'This channel is used for important notifications.', // description
          importance: Importance.max,
        );

        await _localNotifications
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
            
      } catch (e) {
        print('Local Notifications Initialization Error: $e');
      }
    }

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground messages
    if (!GetPlatform.isWeb) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          (_localNotifications as dynamic).show(
            notification.hashCode,
            notification.title,
            notification.body,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel',
                'High Importance Notifications',
                importance: Importance.max,
                priority: Priority.high,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      });
    }

    // Get token
    String? token = await _fcm.getToken();
    print("FCM Token: $token");

    if (token != null) {
      _sendTokenToBackend(token);
    }

    // Listen to token refresh
    _fcm.onTokenRefresh.listen((newToken) {
      print("FCM Token Refreshed: $newToken");
      _sendTokenToBackend(newToken);
    });

    return this;
  }

  void _sendTokenToBackend(String token) {
    try {
      final api = Get.find<ApiService>();
      // We only send token if ApiService already has the token (logged in)
      if (api.storage.read('token') != null) {
        api.post('/auth/fcm-token', {'fcm_token': token});
      }
    } catch (e) {
      print("Failed to send FCM token to backend: $e");
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}
