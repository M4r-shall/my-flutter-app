import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import 'custom_font.dart';

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: CustomFont(
        text: label,
        fontSize: 12.sp,
        color: color,
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final DateTime date;
  final int numOfLikes;
  final bool hasImage;
  final String profileImagePath;
  final String? postImagePath;

  const PostCard({
    super.key,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    this.hasImage = false,
    required this.date,
    required this.profileImagePath,
    this.postImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fbLightPrimary,
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(15.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //header
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage(profileImagePath),
                ),
                SizedBox(width: 10.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: userName,
                      fontSize: 15.sp,
                      color: fbTextColorWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      children: [
                        CustomFont(
                          text: DateFormat.yMMMMd().format(date),
                          fontSize: 12.sp,
                          color: fbTextColorWhite.withOpacity(0.7),
                        ),
                        SizedBox(width: 3.w),
                        Icon(Icons.circle, size: 3, color:fbTextColorWhite.withOpacity(0.7)),
                        SizedBox(width: 5.w),
                        Icon(Icons.public, color: fbTextColorWhite.withOpacity(0.7), size: 12.sp),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Icon(Icons.more_horiz, color: fbTextColorWhite.withOpacity(0.7)),
              ],
            ),

            SizedBox(height: 10.h),
            CustomFont(
              text: postContent,
              fontSize: 14.sp,
              color: fbTextColorWhite,
            ),
            SizedBox(height: 10.h),

            if (hasImage && postImagePath != null)
              Container(
                margin: EdgeInsets.only(bottom: 10.h),
                child: Image.asset(
                  postImagePath!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),

              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, size: 14, color: fbTextColorWhite),
                    SizedBox(width: 5),
                    CustomFont(text: '$numOfLikes', fontSize: 12.sp, color: fbTextColorWhite),
                  ],
                ),
                CustomFont(text: "3 Comments", fontSize: 12.sp, color: fbTextColorWhite),
              ],
            ),
            
            Divider(color: Colors.grey[600]),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ActionButton(icon: Icons.thumb_up_outlined, label: 'Like', color: fbTextColorWhite, onPressed: () {}),
                ActionButton(icon: Icons.chat_bubble_outline, label: 'Comment', color:fbTextColorWhite, onPressed: () {}),
                ActionButton(icon: Icons.share_outlined, label: 'Share', color: fbTextColorWhite, onPressed: () {}),
              ],
            ),

            Divider(color: Colors.grey[600]),

            Row(
              children: [
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/images/fbprofile.JPG'), 
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    height: 35.h,
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Write a comment...',
                      style: TextStyle(color: fbTextColorWhite.withOpacity(0.6), fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}