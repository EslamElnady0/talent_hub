import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';

import '../../../../../core/theme/app_colors.dart';

class CustomImageMessageWidget extends StatelessWidget {
  final String imagePath;
  const CustomImageMessageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: context.height * 0.2),
      child: CachedNetworkImage(
        placeholder: (context, url) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.white,
            ),
          );
        },
        imageUrl: imagePath,
        width: context.width * 0.7,
      ),
    );
  }
}
