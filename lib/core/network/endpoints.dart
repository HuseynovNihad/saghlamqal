class Endpoints {
  Endpoints._();

  // ─── Auth ───────────────────────────────────────────────

  static const String register = 'auth/register';

  static const String verifyOtp = 'auth/verify-otp';

  static const String resendOtp = 'auth/resend-otp';

  static const String login = 'auth/login';

  static const String googleLogin = 'auth/google';

  static const String refresh = 'auth/refresh';

  static const String logout = 'auth/logout';

  static const String forgotPassword = 'auth/forgot-password';

  static const String resetPassword = 'auth/reset-password';

  static const String restoreAccountRequest = 'auth/restore/request';

  static const String restoreAccountVerify = 'auth/restore/verify';

  // ─── Users ───────────────────────────────────────────────

  static const String getMe = 'users/me';

  static const String completeProfile = 'users/complete-profile';

  static const String updateProfile = 'users/profile';

  static const String uploadAvatar = 'users/me/avatar';

  static const String deleteAvatar = 'users/me/avatar';

  static const String changePassword = 'users/change-password';

  static const String deleteAccount = 'users/me';

  // ─── Patient Profile ─────────────────────────────────────

  static const String getPatientProfile = 'patient-profile/me';

  static const String updatePatientProfile = 'patient-profile/me';

  static const String addWeightLog = 'patient-profile/weight-logs';

  static const String getWeightLogs = 'patient-profile/weight-logs';

  static const String addActivityLog = 'patient-profile/activity-logs';

  static const String getActivityLogs = 'patient-profile/activity-logs';

  // ─── Dietitian ───────────────────────────────────────────

  static const String getMyDietitian = 'dietitian-patients/my-dietitian';

  // ─── Dietitian Invites ───────────────────────────────────

  static const String getDietitianInvites = 'dietitian-patients/my-invites';

  static String acceptDietitianInvite(String id) =>
      'dietitian-patients/$id/accept';

  static String rejectDietitianInvite(String id) =>
      'dietitian-patients/$id/reject';

  // ─── Patient Diet Plan ───────────────────────────────────

  static const String getActiveDietPlan = 'patient/diet-plan';

  static const String getDietPlanHistory = 'patient/diet-plan/history';

  static const String getDietPlanCheckIns = 'patient/diet-plan/check-ins';

  static const String updateDietPlanCheckIn = 'patient/diet-plan/check-ins';

  // ─── Nutrition ───────────────────────────────────────────

  static const String getNutrition = 'nutrition';

  // ─── Hydration ───────────────────────────────────────────

  static const String getHydration = 'hydration';

  static const String addWaterLog = 'hydration/log';

  // ─── Photo Scan ──────────────────────────────────────────

  static const String analyzeScan = 'photo-scan/analyze';

  static const String getScanHistory = 'photo-scan/history';

  static const String clearScanHistory = 'photo-scan/history';

  static const String getScanFavorites = 'photo-scan/favorites';

  static const String addScanFavorite = 'photo-scan/favorites';

  static String deleteScanHistory(String id) => 'photo-scan/history/$id';

  static String deleteScanFavorite(String id) => 'photo-scan/favorites/$id';

  // ─── Collections ─────────────────────────────────────────

  static const String getCollections = 'collections';

  static const String createCollection = 'collections';

  static const String getCollectionIcons = 'collections/icons/list';

  static String getCollection(String id) => 'collections/$id';

  static String deleteCollection(String id) => 'collections/$id';

  static String addCollectionItem(String id) => 'collections/$id/items';

  static String removeCollectionItem(String id, String itemId) =>
      'collections/$id/items/$itemId';

  // ─── Meal ────────────────────────────────────────────────

  static const String getMealOfTheDay = 'meal/today';

  static const String getAllMeals = 'meal';

  // ─── Terms ───────────────────────────────────────────────

  static const String termsOfService = 'terms/terms-of-service';

  static const String privacyPolicy = 'terms/privacy-policy';

  // ─── About Us ────────────────────────────────────────────

  static const String aboutUs = '/about';
}
