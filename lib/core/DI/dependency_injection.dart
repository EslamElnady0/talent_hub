import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:talent_hub/features/auth/data/repo/auth_repo.dart';
import 'package:talent_hub/features/auth/data/repo/user_repo.dart';

GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  getIt.registerSingleton<FirebaseAuth>(FirebaseAuth.instance);
  getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
  getIt.registerSingleton<FirebaseStorage>(FirebaseStorage.instance);
  getIt.registerSingleton<UserRepo>(
      UserRepoImpl(getIt.get<FirebaseFirestore>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<UserRepo>()));
}
