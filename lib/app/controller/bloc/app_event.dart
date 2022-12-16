import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class AppEvent {
  const AppEvent();
}

class LOGINEVENT implements AppEvent {
  final String? username;
  final String? password;

  LOGINEVENT({this.username, this.password});
}

class SIGNUP implements AppEvent {
  final String? username;
  final String? password;
  final String? confirmPass;

  SIGNUP({this.username, this.password, this.confirmPass});
}
