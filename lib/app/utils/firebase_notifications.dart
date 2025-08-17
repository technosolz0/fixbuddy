import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'local_notifications.dart';

class FirebaseNotifications {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Set up listeners
  void notificationListeners() {
    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('--> Foreground message: ${message.notification?.title}');
      _handleMessage(message);
    });

    // App opened from background by tapping a notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('--> App opened from notification: ${message.notification?.title}');
      // You can navigate here or handle logic on notification tap
    });
  }

  // Handle incoming message and show local notification
  void _handleMessage(RemoteMessage message) {
    if (message.notification != null) {
      LocalNotifications.showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: message.notification!.title ?? 'Notification',
        body: message.notification!.body ?? '',
      );
    }
  }

  // Get current FCM token
  static Future<String?> getFirebaseToken() async {
    return await _messaging.getToken();
  }

  // Get APNs token (iOS only)
  static Future<String?> getAPNSToken() async {
    if (Platform.isIOS) {
      return await _messaging.getAPNSToken();
    }
    return null;
  }

  // Get the initial message when the app is launched from terminated state
  static Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('--> App launched from terminated notification: ${initialMessage.notification?.title}');
      // Handle or navigate on app launch from notification tap here
    }
  }
   Future<void> notificationRemover() async {
    // Directory directory = Platform.isAndroid
        // ? await getApplicationDocumentsDirectory()
        // : await getApplicationSupportDirectory();
    // File file = File('${directory.path}/notification.txt');
    // File countFile = File('${directory.path}/Count.txt');
    // if (await file.exists()) {
    //   await file.delete();
    // }
    // if (await countFile.exists()) {
    //   await countFile.delete();
    // }
  }
}
