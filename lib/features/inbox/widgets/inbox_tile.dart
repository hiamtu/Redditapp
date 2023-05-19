import 'package:flutter/material.dart';
import 'package:reddit_tutorial/features/inbox/widgets/circle_image.dart';
import 'package:reddit_tutorial/models/inbox_model.dart';

class InboxTile extends StatelessWidget {
  const InboxTile({Key? key, required this.post}) : super(key: key);
  final Inbox post;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleImage(
          imageProvider: AssetImage(post.profileImageUrl),
          imageRadius: 20,
        ),
        const SizedBox(
          height: 16,
          width: 16,
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.comment),
            Text(
              '${post.timestamp} mins ago',
              style: const TextStyle(fontWeight: FontWeight.w700),
            )
          ],
        ))
      ],
    );
  }
}
