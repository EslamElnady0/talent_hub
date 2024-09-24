import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/presentation/manger/login_cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit(this._authRepo) : super(LoginIntialState());

  final AuthRepo _authRepo;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {
    emit(LoginLoadingState());
    var result =
        await _authRepo.login(emailController.text, passwordController.text);
    result.fold((failure) {
      emit(LoginErrorState(failure.message));
    }, (success) {
      emit(LoginSuccessState());
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
