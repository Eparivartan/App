import 'package:flutter/foundation.dart';

class TokenProvider with ChangeNotifier {
  String _accessToken = '';
  String _refreshToken = '';

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;

  void setTokens(String accessToken, String refreshToken) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    notifyListeners(); // Notify listeners when tokens are updated
  }
}
