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
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text('About',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wall1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              Text(
                'PollWalleT',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
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
                              fontSize: 18)),
                      TextSpan(
                          text:
                              ' is a money management app designed to help you track your expenses, create budgets, and achieve your financial goals. With our easy-to-use interface and powerful tools, you can take control of your finances and make informed decisions about your money.',
                          style: GoogleFonts.amiko(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12,
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
