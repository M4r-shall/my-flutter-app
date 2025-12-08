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
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Wizards Circle',
      'post': 'Event announcement.',
      'description': 'Invites you to the annual movie marathon.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Marius',
      'post': 'Status update.',
      'description': 'Reacted to your post.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Paula',
      'post': 'Shared content.',
      'description': 'Shared your photo.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Adrian',
      'post': 'Comment.',
      'description': 'Wrote a comment on your newsfeed card.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Shem',
      'post': 'Friend Request.',
      'description': 'Shem sent you a friend request.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'National University',
      'post': 'School Advisory.',
      'description': 'Classes are suspended tomorrow due to heavy rain.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'JB',
      'post': 'Birthday.',
      'description': 'It\'s JB\'s birthday today!',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Vergie',
      'post': 'Meeting reminder.',
      'description': 'Group meeting at 4 PM in the library.',
      'profileImagePath': 'assets/images/owl.jpg',
    },
    {
      'name': 'Task Force 141',
      'post': 'News.',
      'description': 'A new discovery was made in Yemen.',
      'profileImagePath': 'assets/images/owl.jpg',
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