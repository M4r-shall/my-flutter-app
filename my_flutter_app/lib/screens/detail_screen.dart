import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';

class DetailScreen extends StatefulWidget {
  final String userName;
  final String postContent;
  final DateTime date;
  final int numOfLikes;
  final bool hasImage;
  final String profileImagePath;
  final String? postImagePath;

  const DetailScreen({
    super.key,
    required this.userName,
    required this.postContent,
    required this.date,
    this.numOfLikes = 0,
    this.hasImage = false,
    required this.profileImagePath,
    this.postImagePath,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late int _currentLikes;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.numOfLikes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbDarkPrimary,
        title: CustomFont(
          text: widget.userName,
          fontSize: 20.sp,
          color: fbTextColorWhite,
        ),
        iconTheme: const IconThemeData(color: fbTextColorWhite),
      ),
      backgroundColor: fbDarkPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.hasImage && widget.postImagePath != null)
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: Image.asset(widget.postImagePath!, fit: BoxFit.cover),
              ),
            
            SizedBox(height: 20.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.sp,
                    backgroundImage: AssetImage(widget.profileImagePath),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: 20.sp,
                        color: fbTextColorWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          CustomFont(
                            text: "${widget.date.month}/${widget.date.day}",
                            fontSize: 15.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5.w),
                          Icon(Icons.public, color: Colors.grey, size: 15.sp),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            // Post Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomFont(
                text: widget.postContent,
                fontSize: 18.sp,
                color: fbTextColorWhite,
              ),
            ),

            SizedBox(height: 30.h),
            const Divider(color: Colors.grey),

            // Action Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ENHANCEMENT 3: Like button increments count
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentLikes++;
                      });
                    },
                    icon: const Icon(Icons.thumb_up, color: fbTextColorWhite),
                    label: CustomFont(
                      text: "Like ($_currentLikes)",
                      fontSize: 12.sp,
                      color: fbTextColorWhite,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.comment, color: fbTextColorWhite),
                    label: CustomFont(text: "Comment", fontSize: 12.sp, color: fbTextColorWhite),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.redo, color: fbTextColorWhite),
                    label: CustomFont(text: "Share", fontSize: 12.sp, color: fbTextColorWhite),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}