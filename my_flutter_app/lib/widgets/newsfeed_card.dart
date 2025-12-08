import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;
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
        fontSize: ScreenUtil().setSp(12),
        color: color,
      ),
    );
  }
}

class NewsFeedCard extends StatelessWidget {
  final String userName;
  final String postContent;
  final String date;
  final int numOfLikes;
  final bool hasImage;
  const NewsFeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    this.hasImage = false,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fbLightPrimary,
      margin: EdgeInsets.all(ScreenUtil().setSp(10)),
      child: Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/marius.jpg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: userName,
                      fontSize: ScreenUtil().setSp(15),
                      color: fbTextColorWhite,
                      fontWeight: FontWeight.bold,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomFont(
                          text: date,
                          fontSize: ScreenUtil().setSp(12),
                          color: fbTextColorWhite.withOpacity(0.7),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(3),
                        ),
                        Icon(
                          Icons.public,
                          color: fbTextColorWhite.withOpacity(0.7),
                          size: ScreenUtil().setSp(15),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Icon(Icons.more_horiz, color: fbTextColorWhite.withOpacity(0.7)),
              ],
            ),

            SizedBox(height: ScreenUtil().setHeight(5)),
            // post content
            CustomFont(
              text: postContent,
              fontSize: ScreenUtil().setSp(12),
              color: fbTextColorWhite,
            ),
            SizedBox(height: ScreenUtil().setHeight(5)),
            hasImage == true
            ? Image.asset(
                'assets/images/mall.jpg',
                height: ScreenUtil().setHeight(350), 
                width: double.infinity,
                fit: BoxFit.cover,
              )          
            : const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButton(
                  icon: Icons.thumb_up,
                  label: '$numOfLikes', 
                  color: fbPrimary,
                  onPressed: () => developer.log('Liked'),
                ),
                ActionButton(
                  icon: Icons.comment,
                  label: 'Comment',
                  color: fbPrimary,
                  onPressed: () {},
                ),
                ActionButton(
                  icon: Icons.redo,
                  label: 'Share',
                  color: fbPrimary,
                  onPressed: () {},
                ),
              ],
            ),
            Row(
              children: [
                const CircleAvatar(
                  radius: 13,
                  backgroundImage: AssetImage('assets/images/marius.jpg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(ScreenUtil().setSp(10), 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  height: ScreenUtil().setHeight(25),
                  width: ScreenUtil().setWidth(330),
                  decoration: BoxDecoration(
                    color: fbDarkPrimary.withOpacity(0.5),
                    borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setSp(10))),
                    ),
                  child: CustomFont(
                  text: 'Write a comment...',
                  fontSize: ScreenUtil().setSp(11),
                  color: fbTextColorWhite.withOpacity(0.6),
                  ),  
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(10),
            ),
            CustomFont(
              text: 'View comments',
              fontSize: ScreenUtil().setSp(12),
              fontWeight: FontWeight.bold,
              color: fbTextColorWhite,
            ),
          ],
        ),
      ),
    );
  }
}

