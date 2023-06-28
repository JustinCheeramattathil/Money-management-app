import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home/widgets/rootpage.dart';
import 'intro_page_1.dart';
import 'intro_page_2.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 1);
            });
          },
          children: [
            Intro1(),
            Intro2(),
          ],
        ),
        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      _controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Text('Skip')),
                SmoothPageIndicator(controller: _controller, count: 2),
                onLastPage
                    ? GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool('check', true);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return RootPage();
                          }
                          ));
                        },
                        child: Text('Done'))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next')),
              ],
            )),
      ],
    ));
  }
}
