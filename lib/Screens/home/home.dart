import 'package:flutter/material.dart';

import '../../home.dart';
import '../add_transaction/add_transaction.dart';
import '../category/screen%20_category.dart';
import '../settings/settings.dart';
import '../transaction/add_transaction.dart';
import 'widgets/bottomNavigation.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    HomePage(),
    Screen_Transaction(),
    AddTransaction(),
    Screen_Category(),
    SettingsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 218, 218),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (selectedIndexNotifier.value == 0) {
      //       print('Add transaction');
      //     } else {
      //       print('Add category');

      //       showCategoryAddPopup(context);
      //       // final _sample = CategoryModel(
      //       //   id: DateTime.now().microsecondsSinceEpoch.toString(),
      //       //   name: 'Travel',
      //       //   type: CategoryType.expense,
      //       // );

      //       // CategoryDB().insertCategory(_sample);
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
