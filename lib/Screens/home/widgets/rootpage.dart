import 'package:flutter/material.dart';

import '../home.dart';
import '../../Statistics/Statistics.dart';
import '../../transaction/view_transaction/list_transaction.dart';
import 'bottomNavigation.dart';

class RootPage extends StatelessWidget {
  RootPage({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    HomePage(),
    Screen_Transaction(),
    Statistics_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedIndex, _) {
                return _pages[updatedIndex];
              })),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
