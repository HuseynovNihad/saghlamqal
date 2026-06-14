class Endpoints {
  Endpoints._();

  // ─── Auth ───────────────────────────────────────────────
  static const String register = 'auth/register';
  static const String verifyOtp = 'auth/verify-otp';
  static const String resendOtp = 'auth/resend-otp';
  static const String login = 'auth/login';
  static const String refresh = 'auth/refresh';
  static const String logout = 'auth/logout';
  static const String forgotPassword = 'auth/forgot-password';
  static const String resetPassword = 'auth/reset-password';

  // ─── Users ───────────────────────────────────────────────
  static const String getMe = 'users/me';
  static const String updateProfile = 'users/profile';
  static const String updatePhysical = 'users/physical';
  static const String changePassword = 'users/change-password';
  static const String deleteAccount = 'users/me';
  static const String restoreAccount = 'users/me/restore';

  // ─── Nutrition ───────────────────────────────────────────
  static const String getNutrition = 'nutrition';

  // ─── Hydration ───────────────────────────────────────────
  static const String getHydration = 'hydration';
  static const String addWaterLog = 'hydration/log';

  // ─── Photo Scan ───────────────────────────────────────────
  static const String analyzeScan = 'photo-scan/analyze';
  static const String getScanHistory = 'photo-scan/history';
  static const String clearScanHistory = 'photo-scan/history';
  static const String getScanFavorites = 'photo-scan/favorites';
  static const String addScanFavorite = 'photo-scan/favorites';
  static String deleteScanHistory(String id) => 'photo-scan/history/$id';
  static String deleteScanFavorite(String id) => 'photo-scan/favorites/$id';

  // ─── Collections ───────────────────────────────────────────
  static const String getCollections = 'collections';
  static const String createCollection = 'collections';
  static const String getCollectionIcons = 'collections/icons/list';
  static String getCollection(String id) => 'collections/$id';
  static String deleteCollection(String id) => 'collections/$id';
  static String addCollectionItem(String id) => 'collections/$id/items';
  static String removeCollectionItem(String id, String itemId) =>
      'collections/$id/items/$itemId';

  // ─── Meal ───────────────────────────────────────────────
  static const String getMealOfTheDay = 'meal/today';
  static const String getAllMeals = 'meal';

  // ─── Terms ───────────────────────────────────────────────
  static const String termsOfService = 'terms/terms-of-service';
  static const String privacyPolicy = 'terms/privacy-policy';
}
