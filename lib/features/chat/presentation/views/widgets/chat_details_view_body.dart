import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/chat/data/models/message_model.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/get%20messages%20cubit/get_messages_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20record%20cubit/send_record_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20text%20cubit/send_text_cubit.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/chat_details_chat_list_view.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/chat_send_record_or_text_button.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/picked_file_widget.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/recording_message_body.dart';
import 'package:uuid/uuid.dart';
import 'choose_file_type_body.dart';
import 'custom_chat_text_field.dart';

class ChatDetailsViewBody extends StatefulWidget {
  final UserModel user;
  const ChatDetailsViewBody({super.key, required this.user});

  @override
  State<ChatDetailsViewBody> createState() => _ChatDetailsViewBodyState();
}

class _ChatDetailsViewBodyState extends State<ChatDetailsViewBody> {
  late TextEditingController chatController;
  @override
  void initState() {
    chatController = TextEditingController();
    context.read<GetMessagesCubit>().scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    chatController.dispose();
    if (context.mounted) {
      context.read<GetMessagesCubit>().scrollController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          vGap(5),
          ChatDetailsChatListView(user: widget.user),
          vGap(5),
          BlocBuilder<SendFileCubit, SendFileState>(builder: (context, state) {
            if (state is SendFileChooseFileType) {
              return const ChooseFileTypeBody();
            } else if (state is SendFilePicked) {
              return PickedFileWidget(user: widget.user);
            }
            return BlocBuilder<SendRecordCubit, SendRecordState>(
              builder: (context, state) {
                if (state is SendRecordRecording) {
                  return RecordingMessageBody(
                    user: widget.user,
                  );
                }
                return Row(
                  children: [
                    Expanded(
                      child: CustomChatTextField(
                        controller: chatController,
                      ),
                    ),
                    hGap(5),
                    ChatSendRecordOrTextButton(
                        chatController: chatController,
                        onTap: () {
                          if (chatController.text.isEmpty) {
                            context.read<SendRecordCubit>().startRecording();
                          } else {
                            MessageModel textMessage = MessageModel(
                              senderId:
                                  getIt.get<FirebaseAuth>().currentUser!.uid,
                              receiverId: widget.user.id,
                              textMessageId: const Uuid().v1(),
                              message: chatController.text,
                              messageType: MessageType.text,
                              createdAt: DateTime.now(),
                            );
                            context.read<SendTextCubit>().sendTextMessage(
                                message: textMessage,
                                receivingUserId: widget.user.id);
                            chatController.clear();
                          }
                        })
                  ],
                );
              },
            );
          }),
          vGap(5),
        ],
      ),
    );
  }
}
