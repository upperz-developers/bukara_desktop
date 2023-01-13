import 'package:bloc/bloc.dart';
import 'package:bukara/app/controller/bloc/app_event.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/controller/shared/shared.dart';
import 'package:bukara/app/providers/app_prefs.dart';
import 'package:bukara/app/providers/enterprise/enterprise.dart';
import 'package:bukara/app/providers/enterprise/repository.dart';
import 'package:bukara/app/providers/payement/model.dart';
import 'package:bukara/app/providers/payement/provider.dart';
import 'package:bukara/app/providers/recovery/model.dart';
import 'package:bukara/app/providers/recovery/provider.dart';
import 'package:bukara/app/providers/suite/model.dart';
import 'package:bukara/app/providers/suite/provider.dart';
import 'package:bukara/app/providers/tenant/model.dart';
import 'package:bukara/app/providers/tenant/provider.dart';
import 'package:bukara/app/providers/user/repository.dart';
import 'package:bukara/app/providers/user/user.dart';
import 'package:bukara/app/ui/view_controller/auth_view_controller.dart';

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
          setUserPrefs(resultAuth.data!.user!);
          emit(const SUCCESS(value: "Vous avez ete bien authentifie"));
        } on Exception catch (e) {
          hundleError(e: e, emit: emit);
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
        hundleError(e: e, emit: emit);
      }
    });

    on<ADDENTERPRISE>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await addEnterprise(data: event.enterprise!.toJson());
        ResultEnterprise resultEnterprise =
            ResultEnterprise.fromJson(response.data);
        AuthController().enterpriseData.value = resultEnterprise.data!;
        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });

    on<GETENTERPRISE>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await getEnterprise();
        ResultEnterprise resultEnterprise =
            ResultEnterprise.fromJson(response.data);
        if (resultEnterprise.data != null) {
          AuthController().enterpriseData.value = resultEnterprise.data!;
          setEnterprisePrefs(resultEnterprise.data!);
        }
        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
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
        hundleError(e: e, emit: emit);
      }
    });

    on<EDITSUITE>((event, emit) async {
      emit(const LOADING());
      try {
        await editAppart(
          data: event.data,
          imagePaths: event.imagePaths,
          appartId: event.appartId,
          address: event.address,
        );

        emit(
          const SUCCESS(),
        );
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
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
        hundleError(e: e, emit: emit);
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
        hundleError(e: e, emit: emit);
      }
    });
    on<GETTENANT>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await getTenant();
        TenantResult tenantResult = TenantResult.fromJson(response.data);
        List<TenantModel> tenants = tenantResult.data!.tenants!;
        emit(
          SUCCESS(
            value: tenants,
          ),
        );
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });

    on<CONFIGRENT>(
      (event, emit) async {
        emit(const LOADING());
        try {
          await rentalContrat(
            data: event.data,
          );
          emit(const SUCCESS());
        } on Exception catch (e) {
          hundleError(e: e, emit: emit);
        }
      },
    );

    on<GETRECOVERYINFO>((event, emit) async {
      emit(const LOADING());
      try {
        var response = await getRecoveryInfo();
        ResultRecovery recovery = ResultRecovery.fromJson(response.data);
        List<ContratData> contratData = recovery.data!.contratData!;
        emit(SUCCESS(value: contratData));
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });

    on<PAYERENT>((event, emit) async {
      emit(const LOADING());

      try {
        await payeRent(
          data: event.data,
        );
        emit(const SUCCESS());
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });
    on<GETPAYEMENT>((event, emit) async {
      emit(const LOADING());
      try {
        AppBloc().add(GETENTERPRISE());
        var response = await getPayement();
        ResultHistoricPaiements resultPayement =
            ResultHistoricPaiements.fromJson(response.data);
        List<PayementHistoric> payements = resultPayement.data!.payments!;
        emit(SUCCESS(value: payements));
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });

    on<GETPAYEMENTPERRECOVERY>((event, emit) async {
      emit(const LOADING());
      try {
        AppBloc().add(GETENTERPRISE());
        var response =
            await getPayementPerRecovery(recoveryId: event.recoveryId);

        ResultHistoricPaiements resultPayement =
            ResultHistoricPaiements.fromJson(response.data);
        List<PayementHistoric> payements = resultPayement.data!.payments!;

        emit(SUCCESS(value: payements));
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });

    on<EDDITTENANT>((event, emit) async {
      emit(const LOADING());
      try {
        await updateTenant(
          data: event.data,
          tenantId: event.tenantId,
          phone: event.phone,
        );
        emit(const SUCCESS());
      } on Exception catch (e) {
        hundleError(e: e, emit: emit);
      }
    });
  }
}
