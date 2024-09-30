import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/features/player/presentation/views/widgets/profile_info.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/routes/app_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../scout/presentation/views/widgets/post/custom_player_post.dart';
class PlayerProfileBody extends StatelessWidget {
  const PlayerProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            const ProfileInfo(),
            TextButton(
              onPressed: () {
                context.pushNamed(AppRouter.post);
              },
              child: const Text(
                'Share Your Talent',
                style: TextStyle(fontSize: 20, color: AppColors.primaryColor),
              ),
            ),
            const Divider(),
            // ListView.separated(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   padding: const EdgeInsets.all(10),
            //   itemBuilder: (context, index) => const CustomPlayerPost(),
            //   separatorBuilder: (context, index) => vGap(10),
            //   itemCount: 10,
            // ),
          ],
        ),
      ),
    );
  }
}
