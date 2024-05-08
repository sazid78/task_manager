import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/controller/auth_controller.dart';
import 'package:task_manager/presentation/UI/Screens/authentication/login_screen.dart';
import 'package:task_manager/presentation/UI/Screens/main_bottom_nav_screen.dart';
import 'package:task_manager/presentation/UI/Widgets/body_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToLogin();
  }

  Future<void> goToLogin() async{
    final bool isLoggedIn = await AuthController.checkAuthState();

    Future.delayed(const Duration(seconds: 4)).then(
          (value) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>  isLoggedIn ? const MainBottomNavScreen() : const LoginScreen(),
          ),
              (route) => false),
    );
  }
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: BodyBackground(child: Center(
        child: Center(
          child: SvgPicture.asset(
            'assets/images/logo.svg',
            width: 120,
          ),
        ),
      ))
    );
  }
}
