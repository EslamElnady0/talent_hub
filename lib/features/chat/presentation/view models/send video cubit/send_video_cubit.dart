import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_video_state.dart';

class SendVideoCubit extends Cubit<SendVideoState> {
  SendVideoCubit() : super(SendVideoInitial());
}
