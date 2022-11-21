import 'dart:async';

import 'package:base_project/view/auth/forgot_password/otp_screen/bloc/count_down_bloc/ticker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'count_down_event.dart';
part 'count_down_state.dart';

class CountDownBloc extends Bloc<CountDownEvent, CountDownState> {
  static const int _duration = 120;
  final Ticker ticker;
  StreamSubscription<int>? _tickerSubscription;
  CountDownBloc({required this.ticker})
      : super(const CountDownStateInit(_duration)) {
    on<CountDownEventStart>(_onStarted);
    on<CountDownEventTick>(_onTicked);
    on<CountDownEventInit>(_init);
    on<CountDownEventExpired>(_expired);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  FutureOr<void> _onStarted(
      CountDownEventStart event, Emitter<CountDownState> emit) {
    emit(CountDownStateRun(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(CountDownEventTick(duration: duration)));
  }

  FutureOr<void> _onTicked(
      CountDownEventTick event, Emitter<CountDownState> emit) {
    emit(
      event.duration > 0
          ? CountDownStateRun(event.duration)
          : const CountDownStateComplete(),
    );
  }

  FutureOr<void> _init(CountDownEventInit event, Emitter<CountDownState> emit) {
    emit(const CountDownStateInit(_duration));
  }

  FutureOr<void> _expired(
      CountDownEventExpired event, Emitter<CountDownState> emit) {
    emit(const CountDownStateExpired());
  }
}
