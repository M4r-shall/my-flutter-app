import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

  // --- HELPER: Detect if path is Network or Asset ---
  bool _isNetwork(String path) {
    return path.startsWith('http') || path.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    // Determine Profile Image Provider
    ImageProvider profileProvider = _isNetwork(widget.profileImagePath)
        ? CachedNetworkImageProvider(widget.profileImagePath)
        : AssetImage(widget.profileImagePath) as ImageProvider;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: fbDarkPrimary,
        elevation: 0,
        title: CustomFont(
          text: widget.userName,
          fontSize: 18.sp,
          color: fbTextColorWhite,
        ),
        iconTheme: const IconThemeData(color: fbTextColorWhite),
      ),
      backgroundColor: fbDarkPrimary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- POST IMAGE SECTION ---
            if (widget.hasImage && widget.postImagePath != null)
              SizedBox(
                width: double.infinity,
                child: _isNetwork(widget.postImagePath!)
                    ? CachedNetworkImage(
                        imageUrl: widget.postImagePath!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 300.h,
                          color: Colors.white10,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : Image.asset(
                        widget.postImagePath!,
                        fit: BoxFit.cover,
                      ),
              ),

            SizedBox(height: 20.h),

            // --- HEADER: USER INFO ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25.r,
                    backgroundColor: Colors.grey[800],
                    backgroundImage: profileProvider,
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFont(
                        text: widget.userName,
                        fontSize: 16.sp,
                        color: fbTextColorWhite,
                        fontWeight: FontWeight.bold,
                      ),
                      Row(
                        children: [
                          CustomFont(
                            text: DateFormat.yMMMMd().format(widget.date),
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 5.w),
                          Icon(Icons.public, color: Colors.grey, size: 14.sp),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 15.h),

            // --- POST CONTENT TEXT ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomFont(
                text: widget.postContent,
                fontSize: 15.sp,
                color: fbTextColorWhite,
              ),
            ),

            SizedBox(height: 30.h),
            const Divider(color: Colors.white12, thickness: 1),

            // --- ACTION BUTTONS ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Like Button with increment logic
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _currentLikes++;
                      });
                    },
                    icon: Icon(
                      _currentLikes > widget.numOfLikes 
                        ? Icons.thumb_up 
                        : Icons.thumb_up_outlined, 
                      color: _currentLikes > widget.numOfLikes 
                        ? Colors.blueAccent 
                        : fbTextColorWhite,
                    ),
                    label: CustomFont(
                      text: "Like ($_currentLikes)",
                      fontSize: 12.sp,
                      color: _currentLikes > widget.numOfLikes 
                        ? Colors.blueAccent 
                        : fbTextColorWhite,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mode_comment_outlined, color: fbTextColorWhite),
                    label: CustomFont(text: "Comment", fontSize: 12.sp, color: fbTextColorWhite),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined, color: fbTextColorWhite),
                    label: CustomFont(text: "Share", fontSize: 12.sp, color: fbTextColorWhite),
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12, thickness: 1),
          ],
        ),
      ),
    );
  }
}