import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/custom_player_post.dart';

class ScoutViewBody extends StatelessWidget {
  const ScoutViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => const CustomPlayerPost(),
      separatorBuilder: (context, index) => vGap(10),
      itemCount: 10,
    );
  }
}
