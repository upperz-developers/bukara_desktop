import 'package:bukara/app/providers/enterprise/enterprise.dart';
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
  @override
  String toString() {
    return "Username:$username, Password:$password, Confirm:$confirmPass";
  }
}

class ADDENTERPRISE implements AppEvent {
  final Enterprise? enterprise;

  ADDENTERPRISE({this.enterprise});
}

class GETENTERPRISE implements AppEvent {}

class GETSUITE implements AppEvent {}

class ADDSUITE implements AppEvent {
  final Map<String, dynamic>? data;
  final List<String>? imagePaths;

  ADDSUITE({this.data, this.imagePaths});
}

class ADDTENANT implements AppEvent {
  final Map<String, dynamic>? data;

  ADDTENANT({this.data});
}

class GETTENANT implements AppEvent {}
