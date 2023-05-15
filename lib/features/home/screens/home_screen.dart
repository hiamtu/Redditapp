import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/core/constants/constants.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/features/home/delegates/search_community_delegate.dart';
import 'package:reddit_tutorial/features/home/drawers/community_list_drawer.dart';
import 'package:reddit_tutorial/features/home/drawers/profile_drawer.dart';
import 'package:reddit_tutorial/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _page = 0;
  final widgetTitle = ["Home", "Explore", "Create", "Chat", "Inbox"];
  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 12, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        bottom: _page == 1
            ? TabBar(
                padding: const EdgeInsets.all(12.0),
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), // Creates border
                    color: Color.fromARGB(255, 188, 186, 186)),
                controller: _tabController,
                tabs: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'All',
                        style: TextStyle(
                            fontSize: 15,
                            color:
                                currentTheme.appBarTheme.titleTextStyle!.color),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Technology',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Funny',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Decor',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Music',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Gaming',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Nature',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Finance',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Science',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Streamers',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Cars',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hobbies',
                          style: TextStyle(
                              fontSize: 15,
                              color: currentTheme
                                  .appBarTheme.titleTextStyle!.color)),
                    )
                  ])
            : null,
        title: Text(widgetTitle.elementAt(_page)),
        centerTitle: _page == 0 ? false : true,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          _page == 0
              ? IconButton(
                  onPressed: () {
                    Routemaster.of(context).push('/scan-qr-code');
                  },
                  icon: const Icon(Icons.qr_code_scanner),
                )
              : Container(),
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          })
        ],
      ),
      body: Constants.tabWidgets[_page],
      drawer: const CommunityListDrawer(),
      endDrawer: isGuest ? null : const ProfileDrawer(),
      bottomNavigationBar: isGuest
          ? null
          : CupertinoTabBar(
              activeColor: currentTheme.iconTheme.color,
              backgroundColor: currentTheme.backgroundColor,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.explore_outlined),
                  label: 'Discover',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Create',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wechat),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_none),
                  label: 'Inbox',
                ),
              ],
              onTap: onPageChanged,
              currentIndex: _page,
            ),
    );
  }
}
