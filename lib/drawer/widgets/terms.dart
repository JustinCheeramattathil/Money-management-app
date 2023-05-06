import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.yellow[300],
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
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
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                    'Welcome to our money management application. These terms and conditions govern your use of our application. By using our application, you agree to these terms and conditions. If you do not agree to these terms and conditions, you may not use our application.',
                    style: GoogleFonts.amiko(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                    'To use our application, you must create an account. You agree to provide accurate and complete information when creating your account. You are responsible for maintaining the security of your account and password. You agree to notify us immediately if you suspect any unauthorized use of your account.',
                    style: GoogleFonts.amiko(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                    'You are solely responsible for any content that you upload or post on our application. You agree that you will not post any content that is unlawful, defamatory, harassing, or otherwise objectionable. We reserve the right to remove any content that violates these terms and conditions.',
                    style: GoogleFonts.amiko(fontSize: 12)),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                    'Our application is intended for personal use only. You may not use our application for any commercial purpose or in a way that violates any laws or regulations.',
                    style: GoogleFonts.amiko(fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
