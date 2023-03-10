import 'package:bukara/app/controller/bloc/app_bloc.dart';
import 'package:bukara/app/controller/bloc/app_state.dart';
import 'package:bukara/app/ui/shared/status_widgets.dart';
import 'package:bukara/app/ui/shared/style.dart';
import 'package:bukara/app/ui/shared/utils/pop_pup.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustormScaffold extends StatefulWidget {
  final Widget? body;
  final dynamic onSuccess;
  const CustormScaffold({super.key, this.body, this.onSuccess});

  @override
  State<CustormScaffold> createState() => _CustormScaffoldState();
}

class _CustormScaffoldState extends State<CustormScaffold> {
  ValueNotifier<bool> isStart = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is SUCCESS) {
            widget.onSuccess();
          } else if (state is ERROR) {
            errorModel(context, dueTo: state.dueTo!.errors!);
          }
        },
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          return Stack(
            children: [
              // the body of the screen
              IgnorePointer(
                ignoring: state is LOADING,
                child: widget.body!,
              ),

              ValueListenableBuilder(
                  valueListenable: isStart,
                  builder: (context, bool isStartValue, childe) {
                    if (state is SUCCESS) {
                      return AnimatedPositioned(
                        right: isStartValue ? 20 : -350,
                        duration: const Duration(seconds: 1),
                        top: 20,
                        child: const AppInfo(
                          title: "Succès",
                          statusColor: AppColors.GREEN_COLOR,
                          subtitle: "Operation effectuée avec succès",
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),

              //while the event is loading
              if (state is LOADING)
                const Positioned(
                  right: 20,
                  bottom: 20,
                  child: LoandingInfo(),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class CustormScaffoldPage extends StatefulWidget {
  final Widget? content;
  final dynamic onSuccess;
  final Widget? header;
  const CustormScaffoldPage(
      {super.key, this.content, this.onSuccess, this.header});

  @override
  State<CustormScaffoldPage> createState() => _CustormScaffoldPageState();
}

class _CustormScaffoldPageState extends State<CustormScaffoldPage> {
  ValueNotifier<bool> isStart = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: widget.header,
      content: BlocListener<AppBloc, AppState>(
        listener: (context, state) {
          if (state is SUCCESS) {
            widget.onSuccess();
          } else if (state is ERROR) {
            errorModel(context, dueTo: state.dueTo!.errors!);
          }
        },
        child: BlocBuilder<AppBloc, AppState>(builder: (context, state) {
          debugPrint(state.toString());
          return Stack(
            children: [
              // the body of the screen
              IgnorePointer(
                ignoring: state is LOADING,
                child: widget.content!,
              ),

              //while the event is loading
              if (state is LOADING)
                const Positioned(
                  right: 20,
                  bottom: 20,
                  child: LoandingInfo(),
                ),
            ],
          );
        }),
      ),
    );
  }
}
