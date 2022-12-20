import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/enterprise/repository.dart';
import 'package:bukara/app/providers/user/repository.dart';
import 'package:bukara/app/providers/user/user.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(INITIALSTATE()) {
    on<LOGINEVENT>(
      (event, emit) async {
        emit(const LOADING());
        try {
          var response =
              await loggin(username: event.username, password: event.password);
          UserResult user = UserResult.fromJson(response.data);
          Token token = user.token!;
          setMobileToken(token);
          emit(const SUCCESS(value: "Vous avez ete bien authentifie"));
        } on Exception catch (e) {
          emit(
            ERROR(
              dueTo: e.toString(),
            ),
          );
        }
      },
    );

    on<SIGNUP>((event, emit) async {
      try {
        emit(const LOADING());
        print(event.toString());
        await signup(
          username: event.username,
          password: event.password,
          confirmPass: event.confirmPass,
        );
        emit(const SUCCESS());
      } on Exception catch (e) {
        print(e.toString());
        emit(
          ERROR(
            dueTo: e.toString(),
          ),
        );
      }
    });

    on<ADDENTERPRISE>((event, emit) async {
      emit(const LOADING());
      try {
        await addEnterprise(data: event.enterprise!.toJson());
        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        emit(
          ERROR(dueTo: e.toString()),
        );
      }
    });

    on<GETENTERPRISE>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await getEnterprise();
        ResultEnterprise resultEnterprise =
            ResultEnterprise.fromJson(response.data);
        Enterprise enterprise = Enterprise();
        if (resultEnterprise.data != null) {
          enterprise = resultEnterprise.data!;
        }

        emit(
          SUCCESS(
            value: enterprise,
          ),
        );
      } on Exception catch (e) {
        emit(ERROR(
          dueTo: e.toString(),
        ));
      }
    });
  }
}
