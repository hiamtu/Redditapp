import 'package:flutter/material.dart';
import 'package:reddit_tutorial/features/inbox/widgets/inbox_list_view.dart';
import 'package:reddit_tutorial/models/inbox_model.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  Future<List<Inbox>> _getFriendFeed() async {
    // Simulate api request wait time
    await Future.delayed(const Duration(milliseconds: 1000));
    // Load json from file system
    final dataString = await _loadAsset('assets/sample_friends_feed.json');
    // Decode to json
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Go through each post and convert json to Post object.
    if (json['feed'] != null) {
      final posts = <Inbox>[];
      json['feed'].forEach((v) {
        posts.add(Inbox.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the bottom');
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      print('i am at the top');
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getFriendFeed(),
      builder: (context, AsyncSnapshot<List<Inbox>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView(
            controller: _controller,
            scrollDirection: Axis.vertical,
            children: [
              InboxListView(friendPosts: snapshot.data ?? []),
              // Container(
              //   height: 400,
              //   color: Colors.green,
              // )
            ],
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
