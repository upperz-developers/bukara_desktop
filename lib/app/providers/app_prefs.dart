import 'dart:convert';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static SharedPreferences? prefs;
  static const String mobilTokenKey = "token";
  static const String user = "user";
  static const String appConfig = "config";
  static const String enterprise = "enterprise";
}

Token getMobileToken() {
  var token = AppPref.prefs?.getString(AppPref.mobilTokenKey) ?? '';
  if (token.isEmpty) {
    return Token(token: "");
  } else {
    var json = jsonDecode(token);
    return Token.fromJson(json);
  }
}

void setMobileToken(Token token) {
  AppPref.prefs!.setString(
    AppPref.mobilTokenKey,
    jsonEncode(
      token.toJson(),
    ),
  );
}

User getUserPrefs() {
  var user = AppPref.prefs?.getString(AppPref.user) ?? '';
  if (user.isEmpty) {
    return User();
  } else {
    var json = jsonDecode(user);
    return User.fromJson(json);
  }
}

void setUserPrefs(User user) {
  AppPref.prefs!.setString(
    AppPref.user,
    jsonEncode(
      user.toJson(),
    ),
  );
}

Config getAppConfig() {
  var config = AppPref.prefs?.getString(AppPref.appConfig) ?? '';
  if (config.isEmpty) {
    return Config();
  } else {
    var json = jsonDecode(config);
    return Config.fromJson(json);
  }
}

void setAppConfig(Config config) {
  AppPref.prefs!.setString(
    AppPref.appConfig,
    jsonEncode(
      config.toJson(),
    ),
  );
}

Enterprise getEnterprisePrefs() {
  var enterprise = AppPref.prefs?.getString(AppPref.enterprise) ?? '';
  if (enterprise.isEmpty) {
    return Enterprise();
  } else {
    var json = jsonDecode(enterprise);
    return Enterprise.fromJson(json);
  }
}

void setEnterprisePrefs(Enterprise enterprise) {
  AppPref.prefs!.setString(
    AppPref.enterprise,
    jsonEncode(
      enterprise.toJson(),
    ),
  );
}
