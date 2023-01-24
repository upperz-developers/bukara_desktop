import 'package:bukara/shared/entry_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

/*
    BUKARA V1.0.0 alpha test
    Build by Devinno in partenership with Upperz
    Started on December 10 2022, 
    Ended on January 10 2023
 */

bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  if (kIsWeb ||
      [TargetPlatform.windows, TargetPlatform.android]
          .contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop && defaultTargetPlatform == TargetPlatform.windows) {
    await WindowManager.instance.ensureInitialized();

    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.normal,
        windowButtonVisibility: true,
      );

      await windowManager.setMinimumSize(
        const Size(1155, 900),
      );
      await windowManager.center();
      await windowManager.show();
      await windowManager.isMinimizable();
      await windowManager.setPreventClose(false);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const App());
}
