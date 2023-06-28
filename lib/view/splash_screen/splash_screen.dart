import 'dart:async';

import '../../config/routes.dart';
import '../../data/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upgrader/upgrader.dart';

import '../base/bloc/auth/auth_bloc.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Upgrader upGrader = Upgrader(
      debugDisplayAlways: false,
      debugLogging: true,
      canDismissDialog: true,
      messages: UpgraderMessages(
          code:
              'Đã có phiên bản mới của True Connect. Vui lòng cập nhật để sử dụng các tính năng mới nhất.'),
    );

    return BlocProvider(
      create: (_) => AuthBloc()..add(AuthCheckCurrentSessionEvent()),
      child: UpgradeAlert(
        upgrader: upGrader,
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSessionValidState) {
              Timer(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.home, (route) => false);
              });
            } else if (state is AuthSessionInvalidState) {
              Future.delayed(const Duration(seconds: 1), () {
                // if app is not opened by appLinking
                // if (appLinkUsernameReceived.isEmpty) {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.login, (route) => false);
                // }
              });
            } else {}
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(Assets.imSplash),
                ),
              ),
            ),
          ),
        ),
      ),
    );
// backgroundColor: bgColor,
  }
}
