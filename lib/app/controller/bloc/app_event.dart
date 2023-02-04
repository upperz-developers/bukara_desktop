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

class EDITENTERPRIS implements AppEvent {
  final Map<String, dynamic>? enterprise;
  final Map<String, dynamic>? address;
  final Map<String, dynamic>? bank;

  EDITENTERPRIS({this.enterprise, this.address, this.bank});
}

class EDITSUITE implements AppEvent {
  final Map<String, dynamic>? data;
  final List<Map<String, dynamic>>? editedImage;
  final String? appartId;
  final List<String>? imagePaths;
  final Map<String, dynamic>? address;

  EDITSUITE({
    this.data,
    this.editedImage,
    this.appartId,
    this.address,
    this.imagePaths,
  });
}

class ADDTENANT implements AppEvent {
  final Map<String, dynamic>? data;

  ADDTENANT({this.data});
}

class EDDITTENANT implements AppEvent {
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? phone;
  final String? tenantId;
  final String? phoneId;

  EDDITTENANT({
    this.data,
    this.phone,
    this.tenantId,
    this.phoneId,
  });
}

class GETTENANT implements AppEvent {}

class CONFIGRENT implements AppEvent {
  final Map<String, dynamic>? data;

  CONFIGRENT({this.data});
}

class CONFIGRENTDAILY implements AppEvent {
  final Map<String, dynamic>? data;

  CONFIGRENTDAILY({this.data});
}

class GETRECOVERYINFO implements AppEvent {}

class PAYERENT implements AppEvent {
  final Map<String, dynamic> data;

  PAYERENT({required this.data});
}

class GETPAYEMENT implements AppEvent {}

class GETPAYEMENTPERRECOVERY implements AppEvent {
  final String recoveryId;

  GETPAYEMENTPERRECOVERY({required this.recoveryId});
}

class BREACKCONTRAT implements AppEvent {
  final String? tenantId;
  final String? contratId;

  BREACKCONTRAT({this.tenantId, this.contratId});
}
