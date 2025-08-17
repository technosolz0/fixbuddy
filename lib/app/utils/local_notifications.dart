import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialization settings
  static final InitializationSettings initializationSettings =
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      );

  // Show simple notification
  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await _notificationsPlugin.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'servex_channel',
          'Servex Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }

  // Schedule a notification
  static Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'servex_channel',
          'Servex Notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
      androidScheduleMode:
          AndroidScheduleMode.exact, // Added required parameter
      matchDateTimeComponents: DateTimeComponents.time, // Optional — if needed
    );
  }

  // Get notification launch details
  static Future<void> getTerminatedTapLaunchDetails() async {
    final details = await _notificationsPlugin
        .getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      debugPrint(
        'App opened from notification tap: ${details.notificationResponse?.payload}',
      );
      // Handle navigation on tap if needed
    }
  }

  // Notification click/tap handler
  static Future<void> onSelectNotification(
    NotificationResponse response,
  ) async {
    debugPrint('Notification tapped with payload: ${response.payload}');
    // Navigate or handle tap event here
  }
}
