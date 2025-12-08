import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';
import '../constants.dart';

DateTime _parseDateString(String dateString) {
  try {
    return DateTime.parse('${DateTime.now().year} $dateString');
  } catch (e) {
    return DateTime.now(); 
  }
}

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  final List<Map<String, dynamic>> dummyPosts = const [
    {
      'userName': 'Marius Clarence Panahon',
      'postContent': 'New semester, new challenges. Let\'s get this TFTalks to a high grade!',
      'numOfLikes': 100,
      'date': 'September 15',
      'hasImage': false,
      'profileImagePath': 'assets/images/marius.jpg',
    },
    {
      'userName': 'Pau',
      'postContent': 'World traveling is amazing. What places should I visit next?',
      'numOfLikes': 210,
      'date': 'October 28',
      'hasImage': true,
      'profileImagePath': 'assets/images/pau.jpg',
    },
    {
      'userName': 'Shem',
      'postContent': 'Just finished a marathon coding session. Need coffee!',
      'numOfLikes': 45,
      'date': 'November 30',
      'hasImage': false,
      'profileImagePath': 'assets/images/nu.JPG',
    },
    {
      'userName': 'Mac',
      'postContent': 'Excited about the upcoming project deadline. Ready to shine!',
      'numOfLikes': 312,
      'date': 'December 5',
      'hasImage': true,
      'profileImagePath': 'assets/images/mac.JPG',
    },
    {
      'userName': 'Vergie',
      'postContent': 'Excited about the upcoming project deadline. Ready to shine!',
      'numOfLikes': 312,
      'date': 'December 5',
      'hasImage': true,
      'profileImagePath': 'assets/images/vergie.JPG',
    },
    {
      'userName': 'JB',
      'postContent': 'Excited about the upcoming project deadline. Ready to shine!',
      'numOfLikes': 312,
      'date': 'December 5',
      'hasImage': true,
      'profileImagePath': 'assets/images/cat.jpg',
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: fbDarkPrimary,
      child: ListView(
        children: dummyPosts.map((post) {
          return NewsFeedCard(
            userName: post['userName'] as String,
            postContent: post['postContent'] as String,
            numOfLikes: post['numOfLikes'] as int,
            date: _parseDateString(post['date'] as String),
            hasImage: post['hasImage'] as bool,
            profileImagePath: post['profileImagePath'] as String,
          );
        }).toList(),
      ),
    );
  }
}