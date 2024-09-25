import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../scout/presentation/views/widgets/post/custom_player_post.dart';
import 'add_post_section.dart';
class PlayerViewBody extends StatelessWidget {
  const PlayerViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          addPostSection(context),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) => const CustomPlayerPost(),
            separatorBuilder: (context, index) => vGap(10),
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
