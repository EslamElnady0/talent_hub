import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_record_state.dart';

class SendRecordCubit extends Cubit<SendRecordState> {
  SendRecordCubit() : super(SendRecordInitial());
}
