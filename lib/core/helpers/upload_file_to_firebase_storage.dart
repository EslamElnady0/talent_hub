import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../DI/dependency_injection.dart';

Future<String> uploadFileToFirebaseStorage({
  required String path,
  required File file,
}) async {
  UploadTask? uploadTask;

  uploadTask = getIt.get<FirebaseStorage>().ref().child(path).putFile(file);

  TaskSnapshot snapshot = await uploadTask;
  String imageUrl = await snapshot.ref.getDownloadURL();
  return imageUrl;
}
