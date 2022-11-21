part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordStateInit extends ForgotPasswordState {}

class ForgotPasswordStateSuccess extends ForgotPasswordState {
  List<ForgotPasswordMethod> forgotPasswordMethod;
  ForgotPasswordStateSuccess({required this.forgotPasswordMethod});
}

class ForgotPasswordStateFail extends ForgotPasswordState {}
