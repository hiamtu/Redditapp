import 'package:flutter/material.dart';
import 'package:reddit_tutorial/models/inbox_model.dart';
import 'inbox_tile.dart';

class InboxListView extends StatelessWidget {
  const InboxListView({Key? key, required this.friendPosts}) : super(key: key);
  final List<Inbox> friendPosts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          ListView.separated(
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final post = friendPosts[index];
                return InboxTile(post: post);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: friendPosts.length),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
