import 'config/config.dart';
import 'config/routes.dart';
import 'data/resources/resources.dart';
import 'shared/utils/view_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'di/di.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.fileName);
  await configureInjection();
  GestureBinding.instance.resamplingEnabled = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ViewUtils.unFocusView();
      },
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: AppRoute.splash,
        routes: AppRoute.generateRoute(),
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
          colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: AppColor.primaryColor,
              secondary: AppColor.secondaryColor,
              background: AppColor.primaryBackgroundColor),
          primarySwatch: AppConfig.primarySwatch,
          canvasColor: Colors.grey,
          fontFamily: AppConfig.fontFamily,
          primaryColor: AppConfig.primaryColor,
          textTheme: const TextTheme(bodyMedium: AppTextTheme.textPrimary),
        ),
      ),
    );
  }
}
