import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Delay for a short time to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final String? username = prefs.getString('username');

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(
        context, 
        '/home',
        arguments: {'username': username ?? 'User'},
      );
    } else {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? fbDarkPrimary : Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isDark ? 'assets/images/NUCCITLogo_White.png' : 'assets/images/NUCCITLogo_Black.png',
              height: ScreenUtil().setHeight(150),
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.computer,
                size: 150,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: ScreenUtil().setHeight(20)),
            const CircularProgressIndicator(
              color: fbPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
