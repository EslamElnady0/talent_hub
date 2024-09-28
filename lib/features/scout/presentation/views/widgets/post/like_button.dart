import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class LikeButton extends StatelessWidget {
  const LikeButton(
      {super.key,
      required this.onTap,
      required this.isLiked,
      required this.text});
  final void Function()? onTap;
  final bool isLiked;
  final String text;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: isLiked ? AppColors.primaryColor : AppColors.black,
          ),
          hGap(8),
          Text(
            "$text likes",
            style: TextStyle(
              color: isLiked ? AppColors.primaryColor : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
