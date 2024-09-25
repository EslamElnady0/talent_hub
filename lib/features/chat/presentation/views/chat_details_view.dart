import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/get%20messages%20cubit/get_messages_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20record%20cubit/send_record_cubit.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20text%20cubit/send_text_cubit.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'widgets/chat_details_appbar_leading.dart';
import 'widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as UserModel;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 55.w,
        backgroundColor: AppColors.primaryColor,
        leading: ChatDetailsAppBarLeading(image: args.imageUrl),
        title: Text(args.name, style: AppTextStyles.font20WhiteW600),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.white),
          )
        ],
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<SendTextCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SendFileCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<SendRecordCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<GetMessagesCubit>(),
          ),
        ],
        child: ChatDetailsViewBody(user: args),
      ),
    );
  }
}
