import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'module/di_root.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    registry.get<FirebaseCrashlytics>().recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    registry.get<FirebaseCrashlytics>().recordError(error, stack, fatal: true);
    return true;
  };
  configureDependencies();
  unawaited(
    registry.get<FirebaseCrashlytics>().setCrashlyticsCollectionEnabled(
      kReleaseMode,
    ),
  );
  unawaited(
    registry.get<FirebaseAnalytics>().setAnalyticsCollectionEnabled(
      kReleaseMode,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mini Chat',
      routerConfig: registry.get<AppRouter>().config(
        navigatorObservers: () => [
          FirebaseAnalyticsObserver(
            analytics: registry.get<FirebaseAnalytics>(),
            routeFilter: (route) =>
                route is PageRoute ||
                route is DialogRoute ||
                route is PopupRoute ||
                route is ModalBottomSheetRoute,
          ),
        ],
        reevaluateListenable: registry.get<AppRouter>().reevaluateListener,
      ),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
