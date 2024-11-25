import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenProvider with ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  /// Set tokens and notify listeners
  void setTokens(String accessToken, String refreshToken) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    // Save tokens to SharedPreferences
    await _saveTokensToStorage(accessToken, refreshToken);

    notifyListeners(); // Notify listeners when tokens are updated
  }

  /// Save tokens to SharedPreferences
  Future<void> _saveTokensToStorage(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }
}