import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorage {
  static const _onboardingKey = 'onboarding_completed';

  final SharedPreferences prefs;

  OnboardingStorage(this.prefs);

  Future<void> markCompleted() async {
    await prefs.setBool(_onboardingKey, true);
  }

  bool isCompleted() {
    return prefs.getBool(_onboardingKey) ?? false;
  }
}
