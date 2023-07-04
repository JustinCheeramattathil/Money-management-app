import 'package:flutter/material.dart';
import 'package:gowallet/drawer/widgets/about.dart';
import 'package:gowallet/drawer/widgets/privacy.dart';
import 'package:gowallet/drawer/widgets/terms.dart';
import 'package:iconly/iconly.dart';

import '../Screens/category/view/screen _category.dart';
import '../reset/reset.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/wall1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/wall1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'PollWalleT',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TermsPage(),
                  ),
                );
              },
              child: ListTile(
                title: const Text("Terms and Conditions"),
                textColor: Colors.white,
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.paper_negative,
                      color: Colors.white,
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PrivacyPage(),
                  ),
                );
              },
              child: ListTile(
                title: const Text("Privacy Policy"),
                textColor: Colors.white,
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.lock,
                      color: Colors.white,
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Screen_Category(),
                  ),
                );
              },
              child: ListTile(
                title: const Text("Categories"),
                textColor: Colors.white,
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.paper_plus,
                      color: Colors.white,
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ResetPage(),
                  ),
                );
              },
              child: ListTile(
                title: const Text("Reset"),
                textColor: Colors.white,
                leading: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      IconlyLight.arrow_left_circle,
                      color: Colors.white,
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
              child: ListTile(
                title: const Text("About"),
                textColor: Colors.white,
                leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.profile,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
                child: Text(
              'v.1.0.1',
              style: TextStyle(color: Colors.white),
            )),
          ],
        ),
      ),
    );
  }
}
