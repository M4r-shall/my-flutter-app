import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!context.mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? fbDarkPrimary : Colors.white,
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
        backgroundColor: isDark ? fbDarkPrimary : Colors.white,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: Text(
              'Dark Mode',
              style: TextStyle(color: isDark ? Colors.white : Colors.black),
            ),
            trailing: Switch(
              value: isDark,
              activeColor: fbPrimary,
              onChanged: (val) {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
            ),
            trailing: const Icon(Icons.logout, color: Colors.redAccent),
            onTap: () => _signOut(context),
          ),
        ],
      ),
    );
  }
}
