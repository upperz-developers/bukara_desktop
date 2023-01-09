import 'package:bukara/app/ui/views/app/paiement/paiement_per_recovery.dart';
import 'package:bukara/app/ui/views/auth/auth.dart';
import 'package:bukara/app/ui/views/app/home.dart';
import 'package:bukara/app/ui/views/app/paiement/detail_historic.dart';
import 'package:bukara/app/ui/views/app/suite/detail_suite.dart';
import 'package:bukara/app/ui/views/app/tenant/select_tenant_dialog.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  Auth.routeName: (context) => const Auth(),
  Home.routeName: (context) => const Home(),
  SuiteDetail.routeName: (context) => const SuiteDetail(),
  ShowTenantDialog.routeName: (context) => const ShowTenantDialog(),
  DetailHistoric.routeName: (context) => const DetailHistoric(),
  PeymentPerRecovery.routeName: (context) => const PeymentPerRecovery(),
};
