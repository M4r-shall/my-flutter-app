import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_font.dart';
import '../constants.dart';
import '../screens/detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class CustomInformation extends StatelessWidget {
  const CustomInformation({
    super.key,
    this.postId = 0,
    required this.name,
    required this.post,
    required this.description,
    this.profileImagePath,
  });

  final int postId;
  final String name;
  final String post;
  final String description;
  final String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              postId: postId,
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
        color: isDark ? fbLightPrimary : Colors.grey[100],
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
                    color: isDark ? fbTextColorWhite : Colors.black,
                  ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFont(
                    text: name,
                    fontSize: 20.sp,
                    color: isDark ? fbTextColorWhite : Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  CustomFont(
                    text: 'Posted: $post',
                    fontSize: 13.sp,
                    color: isDark ? fbTextColorWhite : Colors.black,
                  ),
                  CustomFont(
                    text: description,
                    fontSize: 12.sp,
                    color: isDark ? fbTextColorWhite : Colors.black,
                    fontStyle: FontStyle.italic,
                  ),
                ],
              ),
            ),
            Icon(Icons.more_horiz, color: isDark ? fbTextColorWhite.withOpacity(0.7) : Colors.black54),
          ],
        ),
      ),
    );
  }
}