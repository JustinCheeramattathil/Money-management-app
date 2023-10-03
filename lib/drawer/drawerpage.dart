import 'package:flutter/material.dart';
import 'package:gowallet/Account/balance.dart';
import 'package:gowallet/Screens/splash/splash.dart';
import 'package:gowallet/drawer/widgets/about.dart';
import 'package:gowallet/drawer/widgets/privacy.dart';
import 'package:gowallet/drawer/widgets/terms.dart';
import 'package:gowallet/models/category/category_model.dart';
import 'package:gowallet/models/transaction/transaction_model.dart';
import 'package:hive/hive.dart';
import 'package:iconly/iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/category/view/screen _category.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 20, 8, 5)),
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PrivacyPage(),
                ),
              );
            },
            child: ListTile(
              title: const Text("Privacy Policy"),
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
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Delete'),
                      content:
                          Text('Are you sure?Do you want to reset entire data'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel')),
                        TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.clear();
                              SharedPreferences tectcontrol =
                                  await SharedPreferences.getInstance();
                              await tectcontrol.clear();
                              final transationDb =
                                  await Hive.openBox<TransactionModel>(
                                      'transactio-db');
                              final categorydb =
                                  await Hive.openBox<CategoryModel>(
                                      'category_database');

                              categorydb.clear();
                              transationDb.clear();
                              incomeNotifier = ValueNotifier(0);
                              expenseNotifier = ValueNotifier(0);
                              totalNotifier = ValueNotifier(0);

                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const Splash(),
                              ));
                            },
                            child: Text('Ok'))
                      ],
                    );
                  });
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
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AboutPage(),
                ),
              );
            },
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
          SizedBox(
            height: 100,
          ),
          Center(
              child: Text(
            'v.1.0.1',
            style: TextStyle(color: Colors.black),
          )),
        ],
      ),
    );
  }
}
