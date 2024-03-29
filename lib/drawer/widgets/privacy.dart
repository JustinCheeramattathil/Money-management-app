import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 20, 8, 5),
        elevation: 0,
        title: Text('Privacy Policy',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'Our money manager app values your privacy and is committed to protecting your personal information. We only collect information that is necessary to provide you with the best possible service. We do not sell or share your information with third parties. Your data is secured using industry-standard measures. If you have any questions or concerns about your privacy, please contact us.',
                  style: GoogleFonts.amiko(
                      color: Color.fromARGB(255, 20, 8, 5), fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'We collect information that you provide to us when you use the App, such as your name, email address, and financial account information. We may also collect information about your transactions, spending habits, and budgeting goals.',
                  style: GoogleFonts.amiko(
                      color: Color.fromARGB(255, 20, 8, 5), fontSize: 12)),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                  'We use the information we collect to provide you with the services and features of the App, such as helping you track your expenses and manage your budget. We may also use your information to communicate with you about the App and to send you promotional offers and updates.',
                  style: GoogleFonts.amiko(
                      color: Color.fromARGB(255, 20, 8, 5), fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
