part of 'login_cubit.dart';

class LoginState {}

final class LoginInitial extends LoginState {}

final class LoggedInState extends LoginState {}

final class LoginFailState extends LoginState {
  String error;
  LoginFailState(this.error);
}
