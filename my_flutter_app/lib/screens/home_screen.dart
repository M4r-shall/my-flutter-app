import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../screens/newsfeed_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/profile_screen.dart';
import '../widgets/custom_font.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  // These lists are now 'late' because they depend on data passed at runtime
  late List<Widget> _screens;
  late List<String> _titles;
  late String _currentUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // 1. Retrieve arguments passed from LoginScreen
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    // 2. Extract username (use a default if null)
    _currentUser = args?['username'] ?? 'Marius Clarence Panahon';

    // 3. Initialize the screens, passing the username to ProfileScreen
    _screens = [
      const NewsfeedScreen(),
      const NotificationScreen(),
      ProfileScreen(username: _currentUser), // Passing data here
    ];

    // 4. Initialize titles, using the dynamic username for the 3rd tab
    _titles = [
      'TFTalks',
      'Notifications',
      _currentUser, // Dynamic Title
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fbDarkPrimary,
        shadowColor: fbTextColorWhite,
        elevation: 2,
        title: CustomFont(
          text: _titles[_selectedIndex], // Uses the dynamic list
          fontSize: ScreenUtil().setSp(25),
          color: fbSecondary,
          fontFamily: 'Klavika',
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (page) {
          setState(() {
            _selectedIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: fbLightPrimary,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onTappedBar,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: fbPrimary,
        unselectedItemColor: fbTextColorWhite,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      _selectedIndex = value;
    });
    _pageController.jumpToPage(value);
  }
}