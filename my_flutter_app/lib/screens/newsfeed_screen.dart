import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../widgets/post_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  DateTime _parseDateString(String dateString) {
    try {
      DateTime parsedDate = DateFormat('MMMM d').parse(dateString);
      return DateTime(DateTime.now().year, parsedDate.month, parsedDate.day);
    } catch (e) {
      return DateTime.now();
    }
  }

  // --- 5-7 AD ITEMS (Using Network Images) ---
  List<Widget> carouselItems() {
    return [
      PostCard(
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
        userName: "VetCare Plus",
        postContent: "Free checkup for new puppies this weekend.",
        date: DateTime.now(),
        addMarket: "SERVICE",
        hasImage: true,
        postImagePath:
            "https://images.unsplash.com/photo-1628009368231-760335298025?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80",
        profileImagePath:
            "https://cdn-icons-png.flaticon.com/512/3135/3135715.png",
      ),
      PostCard(
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

  List<PostCard> _getRegularPosts() {
    return [
      PostCard(
        userName: 'Marius Clarence Panahon',
        postContent:
            'New semester, new challenges. Let\'s get this TFTalks to a high grade!',
        initialLikes: 100,
        date: _parseDateString('September 15'),
        hasImage: false,
        profileImagePath: 'assets/images/cat mouth.jpg',
      ),
      PostCard(
        userName: 'Pau',
        postContent:
            'World traveling is amazing. What places should I visit next?',
        initialLikes: 210,
        date: _parseDateString('October 28'),
        hasImage: true,
        postImagePath:
            'assets/images/cat pixel.jpg',
        profileImagePath: 'assets/images/cat pixel.jpg',
      ),
      PostCard(
        userName: 'Shem',
        postContent: 'Just finished a marathon coding session. Need coffee!',
        initialLikes: 45,
        date: _parseDateString('November 30'),
        hasImage: false,
        profileImagePath: 'assets/images/cat santa.jpg',
      ),
      PostCard(
        userName: 'Mac',
        postContent:
            'Excited about the upcoming project deadline. Ready to shine!',
        initialLikes: 312,
        date: _parseDateString('December 5'),
        hasImage: true,
        postImagePath: 'assets/images/cat shh.jpg',
        profileImagePath: 'assets/images/cat shh.jpg',
      ),
      PostCard(
        userName: 'Vergie',
        postContent:
            'Debugging code is like being a detective in a crime movie where you are also the murderer.',
        initialLikes: 88,
        date: _parseDateString('December 5'),
        hasImage: true,
        postImagePath: 'assets/images/cat wire.jpg',
        profileImagePath: 'assets/images/cat wire.jpg',
      ),
      PostCard(
        userName: 'JB',
        postContent: 'Anyone want to play Valorant later?',
        initialLikes: 12,
        date: _parseDateString('December 5'),
        hasImage: true,
        postImagePath: 'assets/images/cat.jpg',
        profileImagePath: 'assets/images/cat.jpg',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<PostCard> newsCards = _getRegularPosts();
    List<Widget> combinedContent = [];

    for (int i = 0; i < newsCards.length; i++) {
      combinedContent.add(newsCards[i]);

      // Alternating Ads logic
      if (i == 0 || i == 2 || i == 4) {
        combinedContent.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 8.h),
                child: Text(
                  "Advertisement/ Promotion",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
          ),
        );
      }
    }

    return Container(
      color: fbDarkPrimary,
      child: ListView(children: combinedContent),
    );
  }
}
