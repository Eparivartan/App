import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const String mobileKey = 'mobile';
  static const String useridkey = 'userid';

  static Future<void> setMobileNumber(String mobile) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(mobileKey, mobile);
  }

  static Future<String?> getMobileNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(mobileKey);
  }

   static Future<void> setUserId(String userid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(useridkey, userid);
  }

   static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(useridkey);
  }
}
