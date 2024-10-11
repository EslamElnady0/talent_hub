import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/models/user_model.dart';

Future<UserModel> getUserById(String id) async {
  var documentSnapshot =
      await getIt.get<FirebaseFirestore>().collection('users').doc(id).get();
  return UserModel.fromJson(documentSnapshot.data()!);
}
