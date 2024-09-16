import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/user_image_circle_avatar.dart';

import '../../../../../core/theme/app_text_styles.dart';

class ChatInboxListTile extends StatelessWidget {
  const ChatInboxListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          const UserImageCircleAvatar(image: "assets/images/default_user.png"),
      title: Text("User Name", style: AppTextStyles.font16DarkW600),
      subtitle: const Text("last message"),
      trailing: const Text("12:00"),
      onTap: () => context.pushNamed(AppRouter.chatDetails),
    );
  }
}
