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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: fbDarkPrimary,
      width: ScreenUtil().screenWidth,
      child: Column(
        children: const [
          notif.Notification(name: 'Test', post: 'Post', description: 'Description',),
          Divider(),
        ],
      ),
    );
  }
}   