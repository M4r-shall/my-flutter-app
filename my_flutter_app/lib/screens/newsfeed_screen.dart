import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../constants.dart';
import '../widgets/post_card.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../services/post_service.dart';
import '../services/user_service.dart';

class NewsfeedScreen extends StatefulWidget {
  const NewsfeedScreen({super.key});

  @override
  State<NewsfeedScreen> createState() => _NewsfeedScreenState();
}

class _NewsfeedScreenState extends State<NewsfeedScreen> {
  List<Post> _posts = [];
  final Map<int, User> _authors = {};
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts({bool showLoader = true}) async {
    if (showLoader) {
      setState(() {
        _isLoading = true;
        _error = null;
      });
    }

    try {
      final posts = await PostService().getPosts();

      // Fetch each unique author once for their name and avatar
      final missingIds = posts
          .map((p) => p.userId)
          .toSet()
          .where((id) => !_authors.containsKey(id));
      final users = await Future.wait(
        missingIds.map((id) => UserService().getUserById(id).then<User?>((u) => u, onError: (_) => null)),
      );
      for (final user in users) {
        if (user != null) _authors[user.id] = user;
      }

      if (!mounted) return;
      setState(() {
        _posts = posts;
        _isLoading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Failed to load posts.';
        _isLoading = false;
      });
    }
  }

  // --- 5-7 AD ITEMS (Using Network Images) ---
  List<Widget> carouselItems() {
    return [
      PostCard(
        postId: 21,
        userName: "Pet Shop Promos",
        postContent: "50% OFF on all premium dog food! Limited time only.",
        date: DateTime.now(),
        addMarket: "50% OFF",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
      PostCard(
        postId: 22,
        userName: "Gadget World",
        postContent:
            "New Smart Collar available now. Track your pets anywhere.",
        date: DateTime.now(),
        addMarket: "NEW ITEM",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
      PostCard(
        postId: 23,
        userName: "VetCare Plus",
        postContent: "Free checkup for new puppies this weekend.",
        date: DateTime.now(),
        addMarket: "SERVICE",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
      PostCard(
        postId: 24,
        userName: "Toy Kingdom",
        postContent: "Chew toys that last forever. Guaranteed.",
        date: DateTime.now(),
        addMarket: "BEST SELLER",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1576201836106-db1758fd1c97?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
      PostCard(
        postId: 25,
        userName: "Cyrus Deals",
        postContent: "Buy 1 Get 1 on all cat treats.",
        date: DateTime.now(),
        addMarket: "PROMO",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
    ];
  }

  PostCard _buildPostCard(Post post) {
    final author = _authors[post.userId];
    final name = author != null
        ? '${author.firstName} ${author.lastName}'.trim()
        : 'User ${post.userId}';

    return PostCard(
      postId: post.id,
      userName: name.isEmpty ? (author?.username ?? 'User ${post.userId}') : name,
      title: post.title,
      postContent: post.body,
      initialLikes: post.likes,
      date: DateTime.now(), // dummyjson posts lack dates
      hasImage: false,
      profileImagePath: (author != null && author.image.isNotEmpty)
          ? author.image
          : 'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
    );
  }

  Widget _buildAdSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 8.h),
          child: Text(
            "Advertisement/ Promotion",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 380.h,
            enableInfiniteScroll: false,
            padEnds: false,
            viewportFraction: 0.9,
          ),
          items: carouselItems(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final textColor = isDark ? Colors.white : Colors.black;

    Widget body;
    if (_isLoading) {
      body = const Center(child: CircularProgressIndicator(color: fbPrimary));
    } else if (_error != null) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: TextStyle(color: textColor)),
            SizedBox(height: 10.h),
            TextButton(
              onPressed: _fetchPosts,
              child: const Text('Retry', style: TextStyle(color: fbPrimary)),
            ),
          ],
        ),
      );
    } else {
      List<Widget> combinedContent = [];
      for (int i = 0; i < _posts.length; i++) {
        combinedContent.add(_buildPostCard(_posts[i]));

        if (i == 0 || i == 2 || i == 4) {
          combinedContent.add(_buildAdSection(isDark));
        }
      }

      body = RefreshIndicator(
        color: fbPrimary,
        onRefresh: () => _fetchPosts(showLoader: false),
        child: ListView(children: combinedContent),
      );
    }

    return Container(
      color: isDark ? fbDarkPrimary : Colors.white,
      child: body,
    );
  }
}
