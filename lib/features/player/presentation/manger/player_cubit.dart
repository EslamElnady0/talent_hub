import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/player/presentation/manger/player_state.dart';
import 'package:talent_hub/features/player/presentation/model/player_model.dart';

class PlayerCubit extends Cubit<PlayerState> {
  PlayerCubit() : super(GetInfoPlayerInitialState());

  static PlayerCubit get(context) => BlocProvider.of(context);

 late Player playerModel;

  void getUserData() {
    emit(GetInfoPlayerLoadingState());

    FirebaseFirestore.instance.collection('users').doc(playerModel.uId).get().then((value) {
      playerModel = Player.fromMap(value.data() as Map<String, dynamic>);
      emit(GetInfoPlayerSuccessState());
    }).catchError((error) {
      emit(GetInfoPlayerErrorState(error.toString()));
    });
  }
}