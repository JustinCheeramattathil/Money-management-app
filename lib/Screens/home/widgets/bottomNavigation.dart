import 'package:flutter/material.dart';

import '../home.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HomeScreen.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.teal,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            HomeScreen.selectedIndexNotifier.value = newIndex;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.compare_arrows,
                size: 20,
              ),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 20,
              ),
              label: 'New',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category,
                size: 20,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 20,
              ),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
