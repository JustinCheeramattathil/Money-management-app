import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../intro_pages/onboardingscreen.dart';
import '../home/widgets/rootpage.dart';

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
            child: Lottie.asset('images/loading3.json'),
            height: 300,
            width: 300,
          ),
        ),
      ),
    );
  }


  Future<void> goToHome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool a = prefs.getBool('check') ?? false;
    log(a.toString());
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => a ? RootPage() : const OnBoardingScreen()));
  }
}
