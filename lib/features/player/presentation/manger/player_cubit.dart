import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talent_hub/features/player/presentation/manger/player_state.dart';
import 'package:talent_hub/features/player/presentation/model/player_model.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(GetInfoPlayerInitialState());

  static PlayerCubit get(context) => BlocProvider.of(context);

  late PlayerModel playerModel;

  void getUserData() {
    emit(GetInfoPlayerLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(playerModel.uId)
        .get()
        .then((value) {
      playerModel = PlayerModel.fromMap(value.data() as Map<String, dynamic>);
      emit(GetInfoPlayerSuccessState());
    }).catchError((error) {
      emit(GetInfoPlayerErrorState(error.toString()));
    });
  }

  Future<void> selectUploadAndSaveImage(String playerId) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? imageFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (imageFile == null) {
        return;
      }

      File file = File(imageFile.path);

      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef =
          FirebaseStorage.instance.ref().child('player_images/$fileName');

      UploadTask uploadTask = storageRef.putFile(file);
      TaskSnapshot storageSnapshot = await uploadTask;

      String downloadUrl = await storageSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(playerId)
          .update({
        'image': downloadUrl,
      });

      print('Image uploaded and URL saved successfully!');
    } catch (e) {
      print(
          'Error during image upload or saving to Firestore: ${e.toString()}');
    }
  }
}
