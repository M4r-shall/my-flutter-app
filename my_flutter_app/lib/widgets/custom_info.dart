import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
import '../constants.dart';
import '../screens/detail_screen.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    required this.name,
    required this.post,
    required this.description,
    this.profileImagePath,
  });

  final String name;
  final String post;
  final String description;
  final String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              userName: name,
              postContent: "$post\n\n$description",
              date: DateTime.now(),
              numOfLikes: 0,
              hasImage: false,

              profileImagePath: profileImagePath ?? 'assets/images/fbprofile.JPG',
            ),
          ),
        );
      },
      child: Container(
        color: fbLightPrimary,
        padding: EdgeInsets.all(15.sp),
        child: Row(
          children: [
            (profileImagePath != null && profileImagePath!.isNotEmpty)
                ? CircleAvatar(
                    radius: 25.sp,
                    backgroundImage: AssetImage(profileImagePath!),
                  )
                : Icon(
                    Icons.person,
                    size: 50.sp,
                    color: fbTextColorWhite,
                  ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: name,
                    fontSize: 20.sp,
                    color: fbTextColorWhite,
                    fontWeight: FontWeight.w800,
                  ),
                  CustomFont(
                    text: 'Posted: $post',
                    fontSize: 13.sp,
                    color: fbTextColorWhite,
                  ),
                  CustomFont(
                    text: description,
                    fontSize: 12.sp,
                    color: fbTextColorWhite,
                    fontStyle: FontStyle.italic,
                  ),
                ],
              ),
            ),
            Icon(Icons.more_horiz, color: fbTextColorWhite.withOpacity(0.7)),
          ],
        ),
      ),
    );
  }
}