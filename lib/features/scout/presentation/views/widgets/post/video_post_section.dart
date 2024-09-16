import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';

class VideoPostSection extends StatelessWidget {
  const VideoPostSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Image.asset(
          AppAssets.player,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
