import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_text_state.dart';

class SendTextCubit extends Cubit<SendTextState> {
  SendTextCubit() : super(SendTextInitial());
}
