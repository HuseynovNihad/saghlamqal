class Endpoints {
  Endpoints._();

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
