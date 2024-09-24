import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/presentation/manger/signup_cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupStates> {
  SignupCubit(this._authRepo) : super(SignupIntialState());
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var positionController = TextEditingController();

  final AuthRepo _authRepo;

  void signup() async {
    emit(SignupLoadingState());
    var result = await _authRepo.signUp(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text,
      ageController.text,
      positionController.text,
    );
    result.fold((failure) {
      emit(SignupErrorState(failure.message));
    }, (success) {
      emit(SignupSuccessState());
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    positionController.dispose();
    return super.close();
  }
}
