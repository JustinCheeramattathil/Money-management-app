import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Account/balance.dart';
import '../Screens/splash.dart';
import '../models/category/category_model.dart';
import '../models/transaction/transaction_model.dart';

class ResetPage extends StatelessWidget {
  const ResetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.yellow[300],
          title: Text('Reset',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: Colors.black)),
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.yellow[300],
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient:
                    LinearGradient(colors: [Colors.yellow, Colors.white])),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 120,
                    width: 120,
                    child: Lottie.asset('images/reset.json')),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30)),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'))),
                    Container(
                        child: ElevatedButton(
                            onPressed: () async {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Delete'),
                                      content: Text(
                                          'Are you sure?Do you want to reset entire data'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel')),
                                        TextButton(
                                            onPressed: () async {
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await prefs.clear();
                                              SharedPreferences tectcontrol =
                                                  await SharedPreferences
                                                      .getInstance();
                                              await tectcontrol.clear();
                                              final transationDb = await Hive
                                                  .openBox<TransactionModel>(
                                                      'transactio-db');
                                              final categorydb = await Hive
                                                  .openBox<CategoryModel>(
                                                      'category_database');

                                              categorydb.clear();
                                              transationDb.clear();
                                              incomeNotifier = ValueNotifier(0);
                                              expenseNotifier =
                                                  ValueNotifier(0);
                                              totalNotifier = ValueNotifier(0);

                                              Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                builder: (context) =>
                                                    const Splash(),
                                              ));
                                            },
                                            child: Text('Ok'))
                                      ],
                                    );
                                  });
                            },
                            child: Text('Reset')))
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
