abstract class Failure {
  String message;
  Failure(this.message);
}

class FirebaseFailure extends Failure {
  FirebaseFailure(super.message);
}
