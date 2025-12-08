import '../widgets/custom_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';

class Notification extends StatelessWidget {
  const Notification({
    super.key,
    required this.name,
    required this.post,
    required this.description});

  final String name;
  final String post;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fbLightPrimary,
      padding: EdgeInsets.all(ScreenUtil().setSp(15)),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: ScreenUtil().setSp(50),
            color: fbTextColorWhite,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFont(
                text: name,
                fontSize: ScreenUtil().setSp(20),
                color: fbTextColorWhite,
                fontWeight: FontWeight.w800,
              ),
              CustomFont(
                text: 'Posted: $post',
                fontSize: ScreenUtil().setSp(13),
                color: fbTextColorWhite,
              ),
              CustomFont(
                text: description,
                fontSize: ScreenUtil().setSp(12),
                color: fbTextColorWhite,
                fontStyle: FontStyle.italic,
              ),
            ],
          ),
          const Spacer(),
          Icon(Icons.more_horiz, color: fbTextColorWhite.withOpacity(0.7)),
        ],
      ),
    );
  }
}