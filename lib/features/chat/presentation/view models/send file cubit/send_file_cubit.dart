import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_file_state.dart';

class SendFileCubit extends Cubit<SendFileState> {
  SendFileCubit() : super(SendFileInitial());
}
