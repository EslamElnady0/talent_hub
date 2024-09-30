import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talent_hub/core/failure/failure.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/scout/data/repos/scout_repo.dart';

class ScoutRepoImpl extends ScoutRepo {
  @override
  Future<Either<Failure, UserModel>> fetchScout() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return right(UserModel.fromJson(data.data()!));
    } catch (e) {
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostModel>>> fetchPosts() async {
    try {
      List<PostModel> posts = [];
      var data = await FirebaseFirestore.instance.collection('posts').get();

      for (var post in data.docs) {
        posts.add(PostModel.fromJson(post.data()));
      }
      return right(posts);
    } catch (e) {
      return left(FirebaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> setLike({required String postId}) async {
    try {
      bool isLike = false;
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "like": true,
      });

      var data = await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('likes')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      isLike = data.data()!["like"];
      return right(isLike);
    } catch (e) {
      return left(FirebaseFailure(e.toString()));
    }
  }
}
