import 'dart:async';

import 'package:base_project/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upgrader/upgrader.dart';

import '../../data/repository/local/local_data_access.dart';
import '../../di/network_injection.dart';
import 'bloc/authentication_bloc.dart';

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
      create: (_) =>
          AuthenticationBloc(localDataAccess: getIt.get<LocalDataAccess>())
            ..add(AuthenticationInitialEvent()),
      child: UpgradeAlert(
        upgrader: upGrader,
        child: BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationInitSuccessState) {
              Timer(const Duration(seconds: 1), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoute.home, (route) => false);
              });
            } else if (state is AuthenticationInitErrorState) {
              // (duration)
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
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: SvgPicture.asset('assets/icons/ic_logo_full.svg'),
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
