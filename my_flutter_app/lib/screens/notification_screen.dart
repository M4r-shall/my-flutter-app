import '../widgets/custom_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> dummyNotifications = const [
    {
      'postId': 1,
      'name': 'Boss',
      'post': 'Your latest submission.',
      'description': 'Graded your mobile programming assignment.',
      'profileImagePath': 'assets/images/cat actually.jpg',
    },
    {
      'postId': 2,
      'name': 'Wizards Circle',
      'post': 'Event announcement.',
      'description': 'Invites you to the annual movie marathon.',
      'profileImagePath': 'assets/images/cat angry.jpg',
    },
    {
      'postId': 3,
      'name': 'Marius',
      'post': 'Status update.',
      'description': 'Reacted to your post.',
      'profileImagePath': 'assets/images/cat banana.jpg',
    },
    {
      'postId': 4,
      'name': 'Paula',
      'post': 'Shared content.',
      'description': 'Shared your photo.',
      'profileImagePath': 'assets/images/cat bruh.jpg',
    },
    {
      'postId': 5,
      'name': 'Adrian',
      'post': 'Comment.',
      'description': 'Wrote a comment on your newsfeed card.',
      'profileImagePath': 'assets/images/cat derp.jpg',
    },
    {
      'postId': 6,
      'name': 'Shem',
      'post': 'Friend Request.',
      'description': 'Shem sent you a friend request.',
      'profileImagePath': 'assets/images/cat fkower.jpg',
    },
    {
      'postId': 7,
      'name': 'National University',
      'post': 'School Advisory.',
      'description': 'Classes are suspended tomorrow due to heavy rain.',
      'profileImagePath': 'assets/images/cat girly.jpg',
    },
    {
      'postId': 8,
      'name': 'JB',
      'post': 'Birthday.',
      'description': 'It\'s JB\'s birthday today!',
      'profileImagePath': 'assets/images/cat hearteyes.jpg',
    },
    {
      'postId': 9,
      'name': 'Vergie',
      'post': 'Meeting reminder.',
      'description': 'Group meeting at 4 PM in the library.',
      'profileImagePath': 'assets/images/cat mouth.jpg',
    },
    {
      'postId': 10,
      'name': 'Task Force 141',
      'post': 'News.',
      'description': 'A new discovery was made in Yemen.',
      'profileImagePath': 'assets/images/cat narly.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Container(
      color: isDark ? fbDarkPrimary : Colors.white,
      width: ScreenUtil().screenWidth,
      child: ListView(
        children: dummyNotifications.map((notification) {
          return Column(
            children: [
              CustomInformation(
                postId: notification['postId'] as int,
                name: notification['name'] as String,
                post: notification['post'] as String,
                description: notification['description'] as String,
                profileImagePath: notification['profileImagePath'] as String?,
              ),
              const Divider(color: Colors.grey),
            ],
          );
        }).toList(),
      ),
    );
  }
}