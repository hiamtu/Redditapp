import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_tutorial/features/auth/controller/auth_controller.dart';
import 'package:reddit_tutorial/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';
import 'package:day_night_switcher/day_night_switcher.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({super.key});
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logOut();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(user.profilePic),
              radius: 70,
            ),
            const SizedBox(height: 10),
            Text(
              'u/${user.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text('Log Out'),
              leading: Icon(
                Icons.logout,
                color: Pallete.redColor,
              ),
              onTap: () => logOut(ref),
            ),
            // Switch.adaptive(
            //   value: ref.watch(themeNotifierProvider.notifier).mode ==
            //       ThemeMode.dark,
            //   onChanged: (val) => toggleTheme(ref),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Options',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22, top: 10),
                    child: Row(
                      children: [
                        const Icon(Icons.nights_stay_rounded),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Dark mode',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 56,
                          height: 48,
                          child: DayNightSwitcher(
                            isDarkModeEnabled: ref
                                    .watch(themeNotifierProvider.notifier)
                                    .mode ==
                                ThemeMode.dark,
                            onStateChanged: (isDarkModeEnabled) {
                              isDarkModeEnabled ? toggleTheme(ref) : null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22, top: 10),
                    child: InkWell(
                      onTap: () {
                        // Future.delayed(Duration(milliseconds: 500),
                        //     () => widget.toggleDrawer(false));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => Saved(),
                        //   ),
                        // );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.bookmark_rounded),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Saved posts',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 22, top: 10),
                    child: InkWell(
                      onTap: () {
                        // Future.delayed(Duration(milliseconds: 500),
                        //     () => widget.toggleDrawer(false));
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) => MoreOptions(),
                        //   ),
                        // );
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.more_horiz_rounded),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'More options',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
