part of 'sign_up_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignedUpState extends SignUpState {

}

final class SignedUpfailedState extends SignUpState {}

final class AccountAlreadyExists extends SignUpState {}
