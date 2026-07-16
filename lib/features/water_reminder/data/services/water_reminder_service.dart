import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
      return await android.requestNotificationsPermission() ?? false;
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
    if (hour == 9) return '☀️ Səhər suunu içdin?';
    if (hour == 11) return '💧 Nahardan əvvəl su vaxtı!';
    if (hour == 13) return '🥗 Nahardan sonra su iç!';
    if (hour == 15) return '⚡ Enerji üçün su iç!';
    if (hour == 17) return '🌿 Günortadan sonra su vaxtı!';
    if (hour == 19) return '🍽️ Axşam yeməyindən əvvəl!';
    if (hour == 21) return '🌙 Günün son stəkanı!';
    return '💧 Su içmə vaxtıdır!';
  }

  List<String> messages = [
    'Bir stəkan su iç, özünü yaxşı hiss et! 🌊',
    'Susuzluq yorğunluq gətirir. Su vaxtıdır! 💪',
    'Sağlıqlı qalmaq üçün bir stəkan su! ✨',
    'Beynin 75% sudur. Onu qida ver! 🧠',
    'Bir nəfəs al və bir stəkan su iç! 🌿',
    'Günortadan sonra da su unutma! 💦',
    'Nahardan əvvəl bir stəkan su iç! 🥗',
    'Axşam yeməyindən əvvəl su içməyi unutma! 🍽️',
  ];

  Future<void> _schedule() async {
    await _cancelAll();

    final now = tz.TZDateTime.now(tz.local);
    int id = _baseNotificationId;
    int count = 0;

    const scheduledHours = [7, 9, 11, 13, 15, 17, 19, 21];

    for (int day = 0; day < 7 && count < _maxNotifications; day++) {
      final date = now.add(Duration(days: day));
      for (
        int i = 0;
        i < scheduledHours.length && count < _maxNotifications;
        i++
      ) {
        final time = tz.TZDateTime(
          tz.local,
          date.year,
          date.month,
          date.day,
          scheduledHours[i],
        );
        if (time.isBefore(now)) continue;

        await _notifications.zonedSchedule(
          id: id++,
          title: _getTitle(scheduledHours[i]),
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
        count++;
      }
    }
  }

  // TEST: Bu hissəni commentdən çıxar, _schedule() çağırışını comment et
  // Future<void> _scheduleTest() async {
  //   await _cancelAll();
  //   final now = tz.TZDateTime.now(tz.local);
  //   await _notifications.zonedSchedule(
  //     id: _baseNotificationId,
  //     title: _getTitle(now.hour),
  //     body: messages[0],
  //     scheduledDate: now.add(const Duration(minutes: 1)),
  //     notificationDetails: const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         _channelId,
  //         _channelName,
  //         channelDescription: _channelDesc,
  //         importance: Importance.high,
  //         priority: Priority.high,
  //       ),
  //       iOS: DarwinNotificationDetails(
  //         presentAlert: true,
  //         presentBadge: true,
  //         presentSound: true,
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //   );
  // }

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
