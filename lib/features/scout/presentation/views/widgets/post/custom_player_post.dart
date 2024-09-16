import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/desc_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/head_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/tail_post_section.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/post/video_post_section.dart';

class CustomPlayerPost extends StatelessWidget {
  const CustomPlayerPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const HeadPostSection(),
          vGap(10),
          const DescPostSection(),
          vGap(10),
          const VideoPostSection(),
          const Divider(),
          const TailPostSection(),
        ],
      ),
    );
  }
}
