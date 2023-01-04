import 'package:blog_club/gen/assets.gen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'carousel/carousel_slider.dart';
import 'data.dart';
import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                      Assets.img.icons.notification.path,
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
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                color: MyApp.primaryColor,
              ),
              foregroundDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
                gradient: const LinearGradient(
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
                  MyApp.postsPath('large/${category.imageFileName}'),
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
          physics: const BouncingScrollPhysics(),
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
      margin: const EdgeInsets.fromLTRB(0, 0, 8, 0),
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
          const SizedBox(height: 5),
          Text(story.name),
        ],
      ),
    );
  }

  Container normalStory() {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
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
        margin: const EdgeInsets.all(2.5),
        padding: const EdgeInsets.all(5),
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
      margin: const EdgeInsets.all(1),
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeWidth: 2,
        color: MyApp.primaryColor,
        dashPattern: const [6, 3],
        radius: const Radius.circular(24),
        child: Container(
          margin: const EdgeInsets.all(2.5),
          padding: const EdgeInsets.all(2),
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
                  child: const Text(
                    'More',
                    style: TextStyle(color: MyApp.primaryColor),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
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

  const _Post({required this.post});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(
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
            color: const Color(0xff5282FF).withOpacity(.6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                MyApp.postsPath('small/${post.imageFileName}'),
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
                  const SizedBox(height: 10),
                  Text(
                    post.title,
                    style: themeData.textTheme.subtitle1!.copyWith(
                      color: MyApp.primaryTextColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.hand_thumbsup,
                            size: 15,
                            color: MyApp.secondaryTextColor,
                          ),
                          const SizedBox(width: 3),
                          Text(post.likes),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            CupertinoIcons.clock,
                            size: 15,
                            color: MyApp.secondaryTextColor,
                          ),
                          const SizedBox(width: 3),
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
