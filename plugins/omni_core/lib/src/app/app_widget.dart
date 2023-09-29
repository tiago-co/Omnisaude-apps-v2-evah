import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/handlers/life_cicle_event_handler.dart';
import 'package:omni_general/omni_general.dart';

class AppWidget extends StatelessWidget {
  final ThemeData theme;
  final String title;

  AppWidget({
    required this.theme,
    required this.title,
  });

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final PreferencesService service = PreferencesService();

  @override
  Widget build(BuildContext context) {
    final UserStore userStore = Modular.get();
    WidgetsBinding.instance.addObserver(
      LifecycleEventHandler(
        pausedCallBack: () => service.onPauseApp(),
        resumeCallBack: () => service.onResumeAppWithBiometrics(),
      ),
    );

    return TripleBuilder<UserStore, Exception, PreferencesModel>(
      store: userStore,
      builder: (_, triple) {
        Modular.setObservers([
          FirebaseAnalyticsObserver(analytics: analytics),
          Modular.get<MyNavigatorObserver>(),
        ]);
        final Color color = userStore.programColor ?? this.theme.primaryColor;
        final ThemeData theme = this.theme.copyWith(
              primaryColor: color,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: color,
                selectionColor: color.withOpacity(0.5),
                selectionHandleColor: color,
              ),
              colorScheme: ColorScheme(
                primary: color,
                primaryContainer: color.withOpacity(0.75),
                secondary: color,
                secondaryContainer: color.withOpacity(0.75),
                surface: color,
                background: Colors.white,
                error: Colors.red,
                onPrimary: color,
                onSecondary: color,
                onSurface: color,
                onBackground: Colors.white,
                onError: Colors.red,
                brightness: Brightness.light,
              ),
            );
        return MaterialApp.router(
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          debugShowCheckedModeBanner: false,
          supportedLocales: const [Locale('pt', 'BR')],
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          title: title,
          theme: theme,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
        );
      },
    );
  }
}

class MyNavigatorObserver extends NavigatorObserver {
  List<Route<dynamic>?> routeStack = List.empty(growable: true);

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.add(route);
    log('didPush: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    log('didPop: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    routeStack.removeLast();
    log('didRemove: ${routeStack.map((route) => route?.settings.name)}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    routeStack.removeLast();
    routeStack.add(newRoute);
    log('didReplace: ${routeStack.map((route) => route?.settings.name)}');
  }
}
