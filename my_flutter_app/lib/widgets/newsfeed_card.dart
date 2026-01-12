import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import '../constants.dart';
import 'custom_font.dart';
import '../screens/detail_screen.dart';

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

class NewsFeedCard extends StatefulWidget {
  final String userName;
  final String postContent;
  final DateTime date;
  final int numOfLikes;
  final bool hasImage;
  final String profileImagePath;

  const NewsFeedCard({
    super.key,
    required this.userName,
    required this.postContent,
    this.numOfLikes = 0,
    this.hasImage = false,
    required this.date,
    required this.profileImagePath,
  });

  @override
  State<NewsFeedCard> createState() => _NewsFeedCardState();
}

class _NewsFeedCardState extends State<NewsFeedCard> {
  // State to track if the post is liked
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userName: widget.userName,
              postContent: widget.postContent,
              date: widget.date,
              numOfLikes: widget.numOfLikes,
              hasImage: widget.hasImage,
              profileImagePath: widget.profileImagePath,
              postImagePath: widget.hasImage ? 'assets/images/mall.jpg' : null,
            ),
          ),
        );
      },
      child: Card(
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
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(widget.profileImagePath),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: ScreenUtil().setSp(15),
                        color: fbTextColorWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomFont(
                            text: DateFormat.yMMMMd().format(widget.date),
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
                text: widget.postContent,
                fontSize: ScreenUtil().setSp(12),
                color: fbTextColorWhite,
              ),
              SizedBox(height: ScreenUtil().setHeight(5)),
              widget.hasImage == true
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
                    label: '${widget.numOfLikes}',
                    // CHANGE: Toggle color based on _isLiked state
                    color: _isLiked ? Colors.red : fbTextColorWhite,
                    onPressed: () {
                      setState(() {
                        _isLiked = !_isLiked;
                      });
                      developer.log('Liked: $_isLiked');
                    },
                  ),
                  ActionButton(
                    icon: Icons.comment,
                    label: 'Comment',
                    color: fbTextColorWhite,
                    onPressed: () {},
                  ),
                  ActionButton(
                    icon: Icons.redo,
                    label: 'Share',
                    color: fbTextColorWhite,
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
      ),
    );
  }
}