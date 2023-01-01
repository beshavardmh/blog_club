import 'package:blog_club/home.dart';
import 'package:blog_club/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        CupertinoPageRoute(
          builder: (context) => HomeScreen(),
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
              MyApp.backgroundPath('splash.png'),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Image.asset(
              MyApp.iconsPath('logo.png'),
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
