import 'dart:async';

import 'package:base_project/data/model/api/base_response.dart';
import 'package:base_project/data/repository/local/local_data_access.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/login/login_response.dart';
import '../../../../data/repository/remote/repository.dart';
import '../../../../di/network_injection.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();

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
    final String username = localDataAccess.getUserName();
    final String password = localDataAccess.getPassword();
    final bool accountRemember = localDataAccess.getAccountRemember();
    emit(LoginGetLocalInfoState(
        username: username,
        password: password,
        accountRemember: accountRemember));
    emit(LoginRememberState(accountRemember));
  }

  FutureOr<void> _onLoginRequest(
      LoginRequestEvent event, Emitter<LoginState> emit) async {
    if (event.username == "" || event.password == "") {
      emit(LoginFieldRequiredState());
    } else {
      emit(LoginLoadingState());
      final response = await userRepository.login(
          username: event.username.toString(),
          password: event.password.toString(),
          rememberMe: event.rememberMe);

      if (response.status == ResponseStatus.success && response.data != null) {
        emit(LoginSuccessState(loginResponse: response.data!));
        localDataAccess.setAccessToken(response.data!.idToken);
        localDataAccess.setUsername(event.username.toString());
        localDataAccess.setPassword(event.password.toString());
        localDataAccess.setAccountRemember(event.rememberMe);
      } else if (response.status == ResponseStatus.error) {
        emit(LoginFailedState(message: response.message));
      }
    }
  }
}
