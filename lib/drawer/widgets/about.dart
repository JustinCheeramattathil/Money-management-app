import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: Text('About',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.yellow[300],
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 2,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(60),
              gradient: LinearGradient(colors: [Colors.yellow, Colors.white])),
          child: Column(
            children: [
              Text(
                'PollWalleT',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
              SizedBox(height: 20),
              // Text(
              //     'PollWalleT is a money management app designed to help you track your expenses, create budgets, and achieve your financial goals. With our easy-to-use interface and powerful tools, you can take control of your finances and make informed decisions about your money.',
              //     style: GoogleFonts.amiko()),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'PollWalleT',
                          style: GoogleFonts.amiko(
                              // fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 20)),
                      TextSpan(
                          text:
                              ' is a money management app designed to help you track your expenses, create budgets, and achieve your financial goals. With our easy-to-use interface and powerful tools, you can take control of your finances and make informed decisions about your money.',
                          style: GoogleFonts.amiko(
                            // fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 16,
                          )),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  '-Created by Justin Thomas',
                  style: GoogleFonts.amiko(fontSize: 15, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'images/facebook.png',
                      height: 40,
                      width: 40,
                    ),
                    Image.asset(
                      'images/ins.png',
                      height: 40,
                      width: 40,
                    ),
                    Image.asset(
                      'images/google.png',
                      height: 40,
                      width: 40,
                    ),
                    Image.asset(
                      'images/twitter.png',
                      height: 40,
                      width: 40,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
