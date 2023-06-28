import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(
            begin: Alignment.topLeft,
            // end: Alignment.bottomRight,
            colors: [Colors.yellow, Colors.white])),
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 160, left: 40, right: 40),
                child: Container(
                  height: 250,
                  width: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    // color: Colors.amber,
                  ),
                  child: Lottie.asset('images/money2.json'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Money won't create success,",
              style: GoogleFonts.italianno(fontSize: 30),
            ),
            Text(
              "the freedom to make it will",
              style: GoogleFonts.italianno(fontSize: 30),
            ),
            Text(
              '-Nelson Mandela',
              style: GoogleFonts.italianno(fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
