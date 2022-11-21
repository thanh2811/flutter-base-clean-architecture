part of 'login_bloc.dart';

abstract class LoginState {
  const LoginState();

  // @override
  // List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginGetLocalInfoState extends LoginState {
  final String username;
  final String password;

  LoginGetLocalInfoState({required this.username, required this.password});
}

class LoginLoadingState extends LoginState {}

class LoginFieldRequiredState extends LoginState {}

class LoginSuccessState extends LoginState {
  LoginResponse loginResponse;
  LoginSuccessState({required this.loginResponse});
}

class LoginFailedState extends LoginState {
  final String? message;

  LoginFailedState({this.message});
}

class LoginRememberState extends LoginState {
  bool remember;
  LoginRememberState(this.remember);
}

class LoginShowPasswordState extends LoginState {
  bool showPassword;
  LoginShowPasswordState({required this.showPassword});
}
