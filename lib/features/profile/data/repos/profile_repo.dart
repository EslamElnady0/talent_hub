import 'package:dartz/dartz.dart';
import 'package:talent_hub/core/failure/failure.dart';

abstract class ProfileRepo {
  Future<Either<Failure, bool>> updateProfile();
}
