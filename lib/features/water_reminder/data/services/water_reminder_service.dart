import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class WaterReminderService {
  static const String _channelId = 'water_reminder_channel';
  static const String _channelName = 'Su Xatırlatması';
  static const String _channelDesc = 'Gün ərzində su içməyi xatırladır';
  static const String _keyEnabled = 'water_reminder_enabled';
  static const int _baseNotificationId = 1000;
  static const int _maxNotifications = 56;

  final FlutterLocalNotificationsPlugin _notifications;
  final SharedPreferences _prefs;

  WaterReminderService({
    required FlutterLocalNotificationsPlugin notifications,
    required SharedPreferences prefs,
  }) : _notifications = notifications,
       _prefs = prefs;

  Future<void> initialize() async {
    tz.initializeTimeZones();

    try {
      final TimezoneInfo timezoneInfo =
          await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (e) {
      tz.setLocalLocation(tz.getLocation('Asia/Baku'));
    }

    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

    await _notifications.initialize(settings: settings);

    if (await isEnabled()) {
      await _schedule();
      // await _scheduleTest();
    }
  }

  Future<bool> isEnabled() async => _prefs.getBool(_keyEnabled) ?? false;

  Future<bool> requestPermission() async {
    final android = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final ios = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    if (android != null) {
      final notificationGranted =
          await android.requestNotificationsPermission() ?? false;
      await android.requestExactAlarmsPermission();
      return notificationGranted;
    }
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return false;
  }

  Future<void> setEnabled(bool value) async {
    await _prefs.setBool(_keyEnabled, value);
    if (value) {
      await _schedule();
      // await _scheduleTest();
    } else {
      await _cancelAll();
    }
  }

  String _getTitle(int hour) {
    if (hour == 7) return '🌅 Günə su ilə başla!';
    if (hour == 9) return '☀️ Səhər suyunu içdin?';
    if (hour == 11) return '💧 Nahardan əvvəl su vaxtı!';
    if (hour == 13) return '🥗 Nahardan sonra su iç!';
    if (hour == 15) return '⚡ Enerji üçün su iç!';
    if (hour == 17) return '🌿 Günortadan sonra su vaxtı!';
    if (hour == 19) return '🍽️ Axşam yeməyindən əvvəl!';
    if (hour == 21) return '🌙 Günün son stəkanı!';
    return '💧 Su içmə vaxtıdır!';
  }

  final List<String> messages = [
    'Bir stəkan su iç, özünü yaxşı hiss et! 🌊',
    'Susuzluq yorğunluq gətirir. Su vaxtıdır! 💪',
    'Sağlıqlı qalmaq üçün bir stəkan su! ✨',
    'Beynin 75% sudur. Onu qida ver! 🧠',
    'Bir nəfəs al və bir stəkan su iç! 🌿',
    'Günortadan sonra da su unutma! 💦',
    'Nahardan əvvəl bir stəkan su iç! 🥗',
    'Axşam yeməyindən əvvəl su içməyi unutma! 🍽️',
  ];

  static const List<int> _scheduledHours = [7, 9, 11, 13, 15, 17, 19, 21];

  Future<void> _schedule() async {
    await _cancelAll();

    final now = tz.TZDateTime.now(tz.local);
    int id = _baseNotificationId;
    int count = 0;

    for (int day = 0; day < 7 && count < _maxNotifications; day++) {
      final date = now.add(Duration(days: day));
      for (
        int i = 0;
        i < _scheduledHours.length && count < _maxNotifications;
        i++
      ) {
        final hour = _scheduledHours[i];
        final time = tz.TZDateTime(
          tz.local,
          date.year,
          date.month,
          date.day,
          hour,
        );
        if (time.isBefore(now)) continue;

        try {
          await _notifications.zonedSchedule(
            id: id,
            title: _getTitle(hour),
            body: messages[i % messages.length],
            scheduledDate: time,
            notificationDetails: const NotificationDetails(
              android: AndroidNotificationDetails(
                _channelId,
                _channelName,
                channelDescription: _channelDesc,
                importance: Importance.high,
                priority: Priority.high,
              ),
              iOS: DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
              ),
            ),
            androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          );
          id++;
          count++;
        } catch (e) {
          // Bir bildirişin planlaşdırılması uğursuz olsa belə,
          // qalanları planlaşdırmağa davam edirik (əvvəlki kodda
          // xəta bütün dövrü dayandırırdı).
          id++;
        }
      }
    }
  }

  Future<void> _cancelAll() async {
    for (
      int i = _baseNotificationId;
      i < _baseNotificationId + _maxNotifications;
      i++
    ) {
      await _notifications.cancel(id: i);
    }
  }
}
