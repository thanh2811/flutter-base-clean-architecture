import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../data/constants.dart';
import '../../../../data/model/login/login_response.dart';
import '../../../../data/repository/user_repository.dart';
import '../../../../di/network_injection.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  SharedPreferences pref = getIt.get<SharedPreferences>();

  LoginBloc({required this.userRepository}) : super(LoginInitial()) {
    on<LoginInitEvent>(_onInitial);

    on<LoginRequestEvent>(_onLoginRequest);

    on<LoginRememberEvent>(
      (event, emit) => emit(LoginRememberState(event.rememberMe)),
    );

    on<LoginShowPasswordEvent>((event, emit) {
      emit(LoginShowPasswordState(showPassword: event.showPassword));
    });
  }

  FutureOr<void> _onInitial(
      LoginInitEvent event, Emitter<LoginState> emit) async {
    final String username = pref.getString(SharedPreferenceKey.username) ?? '';
    final String password = pref.getString(SharedPreferenceKey.password) ?? '';
    emit(LoginGetLocalInfoState(username: username, password: password));
  }

  FutureOr<void> _onLoginRequest(
      LoginRequestEvent event, Emitter<LoginState> emit) async {
    if (event.username == "" || event.password == "") {
      emit(LoginFieldRequiredState());
    } else {
      emit(LoginLoadingState());
      final response = await userRepository.loginRequest(
          username: event.username.toString(),
          password: event.password.toString(),
          rememberMe: event.rememberMe);
      if (response.statusCode == 200) {
        final LoginResponse loginResponse =
            LoginResponse.fromJson(response.data);
        emit(LoginSuccessState(loginResponse: loginResponse));
        pref.setString(
            SharedPreferenceKey.idToken, loginResponse.idToken.toString());
        pref.setString(SharedPreferenceKey.username, event.username.toString());
        pref.setString(SharedPreferenceKey.password, event.password.toString());
        pref.setBool(SharedPreferenceKey.rememberMe, event.rememberMe);
        // await NotificationHelper.instance
        //     .initSignalrConnection(loginResponse.idToken);
      } else if (response.statusCode == 404 || response.statusCode == 500) {
        emit(LoginFailedState(
            message:
                'Hệ thống đang xảy ra lỗi, mời bạn đăng nhập lại sau ít phút!'));
      } else {
        emit(LoginFailedState(
            message: 'Tài khoản hoặc mật khẩu không chính xác'));
      }
    }
  }
}
