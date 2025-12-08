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
      'name': 'Cyrus Robles',
      'post': 'Your latest submission.',
      'description': 'Graded your mobile programming assignment.',
    },
    {
      'name': 'Wizards Circle',
      'post': 'Event announcement.',
      'description': 'Invites you to the annual movie marathon.',
    },
    {
      'name': 'Marius Clarence Panahon',
      'post': 'Status update.',
      'description': 'Reacted to your post.',
    },
    {
      'name': 'Paula',
      'post': 'Shared content.',
      'description': 'Shared your photo.',
    },
    {
      'name': 'Adrian',
      'post': 'Comment.',
      'description': 'Wrote a comment on your newsfeed card.',
    },
    {
      'name': 'Shem',
      'post': 'Friend Request.',
      'description': 'Shem sent you a friend request.',
    },
    {
      'name': 'National University',
      'post': 'School Advisory.',
      'description': 'Classes are suspended tomorrow due to heavy rain.',
    },
    {
      'name': 'JB',
      'post': 'Birthday.',
      'description': 'It\'s JB\'s birthday today!',
    },
    {
      'name': 'Vergie',
      'post': 'Meeting reminder.',
      'description': 'Group meeting at 4 PM in the library.',
    },
    {
      'name': 'Task Force 141',
      'post': 'News.',
      'description': 'A new discovery was made in Yemen.',
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
              ),
              const Divider(color: Colors.grey),
            ],
          );
        }).toList(),
      ),
    );
  }
}