import 'package:flutter/material.dart';
import 'package:talent_hub/core/models/post_model.dart';

class DescPostSection extends StatelessWidget {
  const DescPostSection({super.key, required this.postModel});
  final PostModel postModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text(
          postModel.text,
          overflow: TextOverflow.ellipsis,
          maxLines: 4,
        ),
      ),
    );
  }
}
