import 'package:base_project/config/config.dart';
import 'package:base_project/view/auth/login_screen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'di/network_injection.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureInjection();
  GestureBinding.instance.resamplingEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi')],
      title: AppConfig.appName,
      themeMode: ThemeMode.light,
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          backgroundColor: Colors.white,
          primarySwatch: AppConfig.primarySwatch,
          canvasColor: Colors.grey,
          fontFamily: AppConfig.fontFamily,
          primaryColor: AppConfig.primaryColor),
      debugShowCheckedModeBanner: true,
      home: const LoginScreen(),
    );
  }
}
