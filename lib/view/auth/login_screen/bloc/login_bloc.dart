import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/api/base_response.dart';
import '../../../../data/repository/local/local_data_access.dart';
import '../../../../data/repository/remote/repository.dart';
import '../../../../di/network_injection.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final OpenIDRepository openIDRepository;
  LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();

  LoginBloc({required this.userRepository, required this.openIDRepository})
      : super(LoginInitial()) {
    on<LoginInitEvent>(_onInitial);

    on<LoginRequestEvent>(_onLoginRequest);

    on<LoginBySSORequestEvent>(_onLoginBySSORequest);

    on<LoginRememberEvent>(_onLoginRememberEvent);

    on<LoginRefreshEvent>(_onRefresh);

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
        username: accountRemember ? username : '',
        password: accountRemember ? password : '',
        accountRemember: accountRemember));
    emit(LoginRememberState(accountRemember));
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

      if (response.status == ResponseStatus.success && response.data != null) {
        emit(LoginSuccessState());
        localDataAccess.setAccessToken(response.data!.idToken);
        localDataAccess.setUsername(event.username.toString());
        localDataAccess.setPassword(event.password.toString());
        localDataAccess.setAccountRemember(event.rememberMe);

        // await NotificationHelper.instance
        //     .initSignalrConnection(response.data!.idToken);
      } else if (response.status == ResponseStatus.error) {
        emit(LoginFailedState(message: response.message));
      }
    }
  }

  FutureOr<void> _onLoginBySSORequest(
      LoginBySSORequestEvent event, Emitter<LoginState> emit) async {
    emit(LoginBySSOLoadingState());
    final response = await openIDRepository.loginBySSORequest();
    if (response.status == ResponseStatus.success) {
      // await NotificationHelper.instance
      //     .initSignalrConnection(response.data?.accessToken ?? '');
      // emit(LoginBySSOSuccessState());
      emit(LoginSuccessState());
    } else {
      emit(LoginBySSOErrorState(response.message ?? ''));
    }
  }

  FutureOr<void> _onLoginRememberEvent(
      LoginRememberEvent event, Emitter<LoginState> emit) {
    emit(LoginRememberState(event.rememberMe));
  }

  FutureOr<void> _onRefresh(
      LoginRefreshEvent event, Emitter<LoginState> emit) async {
    await openIDRepository.refreshToken();
  }
}
