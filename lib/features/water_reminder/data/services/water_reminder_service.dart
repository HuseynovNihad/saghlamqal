import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/localization/locale_repository.dart';

class WaterReminderService {
  static const String _channelId = 'water_reminder_channel';

  static const String _keyEnabled = 'water_reminder_enabled';

  static const int _baseNotificationId = 1000;

  static const List<int> _scheduledHours = [7, 9, 11, 13, 15, 17, 19, 21];

  static const Set<String> _supportedLanguages = {'az', 'en', 'ru', 'tr'};

  final FlutterLocalNotificationsPlugin _notifications;

  final SharedPreferences _prefs;

  final LocaleRepository _localeRepository;

  WaterReminderService({
    required FlutterLocalNotificationsPlugin notifications,
    required SharedPreferences prefs,
  }) : _notifications = notifications,
       _prefs = prefs,
       _localeRepository = LocaleRepository(prefs);

  Future<void> initialize() async {
    tz.initializeTimeZones();

    try {
      final TimezoneInfo timezoneInfo =
          await FlutterTimezone.getLocalTimezone();

      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } catch (_) {
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

    final enabled = await isEnabled();

    if (enabled) {
      final granted = await requestPermission();

      if (granted) {
        await _schedule();
      }
    }
  }

  Future<bool> isEnabled() async {
    final savedValue = _prefs.getBool(_keyEnabled);

    if (savedValue == null) {
      await _prefs.setBool(_keyEnabled, true);

      return true;
    }

    return savedValue;
  }

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
    } else {
      await _cancelAll();
    }
  }

  Future<void> rescheduleForCurrentLanguage() async {
    final enabled = await isEnabled();

    if (!enabled) {
      return;
    }

    await _schedule();
  }

  AppLocalizations _getLocalizations() {
    final savedLanguage = _localeRepository.getSavedLanguage();

    if (savedLanguage != null) {
      return lookupAppLocalizations(savedLanguage.locale);
    }

    final systemLanguageCode = PlatformDispatcher.instance.locale.languageCode
        .toLowerCase();

    final languageCode = _supportedLanguages.contains(systemLanguageCode)
        ? systemLanguageCode
        : 'az';

    return lookupAppLocalizations(Locale(languageCode));
  }

  String _getTitle(int hour, AppLocalizations l10n) {
    return switch (hour) {
      7 => l10n.waterReminderNotificationMorningStart,
      9 => l10n.waterReminderNotificationMorning,
      11 => l10n.waterReminderNotificationBeforeLunch,
      13 => l10n.waterReminderNotificationAfterLunch,
      15 => l10n.waterReminderNotificationEnergy,
      17 => l10n.waterReminderNotificationAfternoon,
      19 => l10n.waterReminderNotificationBeforeDinner,
      21 => l10n.waterReminderNotificationLastGlass,
      _ => l10n.waterReminderNotificationDefault,
    };
  }

  List<String> _getMessages(AppLocalizations l10n) {
    return [
      l10n.waterReminderMessageOne,
      l10n.waterReminderMessageTwo,
      l10n.waterReminderMessageThree,
      l10n.waterReminderMessageFour,
      l10n.waterReminderMessageFive,
      l10n.waterReminderMessageSix,
      l10n.waterReminderMessageSeven,
      l10n.waterReminderMessageEight,
    ];
  }

  Future<void> _schedule() async {
    await _cancelAll();

    final l10n = _getLocalizations();
    final messages = _getMessages(l10n);

    for (int i = 0; i < _scheduledHours.length; i++) {
      final hour = _scheduledHours[i];

      await _scheduleDailyReminder(
        id: _baseNotificationId + i,
        hour: hour,
        title: _getTitle(hour, l10n),
        body: messages[i % messages.length],
        channelName: l10n.waterReminderChannelName,
        channelDescription: l10n.waterReminderChannelDescription,
      );
    }
  }

  Future<void> _scheduleDailyReminder({
    required int id,
    required int hour,
    required String title,
    required String body,
    required String channelName,
    required String channelDescription,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );

    if (!scheduledDate.isAfter(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    try {
      await _notifications.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: scheduledDate,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            channelName,
            channelDescription: channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    } catch (_) {
      // Bir bildiriş planlanmasa belə,
      // tətbiqin işləməsini dayandırmırıq.
    }
  }

  Future<void> _cancelAll() async {
    for (int i = 0; i < _scheduledHours.length; i++) {
      await _notifications.cancel(id: _baseNotificationId + i);
    }
  }
}
