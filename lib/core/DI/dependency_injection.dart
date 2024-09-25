import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/data/repo/user_repo.dart';
import 'package:talent_hub/features/chat/data/repo/get_messages_repo.dart';
import 'package:talent_hub/features/chat/data/repo/send_message_repo.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/get%20messages%20cubit/get_messages_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20record%20cubit/send_record_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20text%20cubit/send_text_cubit.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  getIt.registerSingleton<UserRepo>(
      UserRepoImpl(getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<UserRepo>()));
  getIt.registerLazySingleton<SendMessageRepo>(() => SendMessageRepo(
      auth: getIt.get<FirebaseAuth>(),
      firestore: getIt.get<FirebaseFirestore>(),
      storage: getIt.get<FirebaseStorage>()));
  getIt.registerLazySingleton<GetMessagesRepo>(() => GetMessagesRepo(
        auth: getIt.get<FirebaseAuth>(),
        firestore: getIt.get<FirebaseFirestore>(),
      ));

  /////////////////////// chat cubits /////////////////////
  getIt.registerFactory<SendFileCubit>(
      () => SendFileCubit(getIt.get<SendMessageRepo>()));
  getIt.registerFactory<SendRecordCubit>(
      () => SendRecordCubit(getIt.get<SendMessageRepo>()));
  getIt.registerFactory<SendTextCubit>(
      () => SendTextCubit(getIt.get<SendMessageRepo>()));
  getIt.registerFactory<GetMessagesCubit>(
      () => GetMessagesCubit(getIt.get<GetMessagesRepo>()));
}
