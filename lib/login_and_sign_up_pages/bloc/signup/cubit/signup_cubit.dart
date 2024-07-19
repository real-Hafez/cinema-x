import 'package:bloc/bloc.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'signup_cubit_state.dart';

class SignupCubit extends Cubit<SignupCubitState> {
  final AuthService _authService;

  SignupCubit(this._authService) : super(SignupCubitInitial());

  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    emit(SignupCubitloading());
    try {
      await _authService.signup(
        email: email,
        password: password,
        context: context,
      );
      emit(SignupCubitsucsess());
    } catch (e) {
      emit(SignupCubitfailure(error: e.toString()));
    }
  }
}
