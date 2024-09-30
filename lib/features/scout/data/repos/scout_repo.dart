import 'package:dartz/dartz.dart';
import 'package:talent_hub/core/failure/failure.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/models/user_model.dart';

abstract class ScoutRepo {
  Future<Either<Failure, UserModel>> fetchScout();
  Future<Either<Failure, List<PostModel>>> fetchPosts();
  Future<Either<Failure, bool>> setLike({required String postId});
}
