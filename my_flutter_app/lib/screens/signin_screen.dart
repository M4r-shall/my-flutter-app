import '../widgets/custom_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants.dart';
import '../widgets/custom_inkwell_button.dart';
import '../services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      setState(() => _isLoading = true);
      try {
        final user = await UserService().login(
          usernameController.text, 
          passwordController.text
        );
        
        if (user != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', user.token ?? '');
          await prefs.setInt('userId', user.id);
          await prefs.setString('username', user.username);
          await prefs.setString('firstName', user.firstName);
          await prefs.setString('lastName', user.lastName);
          await prefs.setString('image', user.image);
          
          if (!mounted) return;
          Navigator.pushReplacementNamed(
            context, 
            '/home',
            arguments: {
              'username': user.username
            }
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Check your credentials.')),
        );
      } finally {
        if (mounted) setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: ScreenUtil().screenHeight,
          width: ScreenUtil().screenWidth,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(40),
                  color: fbDarkPrimary,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(25),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/NUCCITLogo_Black.png',
                        height: ScreenUtil().setHeight(200),
                      ),
                      SizedBox(height: ScreenUtil().setHeight(30)),
                      CustomTextFormField(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(10),
                        controller: usernameController,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your username' : null,
                        onSaved: (value) {}, 
                        fontSize: ScreenUtil().setSp(15),
                        fontColor: fbDarkPrimary,
                        hintTextSize: ScreenUtil().setSp(15),
                        hintText: 'Username',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(10)),
                      CustomTextFormField(
                        height: ScreenUtil().setHeight(10),
                        width: ScreenUtil().setWidth(10),
                        controller: passwordController,
                        isObscure: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Enter your password' : null,
                        onSaved: (value) {},
                        fontSize: ScreenUtil().setSp(15),
                        fontColor: fbDarkPrimary,
                        hintTextSize: ScreenUtil().setSp(15),
                        hintText: 'Password',
                      ),
                      SizedBox(height: ScreenUtil().setHeight(50)),
                      
                      _isLoading
                          ? const Center(child: CircularProgressIndicator(color: fbPrimary))
                          : CustomInkwellButton(
                              onTap: _handleLogin,
                              height: ScreenUtil().setHeight(40),
                              width: ScreenUtil().screenWidth,
                              buttonName: 'Login',
                              fontSize: ScreenUtil().setSp(15),
                            ),
                    ],
                  ),
                ),
                Container(
                  width: ScreenUtil().screenWidth,
                  height: ScreenUtil().setHeight(40),
                  color: fbDarkPrimary,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'You do not have an account? ',
                        style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: ScreenUtil().setSp(15)),
                      ),
                      // Removed Register tap logic since register_screen is deleted
                      Text(
                        '',
                        style: TextStyle(
                          color: fbLightPrimary,
                          fontSize: ScreenUtil().setSp(15),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}