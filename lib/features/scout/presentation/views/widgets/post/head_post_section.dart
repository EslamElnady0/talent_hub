import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/models/post_model.dart';

class HeadPostSection extends StatelessWidget {
  const HeadPostSection({super.key, required this.postModel});
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(postModel.imageUrl!),
          ),
          hGap(10),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                postModel.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Text(
                postModel.date,
                style: const TextStyle(
                  color: Colors.grey,
                  height: 1.3,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz),
          )
        ],
      ),
    );
  }
}
