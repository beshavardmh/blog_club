import 'package:blog_club/carousel/carousel_slider.dart';
import 'package:blog_club/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
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
  static String iconsPath(String file) => 'assets/img/icons/${file}';
  static String postsPath(String file) => 'assets/img/posts/${file}';
  static String storiesPath(String file) => 'assets/img/stories/${file}';
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
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
              TextStyle(
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
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MyApp.rowPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi, Jonathan!',
                      style: themeData.textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Image.asset(
                      MyApp.iconsPath('notification.png'),
                      width: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: MyApp.rowPadding.copyWith(top: 10),
                child: Text(
                  'Explore today’s',
                  style: themeData.textTheme.headline6,
                ),
              ),
              const _StoryList(),
              const _CategoryList(),
              _PostList(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = MyApp.categories;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 16, 0, 16),
      child: CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realIndex) {
          final category = categories[realIndex];
          return _CategoryItem(
            category: category,
            left: 24,
            right: realIndex == categories.length - 1 ? 32 : 0,
          );
        },
        options: CarouselOptions(
          scrollDirection: Axis.horizontal,
          viewportFraction: .8,
          aspectRatio: 1.1,
          initialPage: 0,
          scrollPhysics: const BouncingScrollPhysics(),
          disableCenter: true,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          padEnds: false,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({
    Key? key,
    required this.category,
    required this.left,
    required this.right,
  }) : super(key: key);

  final Category category;
  final double left, right;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
            top: 50,
            right: 40,
            left: 40,
            bottom: 35,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade600,
                    blurRadius: 25,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: MyApp.primaryColor,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff0D253C),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  MyApp.postsPath('large/' + category.imageFileName),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 75,
            left: 32,
            right: 32,
            child: Text(
              category.title,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .apply(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyApp.rowPadding,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 110,
        child: ListView.builder(
          itemCount: MyApp.stories.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            final story = MyApp.stories[index];

            return _Story(story: story);
          },
        ),
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    Key? key,
    required this.story,
  }) : super(key: key);

  final Story story;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
      child: Column(
        children: [
          Stack(
            children: [
              !story.isViewed ? normalStory() : viewedStory(),
              Positioned(
                bottom: 0,
                right: 0,
                width: 30,
                child: Image.asset(
                  MyApp.iconsPath(story.iconFileName),
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Text(story.name),
        ],
      ),
    );
  }

  Container normalStory() {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ],
        ),
        borderRadius: MyApp.primaryRadius,
      ),
      child: Container(
        margin: EdgeInsets.all(2.5),
        padding: EdgeInsets.all(5),
        // color: Color(0xffffffff),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            MyApp.storiesPath(story.imageFileName),
          ),
        ),
      ),
    );
  }

  Widget viewedStory() {
    return Container(
      width: 70,
      height: 70,
      margin: EdgeInsets.all(1),
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: MyApp.primaryColor,
        dashPattern: [6, 3],
        radius: Radius.circular(24),
        child: Container(
          margin: EdgeInsets.all(2.5),
          padding: EdgeInsets.all(2),
          // color: Color(0xffffffff),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              MyApp.storiesPath(story.imageFileName),
            ),
          ),
        ),
      ),
    );
  }
}

class _PostList extends StatelessWidget {
  final posts = MyApp.posts;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      transform: Matrix4.translationValues(0, -40, 0),
      child: Padding(
        padding: MyApp.rowPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Latest News',
                  style: themeData.textTheme.headline2,
                ),
                TextButton(
                  child: Text(
                    'More',
                    style: TextStyle(color: MyApp.primaryColor),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            SizedBox(height: 16),
            getPosts(),
          ],
        ),
      ),
    );
  }

  Widget getPosts() {
    return Column(
      children: [for (var post in posts) _Post(post: post)],
    );
  }
}

class _Post extends StatelessWidget {
  final PostData post;

  const _Post({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      margin: EdgeInsets.only(
        bottom: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            blurRadius: 15,
            offset: const Offset(0, 5),
            spreadRadius: -10,
            color: Color(0xff5282FF).withOpacity(.6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                MyApp.postsPath('small/' + post.imageFileName),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.caption,
                    style: themeData.textTheme.subtitle1!.copyWith(
                      color: MyApp.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    post.title,
                    style: themeData.textTheme.subtitle1!.copyWith(
                      color: MyApp.primaryTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.hand_thumbsup,
                            size: 15,
                            color: MyApp.secondaryTextColor,
                          ),
                          SizedBox(width: 3),
                          Text(post.likes),
                        ],
                      ),
                      SizedBox(width: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            CupertinoIcons.clock,
                            size: 15,
                            color: MyApp.secondaryTextColor,
                          ),
                          SizedBox(width: 3),
                          Text(post.time),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
