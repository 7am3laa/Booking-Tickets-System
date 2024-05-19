// ignore_for_file: file_names

import 'package:projectf/DataBase/user.dart';

abstract class UserState {}

class LoadingUserState extends UserState {}

class LoadedUserState extends UserState {
  final Users user;

  LoadedUserState(this.user);
}

class PasswordVisibilityState extends UserState {
  final bool ispassword;
  PasswordVisibilityState(this.ispassword);
}

class EmptyUserState extends UserState {}

class ErrorUserState extends UserState {
  final String errorMessage;
  ErrorUserState(this.errorMessage);
}
