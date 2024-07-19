part of 'signup_cubit.dart';

@immutable
sealed class SignupCubitState {}

final class SignupCubitInitial extends SignupCubitState {}

final class SignupCubitloading extends SignupCubitState {}

final class SignupCubitfailure extends SignupCubitState {
  final String error;

  SignupCubitfailure({required this.error});
}

final class SignupCubitsucsess extends SignupCubitState {}
