import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gowallet/Screens/home/widgets/rootpage.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Welcome to our money management application. These terms and conditions govern your use of our application. By using our application, you agree to these terms and conditions. If you do not agree to these terms and conditions, you may not use our application.',
                style: GoogleFonts.amiko(fontSize: 12, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'To use our application, you must create an account. You agree to provide accurate and complete information when creating your account. You are responsible for maintaining the security of your account and password. You agree to notify us immediately if you suspect any unauthorized use of your account.',
                  style: GoogleFonts.amiko(fontSize: 12, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'You are solely responsible for any content that you upload or post on our application. You agree that you will not post any content that is unlawful, defamatory, harassing, or otherwise objectionable. We reserve the right to remove any content that violates these terms and conditions.',
                  style: GoogleFonts.amiko(fontSize: 12, color: Colors.white)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'Our application is intended for personal use only. You may not use our application for any commercial purpose or in a way that violates any laws or regulations.',
                  style: GoogleFonts.amiko(fontSize: 12, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
