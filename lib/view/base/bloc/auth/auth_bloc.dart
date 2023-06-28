import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/api/base_response.dart';
import '../../../../data/repository/local/local_data_access.dart';
import '../../../../data/repository/remote/repository.dart';
import '../../../../di/di.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository = getIt.get<UserRepository>();
  final OpenIDRepository openIDRepository = getIt.get<OpenIDRepository>();
  LocalDataAccess localDataAccess = getIt.get<LocalDataAccess>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckCurrentSessionEvent>(_onCheckCurrentSession);

    on<AuthInitEvent>(_onInitial);

    on<AuthLoginRequestEvent>(_onLoginRequest);

    on<AuthLoginBySSORequestEvent>(_onLoginBySSORequest);

    on<AuthRememberEvent>(_onAuthRememberEvent);

    on<AuthRefreshEvent>(_onRefresh);

    on<AuthCheckPolicyEvent>(_onCheckPolicy);

    on<AuthShowPasswordEvent>((event, emit) {
      emit(AuthShowPasswordState(showPassword: event.showPassword));
    });
  }

  FutureOr<void> _onCheckCurrentSession(
      AuthCheckCurrentSessionEvent event, Emitter<AuthState> emit) async {
    final accessToken = await localDataAccess.getAccessToken();
    log('accessToken: $accessToken');
    if (accessToken.isEmpty) {
      emit(AuthSessionInvalidState());
    } else {
      emit(AuthSessionValidState());
    }
  }

  FutureOr<void> _onInitial(
      AuthInitEvent event, Emitter<AuthState> emit) async {
    final String username = localDataAccess.getUserName();
    final String password = localDataAccess.getPassword();
    final bool accountRemember = localDataAccess.getAccountRemember();
    emit(AuthGetLocalInfoState(
        username: accountRemember ? username : '',
        password: accountRemember ? password : '',
        accountRemember: accountRemember));
    emit(AuthShowPasswordState(showPassword: false));
    emit(AuthRememberState(accountRemember));
    emit(AuthCheckPolicyState(false));
  }

  FutureOr<void> _onLoginRequest(
      AuthLoginRequestEvent event, Emitter<AuthState> emit) async {
    if (event.username == "" || event.password == "") {
      emit(AuthFieldRequiredState());
    } else {
      emit(AuthLoadingState());
      final response = await userRepository.loginRequest(
          username: event.username.toString(),
          password: event.password.toString(),
          rememberMe: event.rememberMe);

      if (response.status == ResponseStatus.success && response.data != null) {
        emit(AuthLoginSuccessState());
        localDataAccess.setAccessToken(response.data!.idToken);
        localDataAccess.setUsername(event.username.toString());
        localDataAccess.setPassword(event.password.toString());
        localDataAccess.setAccountRemember(event.rememberMe);

        // await NotificationHelper.instance
        //     .initSignalrConnection(response.data!.idToken);
      } else if (response.status == ResponseStatus.error) {
        emit(AuthLoginFailedState(message: response.message));
      }
    }
  }

  FutureOr<void> _onLoginBySSORequest(
      AuthLoginBySSORequestEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginBySSOLoadingState());
    final response = await openIDRepository.loginBySSORequest();
    if (response.status == ResponseStatus.success) {
      emit(AuthLoginSuccessState());
    } else {
      emit(AuthLoginBySSOErrorState(response.message ?? ''));
    }
  }

  FutureOr<void> _onAuthRememberEvent(
      AuthRememberEvent event, Emitter<AuthState> emit) {
    emit(AuthRememberState(event.rememberMe));
  }

  FutureOr<void> _onRefresh(
      AuthRefreshEvent event, Emitter<AuthState> emit) async {
    await openIDRepository.refreshToken();
  }

  FutureOr<void> _onCheckPolicy(
      AuthCheckPolicyEvent event, Emitter<AuthState> emit) {
    emit(AuthCheckPolicyState(event.isChecked));
  }
}
