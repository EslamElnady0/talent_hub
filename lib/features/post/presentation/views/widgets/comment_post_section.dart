import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:talent_hub/core/models/post_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/post/presentation/views/widgets/comment_section_ui.dart';

class CommentPostSection extends StatelessWidget {
  const CommentPostSection({super.key, required this.postModel});
  final PostModel postModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .doc(postModel.postId)
          .collection('comments')
          .orderBy(
            "commentTime",
            descending: true,
          )
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: LinearProgressIndicator(color: AppColors.primaryColor),
          );
        }
        return Column(
          children: [
            const Divider(endIndent: 10, indent: 10),
            const SizedBox(height: 10),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: snapshot.data!.docs.map((doc) {
                final commentData = doc.data() as Map<String, dynamic>;
                return CommentSectionUi(
                  text: commentData['commentText'],
                  user: commentData['commentedBy'],
                  imageUrl: commentData['imageUrl'],
                  time: DateFormat('EEEE, h:mm a').format(
                    commentData['commentTime'].toDate(),
                  ),
                );
              }).toList(),
            ),
            if (snapshot.data!.docs.isEmpty)
              Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .333),
                  const Text(
                    'No comment yet',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
