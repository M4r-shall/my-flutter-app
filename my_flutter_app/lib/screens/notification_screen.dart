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
      'name': 'Prof. T.F. Talk',
      'post': 'Your latest submission.',
      'description': 'Graded your mobile programming assignment.',
    },
    {
      'name': 'Academia Club',
      'post': 'Event announcement.',
      'description': 'Invites you to the annual reading marathon.',
    },
    {
      'name': 'Marius Panahon',
      'post': 'Status update.',
      'description': 'Reacted to your post.',
    },
    {
      'name': 'Pau Pau',
      'post': 'Shared content.',
      'description': 'Shared your photo.',
    },
    {
      'name': 'Roben Juanatas',
      'post': 'Comment.',
      'description': 'Wrote a comment on your newsfeed card.',
    },
    {
      'name': 'Cyrus Robles',
      'post': 'Friend Request.',
      'description': 'Cyrus Robles sent you a friend request.',
    },
    {
      'name': 'The University',
      'post': 'School Advisory.',
      'description': 'Classes are suspended tomorrow due to heavy rain.',
    },
    {
      'name': 'Jane Doe',
      'post': 'Birthday.',
      'description': 'It\'s Jane Doe\'s birthday today!',
    },
    {
      'name': 'Project Group 3',
      'post': 'Meeting reminder.',
      'description': 'Group meeting at 4 PM in the library.',
    },
    {
      'name': 'Global Events',
      'post': 'News.',
      'description': 'A new discovery was made in astrophysics.',
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