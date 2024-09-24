// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:talent_hub/core/failure/failure.dart';
import 'package:talent_hub/features/auth/data/models/user_model.dart';
import 'package:talent_hub/features/auth/data/repo/user_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  UserRepo userRepo;
  AuthRepoImpl(this.userRepo);

  @override
  Future<Either<Failure, bool>> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return const Right(true);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure(e.message!));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signUp(
    String email,
    String password,
    String name,
    String phone,
    String age,
    String position,
  ) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userRepo.addUserToFirestore(UserModel(
        id: user.user!.uid,
        name: name,
        phone: phone,
        age: age,
        email: email,
        position: position,
      ));
      return const Right(true);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure(e.message!));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(true);
    } catch (e) {
      if (e is FirebaseException) {
        return Left(FirebaseFailure(e.message!));
      }
      return Left(FirebaseFailure(e.toString()));
    }
  }
}

abstract class AuthRepo {
  Future<Either<Failure, bool>> login(String email, String password);
  Future<Either<Failure, bool>> signUp(
    String email,
    String password,
    String name,
    String phone,
    String age,
    String position,
  );
  Future<Either<Failure, bool>> signOut();
}
