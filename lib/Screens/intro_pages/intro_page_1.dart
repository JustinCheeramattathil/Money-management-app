import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 380,
            width: 450,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.yellow, Colors.white]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50))),
            child: Container(
              child: Lottie.asset('images/pig.json'),
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Simple solution for your Budget',
                style: GoogleFonts.robotoMono(
                    fontSize: 26, fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child:
                Text('Manages the income and expense and make a healty Budget'),
          ))
        ],
      ),
    );
  }
}
