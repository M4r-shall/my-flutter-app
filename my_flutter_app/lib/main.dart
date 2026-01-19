import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:panahon_mobprog/screens/detail_screen.dart';
import 'package:panahon_mobprog/screens/home_screen.dart';
import 'package:panahon_mobprog/screens/login_screen.dart';
import 'package:panahon_mobprog/screens/register_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

 @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 715),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TFTalks',
          initialRoute: '/login',
          routes: {
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LogInScreen(),
            '/register': (context) => const RegisterScreen(),
            // REMOVE the static '/detail' route from here
          },
          // Add onGenerateRoute to handle dynamic data for DetailScreen
          onGenerateRoute: (settings) {
            if (settings.name == '/detail') {
              final args = settings.arguments as Map<String, dynamic>;

              return MaterialPageRoute(
                builder: (context) {
                  return DetailScreen(
                    userName: args['userName'],
                    postContent: args['postContent'],
                    date: args['date'],
                    profileImagePath: args['profileImagePath'],
                    numOfLikes: args['numOfLikes'] ?? 0,
                    hasImage: args['hasImage'] ?? false,
                    postImagePath: args['postImagePath'],
                  );
                },
              );
            }
            return null;
          },
        );
      },
    ); 
  }
}
