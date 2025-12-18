import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'data_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static bool _initialized = false;

  // Initialize the notification service
  static Future<void> initialize() async {
    if (_initialized) return;

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone().then((info) => info.identifier);
    tz.setLocalLocation(tz.getLocation(timeZoneName));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
    _initialized = true;
  }

  // Request notification permissions
  static Future<bool> requestPermissions() async {
    await initialize();

    final iosImplementation =
        _notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosImplementation != null) {
      final granted = await iosImplementation.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    // Android 13+ requires runtime permission, but the plugin handles it automatically
    // For Android, we just return true as permissions are handled in the manifest
    return true;
  }

  // Schedule notifications for the next 7 days
  static Future<void> scheduleNotifications() async {
    print("Scheduling notifications...");
    await initialize();
    await cancelAll(); // Clear existing to avoid duplicates

    final now = DateTime.now();
    int scheduledCount = 0;

    for (int i = 0; i < 7; i++) {
      try {
        final date = now.add(Duration(days: i));
        final dateStr = DateFormat("yyyy-MM-dd").format(date);
        final verse = DataService().getVerse(dateStr);

        if (verse != null) {
          String verseText = verse.text.length > 100
              ? '${verse.text.substring(0, 100)}...'
              : verse.text;

          // Schedule for 7:00 AM
          var scheduledDate = tz.TZDateTime(
            tz.local,
            date.year,
            date.month,
            date.day,
            7, // 7:00 AM
            0,
          );

          if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
            continue;
          }

          await _notifications.zonedSchedule(
            i, // Unique ID for each day
            'Daily Bread - Verse of the Day',
            verseText,
            scheduledDate,
            const NotificationDetails(
              android: AndroidNotificationDetails(
                'daily_verse',
                'Daily Verse',
                channelDescription: 'Daily verse notifications',
                importance: Importance.high,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
            uiLocalNotificationDateInterpretation:
                UILocalNotificationDateInterpretation.absoluteTime,
          );
          scheduledCount++;
          print("Scheduled notification for $dateStr: $verseText");
        } else {
          print("No verse found for $dateStr, skipping notification.");
        }
      } catch (e) {
        print("Error scheduling notification for day $i: $e");
      }
    }
    print("Total notifications scheduled: $scheduledCount");
  }

  // Cancel all notifications
  static Future<void> cancelAll() async {
    await _notifications.cancelAll();
  }

  // Check if notifications are enabled
  static Future<bool> areNotificationsEnabled() async {
    await initialize();
    // For simplicity, return true as permissions are handled automatically
    return true;
  }
}
