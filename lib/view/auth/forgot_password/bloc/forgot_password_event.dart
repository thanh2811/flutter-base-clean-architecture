part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class ForgotPasswordEventGetMethod extends ForgotPasswordEvent {
  String username;
  ForgotPasswordEventGetMethod({required this.username});
}
