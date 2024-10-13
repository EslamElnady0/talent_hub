import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/features/scout/data/repos/scout_repo_impl.dart';
import 'package:talent_hub/features/scout/presentation/manger/scout_cubit/scout_states.dart';

class ScoutCubit extends Cubit<ScoutStates> {
  ScoutCubit() : super(InitialScoutState());
  static ScoutCubit get(context) => BlocProvider.of(context);

  void getScout() async {
    emit(LoadingScoutState());
    var result = await ScoutRepoImpl().fetchScout();
    result.fold((failure) {
      emit(FailureScoutState(error: failure.message));
    }, (userModel) {
      emit(SuccessScoutState(userModel: userModel));
    });
  }
}
