import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import 'custom_font.dart';
import '../screens/detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

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
      icon: Icon(icon, color: color, size: 20.sp),
      label: CustomFont(text: label, fontSize: 12.sp, color: color),
    );
  }
}

class PostCard extends StatefulWidget {
  final int postId;
  final String userName;
  final String postContent;
  final DateTime date;
  final int initialLikes;
  final bool hasImage;
  final String profileImagePath;
  final String? postImagePath;
  final String addMarket;

  const PostCard({
    super.key,
    this.postId = 0,
    required this.userName,
    required this.postContent,
    this.initialLikes = 0,
    this.hasImage = false,
    required this.date,
    required this.profileImagePath,
    this.postImagePath,
    this.addMarket = "",
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int _currentLikes;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.initialLikes;
  }

  bool _isNetworkImage(String path) {
    return path.startsWith('http') || path.startsWith('https');
  }

  Widget _buildAdFooter() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "MORE DETAILS",
                style: TextStyle(color: Colors.white70, fontSize: 10.sp, fontWeight: FontWeight.w500, letterSpacing: 1.0),
              ),
              SizedBox(height: 4.h),
              Text(
                widget.addMarket,
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Container(
            height: 40.h,
            width: 60.w,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.arrow_forward, color: Colors.tealAccent, size: 20.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialFooter(bool isDark) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.thumb_up, size: 14, color: Colors.blueAccent),
                  SizedBox(width: 5.w),
                  CustomFont(text: '$_currentLikes', fontSize: 12.sp, color: isDark ? fbTextColorWhite : Colors.black),
                ],
              ),
              const SizedBox.shrink(), // Removed hardcoded comments count
            ],
          ),
        ),
        Divider(color: Colors.grey[600]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ActionButton(
              icon: _isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
              label: 'Like',
              color: _isLiked ? Colors.blueAccent : (isDark ? fbTextColorWhite : Colors.black),
              onPressed: () {
                setState(() {
                  if (_isLiked) {
                    _currentLikes--;
                    _isLiked = false;
                  } else {
                    _currentLikes++;
                    _isLiked = true;
                  }
                });
              },
            ),
            ActionButton(icon: Icons.chat_bubble_outline, label: 'Comment', color: isDark ? fbTextColorWhite : Colors.black, onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    postId: widget.postId,
                    userName: widget.userName,
                    postContent: widget.postContent,
                    date: widget.date,
                    numOfLikes: _currentLikes,
                    hasImage: widget.hasImage,
                    profileImagePath: widget.profileImagePath,
                    postImagePath: widget.postImagePath,
                  ),
                ),
              );
            }),
            ActionButton(icon: Icons.share_outlined, label: 'Share', color: isDark ? fbTextColorWhite : Colors.black, onPressed: () {}),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    bool isAd = widget.addMarket.isNotEmpty;
    ImageProvider profileImage = _isNetworkImage(widget.profileImagePath)
        ? CachedNetworkImageProvider(widget.profileImagePath)
        : AssetImage(widget.profileImagePath) as ImageProvider;

    return GestureDetector(
      onTap: () {
        // --- ADDED NAVIGATION ---
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              postId: widget.postId,
              userName: widget.userName,
              postContent: widget.postContent,
              date: widget.date,
              numOfLikes: _currentLikes,
              hasImage: widget.hasImage,
              profileImagePath: widget.profileImagePath,
              postImagePath: widget.postImagePath,
              // addMarket: widget.addMarket, // Uncomment if DetailScreen supports it
            ),
          ),
        );
      },
      child: Card(
        color: isDark ? fbLightPrimary : Colors.grey[100],
        margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(isAd ? 0 : 15.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(isAd ? 15.sp : 0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: profileImage,
                        ),
                        SizedBox(width: 10.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFont(text: widget.userName, fontSize: 15.sp, color: isDark ? fbTextColorWhite : Colors.black, fontWeight: FontWeight.bold),
                            Row(
                              children: [
                                CustomFont(text: DateFormat.yMMMMd().format(widget.date), fontSize: 12.sp, color: isDark ? fbTextColorWhite.withOpacity(0.7) : Colors.black54),
                                if (!isAd) ...[
                                  SizedBox(width: 3.w),
                                  Icon(Icons.circle, size: 3.sp, color: isDark ? fbTextColorWhite.withOpacity(0.7) : Colors.black54),
                                  SizedBox(width: 5.w),
                                  Icon(Icons.public, color: isDark ? fbTextColorWhite.withOpacity(0.7) : Colors.black54, size: 12.sp),
                                ]
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        Icon(Icons.more_horiz, color: isDark ? fbTextColorWhite.withOpacity(0.7) : Colors.black54),
                      ],
                    ),
                  ),
                  if (isAd) SizedBox(height: 0.h) else SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isAd ? 15.sp : 0),
                    child: CustomFont(text: widget.postContent, fontSize: 14.sp, color: isDark ? fbTextColorWhite : Colors.black),
                  ),
                  SizedBox(height: 10.h),
                  if (widget.hasImage && widget.postImagePath != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(isAd ? 0 : 8.r),
                      child: _isNetworkImage(widget.postImagePath!)
                          ? CachedNetworkImage(
                              imageUrl: widget.postImagePath!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: isAd ? 200.h : null,
                              placeholder: (context, url) => Container(height: 200.h, color: Colors.white10, child: const Center(child: CircularProgressIndicator())),
                              errorWidget: (context, url, error) => Container(height: 200.h, color: Colors.white10, child: const Icon(Icons.broken_image, color: Colors.grey)),
                            )
                          : Image.asset(
                              widget.postImagePath!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: isAd ? 200.h : null,
                            ),
                    ),
                ],
              ),
            ),
            if (isAd) _buildAdFooter() else _buildSocialFooter(isDark),
          ],
        ),
      ),
    );
  }
}