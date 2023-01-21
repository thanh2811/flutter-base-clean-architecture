import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../data/model/auth/forgot_password_method.dart';
import '../../../../../../data/repository/remote/repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final UserRepository userRepository;
  OtpBloc({required this.userRepository}) : super(OtpInitial()) {
    on<OtpEventInit>(_init);

    on<OtpEventSend>(_sendOtp);

    on<OtpEventExpired>(
      _toExpired,
    );

    on<OtpEventCheck>(
      _check,
    );
  }

  FutureOr<void> _sendOtp(OtpEventSend event, Emitter<OtpState> emit) async {
    if (state is OtpInitial) {
      final Response response = await userRepository.sendOTP(
          username: event.username,
          type: event.method.type!,
          value: event.method.value!);
      if (response.statusCode == 200) {
        emit(OtpStateSendSuccess());
      } else {
        emit(OtpStateSendFail());
      }
    }
  }

  FutureOr<void> _toExpired(OtpEventExpired event, Emitter<OtpState> emit) {
    emit(OtpInitial());
  }

  FutureOr<void> _check(OtpEventCheck event, Emitter<OtpState> emit) async {
    if (state is OtpStateSendSuccess) {
      final Response response = await userRepository.checkOTP(
          username: event.username, key: event.key);
      if (response.statusCode == 200) {
        emit(OtpStateCheckedSuccess(key: response.data));
      } else if (response.statusCode == 500) {
        emit(state);
      }
    }
  }

  FutureOr<void> _init(OtpEventInit event, Emitter<OtpState> emit) {
    emit(OtpInitial());
  }
}
