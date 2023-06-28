part of 'user_cubit.dart';

abstract class UserState {
  const UserState();
}

class UserInitial extends UserState {}

class UserGetUserSuccessState extends UserState {
  final UserEntity userEntity;

  const UserGetUserSuccessState({required this.userEntity});
}

class UserGetUserFailedState extends UserState {}

class UserUpdateSuccessState extends UserState {
  final UserEntity userEntity;

  const UserUpdateSuccessState({required this.userEntity});
}

class UserUpdateFailedState extends UserState {}
