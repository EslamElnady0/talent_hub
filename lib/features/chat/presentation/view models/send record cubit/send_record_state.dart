part of 'send_record_cubit.dart';

@immutable
sealed class SendRecordState {}

final class SendRecordInitial extends SendRecordState {}

final class SendRecordLoading extends SendRecordState {}

final class SendRecordSuccess extends SendRecordState {}

final class SendRecordRecording extends SendRecordState {}

final class SendRecordFailure extends SendRecordState {
  final String message;
  SendRecordFailure({required this.message});
}
