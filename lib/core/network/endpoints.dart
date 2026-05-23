class Endpoints {
  Endpoints._();

  // ─── Home ───────────────────────────────────────────────
  static const String getDailyGoal = 'home/daily-goal';
  static const String getHydration = 'home/hydration';
  static const String addWater = 'home/hydration/add';
  static const String getRecentProducts = 'home/recent-product';
  static const String getMealOfTheDay = 'home/meal-of-the-day';

  // ─── Favorites ────────────────────────────────────────────────
  static const String getFavorites = 'favorites';
  static const String addFavorite = 'favorites';
  static const String getCollections = 'favorites/collections';
  static const String createCollection = 'favorites/collections';

  static String removeFavorite(String id) => 'favorites/$id';
  static String updateCollection(String id) => 'favorites/collections/$id';
  static String deleteCollection(String id) => 'favorites/collections/$id';
  static String assignCollection(String id) => 'favorites/$id/collection';
}
