part of 'send_text_cubit.dart';

@immutable
sealed class SendTextState {}

final class SendTextInitial extends SendTextState {}

final class SendTextLoading extends SendTextState {}

final class SendTextSuccess extends SendTextState {}

final class SendTextFailure extends SendTextState {
  final String message;
  SendTextFailure({required this.message});
}
