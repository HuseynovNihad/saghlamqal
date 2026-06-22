import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const _tokenKey = 'auth_token';
  static const _refreshTokenKey = 'refresh_token';

  final SharedPreferences prefs;

  TokenStorage(this.prefs);

  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  String? getToken() {
    return prefs.getString(_tokenKey);
  }

  Future<void> clearToken() async {
    await prefs.remove(_tokenKey);
  }

  bool hasToken() {
    return prefs.containsKey(_tokenKey);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  String? getRefreshToken() {
    return prefs.getString(_refreshTokenKey);
  }

  Future<void> clearRefreshToken() async {
    await prefs.remove(_refreshTokenKey);
  }

  Future<void> clearAll() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
  }
}
