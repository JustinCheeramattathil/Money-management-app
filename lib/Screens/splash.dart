import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../onboardingscreen.dart';

class Splash extends StatefulWidget {
  const Splash({
    super.key,
  });

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    goToHome();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Center(
          child: Container(
            child: Lottie.asset('images/lottie1.json'),
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }

  Future<void> goToHome() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }
}
