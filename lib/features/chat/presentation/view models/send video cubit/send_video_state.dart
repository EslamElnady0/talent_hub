part of 'send_video_cubit.dart';

@immutable
sealed class SendVideoState {}

final class SendVideoInitial extends SendVideoState {}

final class SendVideoLoading extends SendVideoState {}

final class SendVideoSuccess extends SendVideoState {}

final class SendVideoFailure extends SendVideoState {
  final String message;
  SendVideoFailure({required this.message});
}
