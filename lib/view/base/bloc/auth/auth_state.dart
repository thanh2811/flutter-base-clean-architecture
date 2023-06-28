part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();

// @override
// List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSessionValidState extends AuthState {}

class AuthSessionInvalidState extends AuthState {}

class AuthGetUsernameState extends AuthState {
  final String username;

  AuthGetUsernameState({required this.username});
}

class AuthGetLocalInfoState extends AuthState {
  final String username;
  final String password;
  final bool accountRemember;

  AuthGetLocalInfoState(
      {required this.username,
      required this.password,
      required this.accountRemember});
}

class AuthLoadingState extends AuthState {}

class AuthLoginBySSOLoadingState extends AuthState {}

class AuthLoginBySSOSuccessState extends AuthState {}

class AuthLoginBySSOErrorState extends AuthState {
  final String message;

  AuthLoginBySSOErrorState(this.message);
}

class AuthFieldRequiredState extends AuthState {}

class AuthLoginSuccessState extends AuthState {
  // AuthResponse loginResponse;
  AuthLoginSuccessState();
}

class AuthLoginFailedState extends AuthState {
  final String? message;

  AuthLoginFailedState({this.message});
}

class AuthRememberState extends AuthState {
  bool remember;
  AuthRememberState(this.remember);
}

class AuthCheckPolicyState extends AuthState {
  bool isChecked;
  AuthCheckPolicyState(this.isChecked);
}

class AuthShowPasswordState extends AuthState {
  bool showPassword;
  AuthShowPasswordState({required this.showPassword});
}
