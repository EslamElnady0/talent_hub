import 'package:dartz/dartz.dart';
import 'package:talent_hub/core/failure/failure.dart';
import 'package:talent_hub/features/profile/data/repos/profile_repo.dart';

class ProfileRepoImplRpo extends ProfileRepo {
  @override
  Future<Either<Failure, bool>> updateProfile() {
    throw UnimplementedError();
  }
}
