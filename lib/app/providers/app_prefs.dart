import 'dart:convert';
import 'package:bukara/app/providers/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPref {
  static SharedPreferences? prefs;
  static const String mobilTokenKey = "token";
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
