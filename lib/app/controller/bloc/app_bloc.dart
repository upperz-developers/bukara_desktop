import 'package:bloc/bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/enterprise/repository.dart';
import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/providers/suite/provider.dart';
import 'package:bukara/app/providers/tenant/provider.dart';
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

          ResultAuth resultAuth = ResultAuth.fromJson(response.data);
          Token token = resultAuth.token!;
          setMobileToken(token);
          setAppConfig(resultAuth.data!.config!);
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
        await signup(
          username: event.username,
          password: event.password,
          confirmPass: event.confirmPass,
        );
        emit(const SUCCESS());
      } on Exception catch (e) {
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
    on<ADDSUITE>((event, emit) async {
      emit(const LOADING());
      try {
        await addAppart(
          data: event.data,
          imagePaths: event.imagePaths,
        );
        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        emit(ERROR(
          dueTo: e.toString(),
        ));
      }
    });

    on<GETSUITE>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await getSuite();
        ResultSuite resultSuite = ResultSuite.fromJson(response.data);
        suites = resultSuite.data!.suites!;
        emit(const SUCCESS());
      } on Exception catch (e) {
        emit(ERROR(
          dueTo: e.toString(),
        ));
      }
    });

    on<ADDTENANT>((event, emit) async {
      emit(const LOADING());
      try {
        await addTenant(
          data: event.data,
        );
        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        emit(ERROR(
          dueTo: e.toString(),
        ));
      }
    });
  }
}
