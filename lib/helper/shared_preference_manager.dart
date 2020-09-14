import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKeys {
  SharedPrefKeys._();
  static const String languageCode = 'languageCode';
  static const String loggedIn = 'loggedIn';
}

class SharedPreferencesManager {
  static SharedPreferencesManager _instance;
  static SharedPreferences _preferences;

  SharedPreferencesManager._internal();

  static Future<SharedPreferencesManager> get instance async {
    if (_instance == null) {
      _instance = SharedPreferencesManager._internal();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }

  Future<void> setLanguage(String langCode) async =>
      await _preferences.setString(SharedPrefKeys.languageCode, langCode);

  String get languageCode =>
      _preferences.getString(SharedPrefKeys.languageCode);

  Future<void> setLoginStatus(String loginIn) async =>
      await _preferences.setString(SharedPrefKeys.loggedIn, loginIn);

  String get getLoginStatus => _preferences.getString(SharedPrefKeys.loggedIn);
}
