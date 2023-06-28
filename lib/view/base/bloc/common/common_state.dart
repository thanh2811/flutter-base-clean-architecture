part of 'common_cubit.dart';

class CommonState extends Equatable {
  final bool isLoading;
  final bool isdismissible;

  const CommonState({
    required this.isLoading,
    this.isdismissible = true,
  });

  @override
  List<Object> get props => [isLoading, isdismissible];
}
