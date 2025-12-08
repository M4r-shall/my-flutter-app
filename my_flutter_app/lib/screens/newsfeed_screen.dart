import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';
import '../constants.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  final List<Map<String, dynamic>> dummyPosts = const [
    {
      'userName': 'Marius Panahon',
      'postContent': 'New semester, new challenges. Let\'s get this TFTalks to a high grade!',
      'numOfLikes': 100,
      'date': 'September 15',
      'hasImage': false,
    },
    {
      'userName': 'Pau Pau',
      'postContent': 'World traveling is amazing. What places should I visit next?',
      'numOfLikes': 210,
      'date': 'October 28',
      'hasImage': true,
    },
    {
      'userName': 'Cyrus Robles',
      'postContent': 'Just finished a marathon coding session. Need coffee!',
      'numOfLikes': 45,
      'date': 'November 30',
      'hasImage': false,
    },
    {
      'userName': 'Roben Juanatas',
      'postContent': 'Excited about the upcoming project deadline. Ready to shine!',
      'numOfLikes': 312,
      'date': 'December 5',
      'hasImage': true,
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
            date: post['date'] as String,
            hasImage: post['hasImage'] as bool,
          );
        }).toList(),
      ),
    );
  }
}