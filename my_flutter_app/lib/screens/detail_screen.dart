import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';
import '../services/comment_service.dart';
import '../models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DetailScreen extends StatefulWidget {
  final int postId;
  final String userName;
  final String postContent;
  final DateTime date;
  final int numOfLikes;
  final bool hasImage;
  final String profileImagePath;
  final String? postImagePath;

  const DetailScreen({
    super.key,
    this.postId = 0,
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
  bool _isLoadingComments = true;
  List<Comment> _comments = [];
  final TextEditingController _commentController = TextEditingController();
  bool _isPosting = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _currentLikes = widget.numOfLikes;
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    try {
      final comments = await CommentService().getCommentsByPost(widget.postId);
      if (mounted) {
        setState(() {
          _comments = comments;
          _isLoadingComments = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingComments = false);
      }
    }
  }

  Future<void> _postComment() async {
    if (_commentController.text.trim().isEmpty) return;
    setState(() => _isPosting = true);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId') ?? 1;
      
      final newComment = await CommentService().addComment(_commentController.text.trim(), widget.postId, userId);
      
      _commentController.clear();
      setState(() {
        _comments.add(newComment);
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Comment added!')));
      }
    } catch(e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to post comment: $e')));
      }
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }

  // --- HELPER: Detect if path is Network or Asset ---
  bool _isNetwork(String path) {
    return path.startsWith('http') || path.startsWith('https');
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    // Determine Profile Image Provider
    ImageProvider profileProvider = _isNetwork(widget.profileImagePath)
        ? CachedNetworkImageProvider(widget.profileImagePath)
        : AssetImage(widget.profileImagePath) as ImageProvider;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: isDark ? fbDarkPrimary : Colors.white,
        elevation: 0,
        title: CustomFont(
          text: widget.userName,
          fontSize: 18.sp,
          color: isDark ? fbTextColorWhite : Colors.black,
        ),
        iconTheme: IconThemeData(color: isDark ? fbTextColorWhite : Colors.black),
      ),
      backgroundColor: isDark ? fbDarkPrimary : Colors.white,
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
                        color: isDark ? fbTextColorWhite : Colors.black,
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
                color: isDark ? fbTextColorWhite : Colors.black,
              ),
            ),

            SizedBox(height: 30.h),
            Divider(color: isDark ? Colors.white12 : Colors.black12, thickness: 1),

            // --- ACTION BUTTONS ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Like Button with toggle logic
                  TextButton.icon(
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
                    icon: Icon(
                      _isLiked 
                        ? Icons.thumb_up 
                        : Icons.thumb_up_outlined, 
                      color: _isLiked 
                        ? Colors.blueAccent 
                        : (isDark ? fbTextColorWhite : Colors.black),
                    ),
                    label: CustomFont(
                      text: "Like ($_currentLikes)",
                      fontSize: 12.sp,
                      color: _isLiked 
                        ? Colors.blueAccent 
                        : (isDark ? fbTextColorWhite : Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.mode_comment_outlined, color: isDark ? fbTextColorWhite : Colors.black),
                    label: CustomFont(text: "Comment", fontSize: 12.sp, color: isDark ? fbTextColorWhite : Colors.black),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.share_outlined, color: isDark ? fbTextColorWhite : Colors.black),
                    label: CustomFont(text: "Share", fontSize: 12.sp, color: isDark ? fbTextColorWhite : Colors.black),
                  ),
                ],
              ),
            ),
            Divider(color: isDark ? Colors.white12 : Colors.black12, thickness: 1),
            
            // --- COMMENTS SECTION ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomFont(text: 'Comments', fontSize: 16.sp, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
            ),
            
            _isLoadingComments 
              ? const Center(child: CircularProgressIndicator(color: fbPrimary))
              : _comments.isEmpty 
                  ? const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('No comments yet.', style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _comments.length,
                      itemBuilder: (context, index) {
                        final comment = _comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[800],
                            child: Text(comment.user?.username[0].toUpperCase() ?? 'U', style: const TextStyle(color: Colors.white)),
                          ),
                          title: Text(comment.user?.username ?? 'Unknown', style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold)),
                          subtitle: Text(comment.body, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54)),
                        );
                      },
                    ),
            
            // --- ADD COMMENT FIELD ---
            Padding(
              padding: EdgeInsets.all(15.w),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        hintStyle: TextStyle(color: isDark ? Colors.white54 : Colors.black54),
                        filled: true,
                        fillColor: isDark ? Colors.grey[800] : Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  _isPosting 
                    ? const CircularProgressIndicator(color: fbPrimary)
                    : IconButton(
                        icon: const Icon(Icons.send, color: fbPrimary),
                        onPressed: _postComment,
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