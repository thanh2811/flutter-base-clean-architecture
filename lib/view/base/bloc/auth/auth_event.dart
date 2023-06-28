part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthInitEvent extends AuthEvent {}

class AuthCheckCurrentSessionEvent extends AuthEvent {}

class AuthRefreshEvent extends AuthEvent {}

class AuthRememberEvent extends AuthEvent {
  final bool rememberMe;

  const AuthRememberEvent(this.rememberMe);
}

class AuthCheckPolicyEvent extends AuthEvent {
  final bool isChecked;

  const AuthCheckPolicyEvent(this.isChecked);
}

class AuthShowPasswordEvent extends AuthEvent {
  final bool showPassword;

  const AuthShowPasswordEvent({required this.showPassword});
}

class AuthLoginRequestEvent extends AuthEvent {
  final String? username;
  final String? password;

  final bool rememberMe;

  const AuthLoginRequestEvent(
      {this.username = '', this.password = '', this.rememberMe = false});
}

class AuthLoginBySSORequestEvent extends AuthEvent {}
