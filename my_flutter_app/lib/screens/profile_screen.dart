import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panahon_mobprog/constants.dart';
import '../widgets/custom_font.dart';
import '../widgets/custom_button.dart';
import '../widgets/post_card.dart';

const Color kFbDarkPrimary = Color(0xFF2A2F3D);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: fbDarkPrimary,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: ScreenUtil().setHeight(200),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      image: const DecorationImage(
                        image: AssetImage('assets/images/fbwallpaper.JPG'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.all(ScreenUtil().setWidth(10)),
                        padding: EdgeInsets.all(ScreenUtil().setWidth(5)),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, size: 20, color: Colors.black),
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
                          padding: EdgeInsets.all(ScreenUtil().setWidth(1)),
                          decoration: const BoxDecoration(
                            color: fbDarkPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: ScreenUtil().setWidth(50),
                            backgroundColor: Colors.grey[200],
                            backgroundImage: const AssetImage('assets/images/fbprofile.JPG'),
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
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: const Icon(Icons.camera_alt, size: 18, color: Colors.black),
                          ),
                        ),
                      ],
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
                    // Name
                    CustomFont(
                      text: 'Marius Clarence Panahon',
                      fontWeight: FontWeight.bold,
                      fontSize: ScreenUtil().setSp(24),
                      color: fbTextColorWhite,
                    ),

                    SizedBox(height: ScreenUtil().setHeight(5)),

                    Row(
                      children: [
                        CustomFont(
                          text: '11M',
                          fontSize: ScreenUtil().setSp(15),
                          color: fbTextColorWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'Followers',
                          fontSize: ScreenUtil().setSp(15),
                          color: fbTextColorWhite,
                          fontWeight: FontWeight.w100,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(15)),
                        Icon(Icons.circle, size: 5, color: fbTextColorWhite),
                        SizedBox(width: ScreenUtil().setWidth(15)),
                        CustomFont(
                          text: '1',
                          fontSize: ScreenUtil().setSp(15),
                          color: fbTextColorWhite,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: ScreenUtil().setWidth(5)),
                        CustomFont(
                          text: 'Following',
                          fontSize: ScreenUtil().setSp(15),
                          color: fbTextColorWhite,
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
                indicatorColor: fbDarkPrimary,
                labelColor: fbDarkPrimary,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(child: CustomFont(text: 'Posts', fontSize: 15, color: fbSecondary)),
                  Tab(child: CustomFont(text: 'About', fontSize: 15, color: fbSecondary)),
                  Tab(child: CustomFont(text: 'Photos', fontSize: 15, color: fbSecondary)),
                ],
              ),

              SizedBox(
                height: ScreenUtil().setHeight(1500),
                child: TabBarView(
                  children: [

                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        PostCard(
                          userName: 'Marius Clarence Panahon',
                          profileImagePath: 'assets/images/fbprofile.JPG',
                          date: DateTime.now().subtract(const Duration(hours: 2)),
                          postContent: 'anlala',
                          numOfLikes: 120,
                          hasImage: false,
                        ),

                        PostCard(
                          userName: 'Marius Clarence Panahon',
                          profileImagePath: 'assets/images/fbprofile.JPG',
                          date: DateTime.now().subtract(const Duration(days: 1)),
                          postContent: 'Bebe bebe ur my sun n moon',
                          numOfLikes: 85,
                          hasImage: true,
                          postImagePath: 'assets/images/pau.jpg',
                        ),

                        PostCard(
                          userName: 'Marius Clarence Panahon',
                          profileImagePath: 'assets/images/fbprofile.JPG',
                          date: DateTime.now().subtract(const Duration(days: 3)),
                          postContent: 'Enjoying the beautiful scenery!',
                          numOfLikes: 200,
                          hasImage: true,
                          postImagePath: 'assets/images/cat wire.jpg',
                        ),
                      ],
                    ),

                    SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomFont(
                            text: 'Details', 
                            fontSize: 18.sp, 
                            fontWeight: FontWeight.bold, 
                            color: Colors.white
                          ),
                          SizedBox(height: 15.h),

                          _buildAboutRow(Icons.school, 'Studies at', 'National University'),
                          _buildAboutRow(Icons.history_edu, 'Went to', 'Senior High School'),
                          _buildAboutRow(Icons.work, 'Works at', 'Flutter Developer'),
                          _buildAboutRow(Icons.home, 'Lives in', 'San Juan City, Philippines'),
                          _buildAboutRow(Icons.location_on, 'From', 'Manila, Philippines'),
                          _buildAboutRow(Icons.favorite, 'Taken', ''),
                          _buildAboutRow(Icons.more_horiz, 'See your about info', ''),

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
                          color: Colors.grey[300],
                          child: Image.asset('assets/images/kchain.JPG', fit: BoxFit.cover),
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
}
Widget _buildAboutRow(IconData icon, String label, String value) {
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
                style: TextStyle(fontSize: 15.sp, color: Colors.white),
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