import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';
import '../services/comment_service.dart';
import '../models/comment.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            
            // --- COMMENTS SECTION ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: CustomFont(text: 'Comments', fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
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
                          title: Text(comment.user?.username ?? 'Unknown', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          subtitle: Text(comment.body, style: const TextStyle(color: Colors.white70)),
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
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Write a comment...',
                        hintStyle: const TextStyle(color: Colors.white54),
                        filled: true,
                        fillColor: Colors.grey[800],
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