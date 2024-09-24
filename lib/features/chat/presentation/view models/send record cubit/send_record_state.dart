part of 'send_record_cubit.dart';

@immutable
sealed class SendRecordState {}

final class SendRecordInitial extends SendRecordState {}

final class SendRecordLoading extends SendRecordState {}

final class SendRecordSuccess extends SendRecordState {}

final class SendRecordFailure extends SendRecordState {}
