import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'common_state.dart';

class CommonCubit extends Cubit<CommonState> {
  CommonCubit() : super(const CommonState(isLoading: false));

  showLoading({bool dismissible = true}) {
    emit(CommonState(isLoading: true, isdismissible: dismissible));
  }

  hideLoading() {
    emit(const CommonState(isLoading: false));
  }
}
