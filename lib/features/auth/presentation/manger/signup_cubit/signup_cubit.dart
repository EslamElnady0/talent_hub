import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/core/helpers/upload_file_to_firebase_storage.dart';
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
  File? imageFile;

  final AuthRepo _authRepo;

  void pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      emit(SignupImagePickedState());
    }
  }

  Future<String?> uploadImage(File image) async {
    try {
      return await uploadFileToFirebaseStorage(
          path:
              'users/${DateTime.now().microsecondsSinceEpoch}/${path.basename(image.path)}',
          file: image);
    } catch (e) {
      emit(SignupErrorState(e.toString()));
      return null;
    }
  }

  void signup() async {
    emit(SignupLoadingState());
    String? imageUrl;
    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile!);
    } else {
      imageUrl = null;
    }
    var result = await _authRepo.signUp(
      emailController.text,
      passwordController.text,
      nameController.text,
      phoneController.text,
      ageController.text,
      positionController.text,
      imageUrl,
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
    imageFile = null;
    return super.close();
  }
}
