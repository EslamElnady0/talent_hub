import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_state.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(InitialUpdateProfileState());
  static ProfileCubit get(context) => BlocProvider.of(context);

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(UpdateProfileState());
    } else {
      emit(FailureUpdateProfileState());
    }
  }

  void uploadProfileImage({required UserModel userModel}) {
    emit(LoadingUpdateProfileState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserImage(
          image: value,
          userModel: userModel,
        );
      }).catchError((error) {
        emit(SuccessUpdateProfileState());
      });
    }).catchError((error) {
      emit(FailureUpdateProfileState());
    });
  }

  void updateUserImage({String? image, required UserModel userModel}) {
    emit(LoadingUpdateProfileState());
    UserModel usermodel = UserModel(
      email: userModel.email,
      name: userModel.name,
      phone: userModel.phone,
      id: userModel.id,
      imageUrl: image,
      age: userModel.age,
      position: userModel.position,
      role: userModel.role,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(usermodel.id)
        .update(usermodel.toJson())
        .then((value) {
      emit(SuccessUpdateProfileState());
    }).catchError((error) {
      emit(FailureUpdateProfileState());
    });
  }
}
