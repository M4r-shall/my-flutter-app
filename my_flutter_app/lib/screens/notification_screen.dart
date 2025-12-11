import '../widgets/notification.dart' as notif;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, String>> dummyNotifications = const [
    {
      'name': 'Boss',
      'post': 'Your latest submission.',
      'description': 'Graded your mobile programming assignment.',
      'profileImagePath': 'assets/images/cat actually.jpg',
    },
    {
      'name': 'Wizards Circle',
      'post': 'Event announcement.',
      'description': 'Invites you to the annual movie marathon.',
      'profileImagePath': 'assets/images/cat angry.jpg',
    },
    {
      'name': 'Marius',
      'post': 'Status update.',
      'description': 'Reacted to your post.',
      'profileImagePath': 'assets/images/cat banana.jpg',
    },
    {
      'name': 'Paula',
      'post': 'Shared content.',
      'description': 'Shared your photo.',
      'profileImagePath': 'assets/images/cat bruh.jpg',
    },
    {
      'name': 'Adrian',
      'post': 'Comment.',
      'description': 'Wrote a comment on your newsfeed card.',
      'profileImagePath': 'assets/images/cat derp.jpg',
    },
    {
      'name': 'Shem',
      'post': 'Friend Request.',
      'description': 'Shem sent you a friend request.',
      'profileImagePath': 'assets/images/cat fkower.jpg',
    },
    {
      'name': 'National University',
      'post': 'School Advisory.',
      'description': 'Classes are suspended tomorrow due to heavy rain.',
      'profileImagePath': 'assets/images/cat girly.jpg',
    },
    {
      'name': 'JB',
      'post': 'Birthday.',
      'description': 'It\'s JB\'s birthday today!',
      'profileImagePath': 'assets/images/cat hearteyes.jpg',
    },
    {
      'name': 'Vergie',
      'post': 'Meeting reminder.',
      'description': 'Group meeting at 4 PM in the library.',
      'profileImagePath': 'assets/images/cat mouth.jpg',
    },
    {
      'name': 'Task Force 141',
      'post': 'News.',
      'description': 'A new discovery was made in Yemen.',
      'profileImagePath': 'assets/images/cat narly.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fbDarkPrimary,
      width: ScreenUtil().screenWidth,
      child: ListView(
        children: dummyNotifications.map((notification) {
          return Column(
            children: [
              notif.Notification(
                name: notification['name'] as String,
                post: notification['post'] as String,
                description: notification['description'] as String,
                profileImagePath: notification['profileImagePath'],
              ),
              const Divider(color: Colors.grey),
            ],
          );
        }).toList(),
      ),
    );
  }
}