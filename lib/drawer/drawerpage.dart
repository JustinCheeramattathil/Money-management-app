import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../Screens/category/screen%20_category.dart';
import '../reset/reset.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.yellow[300],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                'GOWalleT',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("Terms and Conditions"),
              textColor: Colors.black,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.paper_negative,
                    color: Colors.black,
                  )),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("Privacy and Policy"),
              textColor: Colors.black,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.lock,
                    color: Colors.black,
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
              textColor: Colors.black,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.paper_plus,
                    color: Colors.black,
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
              textColor: Colors.black,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.arrow_left_circle,
                    color: Colors.black,
                  )),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: const Text("About"),
              textColor: Colors.black,
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  IconlyLight.profile,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
