import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';

class CommentSectionUi extends StatelessWidget {
  const CommentSectionUi({
    super.key,
    required this.text,
    required this.user,
    required this.time,
    this.imageUrl,
  });

  final String text;
  final String user;
  final String time;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 23,
          backgroundImage: imageUrl == null
              ? AssetImage(AppAssets.player)
              : NetworkImage(imageUrl!),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              color: Colors.grey[300],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Expanded(
                      child: Text(
                        user,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                Text(text),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
