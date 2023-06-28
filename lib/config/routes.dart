import '../view/auth/register/register_page.dart';
import 'package:flutter/cupertino.dart';

import '../view/auth/login/login_page.dart';
import '../view/home_screen/home_screen.dart';
import '../view/splash_screen/splash_screen.dart';

class AppRoute {
  static const String splash = "/";
  static const String home = "/home";
  static const String login = "/login";
  static const String register = "/register";

  static dynamic generateRoute() => {
        AppRoute.login: (context) => LoginScreen(),
        AppRoute.home: (context) => const HomeScreen(),
        AppRoute.splash: (context) => const SplashScreen(),
        AppRoute.register: (context) => RegisterPage(),
      };

  static Route? onGenerateRoute(RouteSettings settings) {
    final List<String> pathElements = settings.name!.split('/');

    if (pathElements[0] != '' || pathElements.length == 1) return null;
    switch (pathElements[1]) {
      default:
        return null;
    }
  }
}
