import 'package:blog_club/data.dart';
import 'package:blog_club/gen/assets.gen.dart';
import 'package:blog_club/home.dart';
import 'package:blog_club/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final _items = AppDatabase.onBoardingItems;

  int _page = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      if (_page != _pageController.page!.round()) {
        setState(() {
          _page = _pageController.page!.round();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Assets.img.background.onboarding.image(fit: BoxFit.cover),
            ),
            Expanded(
              child: Container(
                height: 260,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 30,
                        color: MyApp.primaryColor.withOpacity(.1),
                        spreadRadius: -5),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
                            child: Column(
                              children: [
                                Text(
                                  _items[index].title,
                                  style: themeData.textTheme.headline2!
                                      .copyWith(fontSize: 26),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  _items[index].description,
                                  style:
                                      themeData.textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: _items.length,
                        controller: _pageController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: _pageController,
                            count: _items.length,
                            effect: ExpandingDotsEffect(
                              activeDotColor: MyApp.primaryColor,
                              dotColor: MyApp.primaryColor.withOpacity(.3),
                              dotWidth: 10,
                              dotHeight: 10,
                              expansionFactor: 2.5,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_page == _items.length - 1) {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => const HomeScreen(),
                                  ),
                                );
                              } else {
                                _pageController.animateToPage(_page + 1,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.decelerate);
                              }
                            },
                            style:
                                themeData.elevatedButtonTheme.style!.copyWith(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.fromLTRB(26, 16, 26, 16),
                              ),
                            ),
                            child: Icon(_page == _items.length - 1
                                ? CupertinoIcons.check_mark
                                : CupertinoIcons.arrow_right),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
