import 'package:base_project/view/auth/login_screen/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/resources/colors.dart';
import 'di/network_injection.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi')],
      title: 'Fitolabs DMS',
      themeMode: ThemeMode.light,
      theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          backgroundColor: Colors.white,
          primarySwatch: Colors.teal,
          canvasColor: Colors.grey,
          fontFamily: "Lato",
          primaryColor: AppColor.primaryColor),
      debugShowCheckedModeBanner: true,
      home: const LoginScreen(),
    );
  }
}
