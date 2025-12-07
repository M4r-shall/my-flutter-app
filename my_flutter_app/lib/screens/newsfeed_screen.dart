import 'package:flutter/material.dart';
import '../widgets/newsfeed_card.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        NewsFeedCard(
          userName: 'Marius Panahon',
          postContent: 'hello',
          numOfLikes: 100,
          date: 'November 3',
        ),
        NewsFeedCard(
          userName: 'Pau Pau',
          postContent: 'world ',
          numOfLikes: 210,
          hasImage: true,
          date: 'November 11',
        ),
      ],
    );
  }
}