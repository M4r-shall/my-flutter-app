import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../constants.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_button.dart';
import '../widgets/post_card.dart';
import '../services/post_service.dart';
import '../models/post.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username;

  const ProfileScreen({
    super.key, 
    required this.username
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String coverImageUrl = "https://images.unsplash.com/photo-1579546929518-9e396f3cc809?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80";
  String profileImageUrl = "https://images.unsplash.com/photo-1527980965255-d3b416303d12?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80";
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId');
      final image = prefs.getString('image');
      if (image != null && image.isNotEmpty) {
        profileImageUrl = image;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: isDark ? fbDarkPrimary : Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [
                  // --- ENHANCEMENT 3: COVER PHOTO WITH LOADING ---
                  Container(
                    height: ScreenUtil().setHeight(200),
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: coverImageUrl,
                      fit: BoxFit.cover,
                      // Matches the thin loading style of your Photos Tab
                      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          strokeWidth: 2, 
                          color: fbPrimary,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[800],
                        child: const Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -ScreenUtil().setHeight(40),
                    left: ScreenUtil().setWidth(20),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(4)),
                          decoration: BoxDecoration(
                            color: isDark ? fbDarkPrimary : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          // --- ENHANCEMENT 3: PROFILE PHOTO WITH LOADING ---
                          child: CircleAvatar(
                            radius: ScreenUtil().setWidth(50),
                            backgroundColor: Colors.grey[800],
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: profileImageUrl,
                                width: ScreenUtil().setWidth(100),
                                height: ScreenUtil().setWidth(100),
                                fit: BoxFit.cover,
                                // Matches the thin loading style of your Photos Tab
                                progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    strokeWidth: 2,
                                    color: fbPrimary,
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: ScreenUtil().setHeight(40),
                    right: ScreenUtil().setWidth(10),
                    child: IconButton(
                      icon: const Icon(Icons.settings, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: ScreenUtil().setHeight(55)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFont(
                      text: widget.username, 
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(24),
                      color: isDark ? fbTextColorWhite : Colors.black,
                    ),

                    SizedBox(height: ScreenUtil().setHeight(5)),

                    Row(
                      children: [
                        CustomFont(
                          text: '11M',
                          fontSize: ScreenUtil().setSp(15),
                          color: isDark ? fbTextColorWhite : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'Followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: isDark ? fbTextColorWhite : Colors.black,
                          fontWeight: FontWeight.w100,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(15)),
                        Icon(Icons.circle, size: 5, color: isDark ? fbTextColorWhite : Colors.black),
                        SizedBox(width: ScreenUtil().setWidth(15)),
                        CustomFont(
                          text: '1',
                          fontSize: ScreenUtil().setSp(15),
                          color: isDark ? fbTextColorWhite : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'Following',
                          fontSize: ScreenUtil().setSp(15),
                          color: isDark ? fbTextColorWhite : Colors.black,
                          fontWeight: FontWeight.w100,
                        ),
                      ],
                    ),

                    SizedBox(height: ScreenUtil().setHeight(15)),

                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            buttonName: 'Follow',
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: ScreenUtil().setWidth(10)),
                        Expanded(
                          child: CustomButton(
                            buttonName: 'Message',
                            onPressed: () {},
                            buttonType: 'outlined',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: ScreenUtil().setHeight(10)),

              TabBar(
                indicatorColor: fbPrimary,
                labelColor: fbPrimary,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(child: CustomFont(text: 'Posts', fontSize: 15.sp, color: isDark ? fbTextColorWhite : Colors.black)),
                  Tab(child: CustomFont(text: 'About', fontSize: 15.sp, color: isDark ? fbTextColorWhite : Colors.black)),
                  Tab(child: CustomFont(text: 'Photos', fontSize: 15.sp, color: isDark ? fbTextColorWhite : Colors.black)),
                ],
              ),

              SizedBox(
                height: ScreenUtil().setHeight(1500),
                child: TabBarView(
                  children: [
                    // --- TAB 1: POSTS ---
                    userId == null 
                    ? const Center(child: CircularProgressIndicator())
                    : FutureBuilder<List<Post>>(
                        future: PostService().getPostsByUser(userId!),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator(color: fbPrimary));
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Error loading posts', style: TextStyle(color: Colors.white)));
                          }
                          final posts = snapshot.data ?? [];
                          if (posts.isEmpty) {
                            return const Center(child: Text('No posts available', style: TextStyle(color: Colors.white)));
                          }
                          
                          return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              final post = posts[index];
                              return PostCard(
                                postId: post.id,
                                userName: widget.username,
                                profileImagePath: profileImageUrl,
                                date: DateTime.now(), // dummyjson posts lack dates
                                postContent: post.body,
                                initialLikes: post.likes,
                                hasImage: false,
                              );
                            },
                          );
                        },
                      ),

                    // --- TAB 2: ABOUT ---
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFont(
                            text: 'Details', 
                            fontSize: 18.sp, 
                            fontWeight: FontWeight.bold, 
                            color: isDark ? Colors.white : Colors.black
                          ),
                          SizedBox(height: 15.h),

                          _buildAboutRow(Icons.school, 'Studies at', 'National University', isDark),
                          _buildAboutRow(Icons.history_edu, 'Went to', 'Senior High School', isDark),
                          _buildAboutRow(Icons.work, 'Works at', 'Flutter Developer', isDark),
                          _buildAboutRow(Icons.home, 'Lives in', 'San Juan City, Philippines', isDark),
                          _buildAboutRow(Icons.location_on, 'From', 'Manila, Philippines', isDark),
                          _buildAboutRow(Icons.favorite, 'Taken', '', isDark),
                          _buildAboutRow(Icons.more_horiz, 'See your about info', '', isDark),

                          SizedBox(height: 20.h),
                          
                          SizedBox(
                            width: double.infinity,
                            child: CustomButton(
                              buttonName: 'Edit public details',
                              onPressed: () {},
                              buttonType: 'outlined',
                              outlineColor: fbPrimary, 
                              fontColor: fbPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // --- TAB 3: PHOTOS ---
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Container(
                          color: Colors.grey[800],
                          child: CachedNetworkImage(
                            imageUrl: 'https://images.unsplash.com/photo-150${index}525428034-b723cf961d3e?ixlib=rb-1.2.1&auto=format&fit=crop&w=300&q=80',
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(strokeWidth: 2)
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutRow(IconData icon, String label, String value, bool isDark) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[400], size: 24.sp),
          SizedBox(width: 15.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 15.sp, color: isDark ? Colors.white : Colors.black),
                children: [
                  TextSpan(text: '$label '),
                  TextSpan(
                    text: value, 
                    style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}