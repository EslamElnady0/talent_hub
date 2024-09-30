import 'package:talent_hub/core/models/user_model.dart';

abstract class ScoutStates {}

class InitialScoutState extends ScoutStates {}

class LoadingScoutState extends ScoutStates {}

class SuccessScoutState extends ScoutStates {
  final UserModel userModel;
  SuccessScoutState({required this.userModel});
}

class FailureScoutState extends ScoutStates {
  final String error;
  FailureScoutState({required this.error});
}
