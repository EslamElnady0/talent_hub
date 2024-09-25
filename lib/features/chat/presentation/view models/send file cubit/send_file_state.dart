part of 'send_file_cubit.dart';

@immutable
sealed class SendFileState {}

final class SendFileInitial extends SendFileState {}

final class SendFileLoading extends SendFileState {}

final class SendFileSuccess extends SendFileState {}

final class SendFilePicked extends SendFileState {}

final class SendFileChooseFileType extends SendFileState {}

final class SendFileFailure extends SendFileState {
  final String message;

  SendFileFailure({required this.message});
}
