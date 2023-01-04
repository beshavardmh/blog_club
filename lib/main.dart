import 'package:blog_club/data.dart';
import 'package:blog_club/spash.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const EdgeInsets rowPadding = EdgeInsets.fromLTRB(32, 16, 32, 0);
  static const defaultFontFamily = 'Avenir';
  static const primaryColor = Color(0xff376AED);
  static const primaryTextColor = Color(0xff0D253C);
  static const secondaryTextColor = Color(0xff2D4379);
  static String iconsPath(String file) => 'assets/img/icons/$file';
  static String postsPath(String file) => 'assets/img/posts/$file';
  static String storiesPath(String file) => 'assets/img/stories/$file';
  static String backgroundPath(String file) => 'assets/img/background/$file';
  static List<Story> stories = AppDatabase.stories;
  static List<Category> categories = AppDatabase.categories;
  static List<PostData> posts = AppDatabase.posts;
  static BorderRadius primaryRadius = BorderRadius.circular(25);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        brightness: Brightness.light,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          onPrimary: Colors.white,
          onSurface: primaryTextColor,
          background: Color(0xffFBFCFF),
          surface: Colors.white,
          onBackground: primaryTextColor,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                color: primaryColor,
                fontFamily: defaultFontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            height: 1.6,
          ),
          subtitle1: TextStyle(
            fontFamily: defaultFontFamily,
            color: secondaryTextColor,
            fontSize: 18,
          ),
          headline2: TextStyle(
            fontFamily: defaultFontFamily,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
          ),
          headline6: TextStyle(
            fontFamily: defaultFontFamily,
            fontWeight: FontWeight.bold,
            color: primaryTextColor,
            fontSize: 24,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
