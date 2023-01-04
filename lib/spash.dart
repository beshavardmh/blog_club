import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => const OnBoardingScreen(),
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              Assets.img.background.splash.path,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              Assets.img.icons.logo.path,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
