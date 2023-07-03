import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'rootpage.dart';

// class BottomNavigation extends StatelessWidget {
//   const BottomNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: RootPage.selectedIndexNotifier,
//       builder: (BuildContext ctx, int updatedIndex, Widget? _) {
//         return BottomNavigationBar(
//           backgroundColor: Colors.yellow,
//           unselectedItemColor: Colors.grey,
//           showSelectedLabels: true,
//           showUnselectedLabels: true,
//           selectedItemColor: Colors.teal,
//           currentIndex: updatedIndex,
//           onTap: (newIndex) {
//             RootPage.selectedIndexNotifier.value = newIndex;
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(
//                 IconlyLight.home,
//                 size: 20,
//               ),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 IconlyLight.category,
//                 size: 20,
//               ),
//               label: 'Transactions',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 IconlyLight.graph,
//                 size: 20,
//               ),
//               label: 'Statistics',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: RootPage.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
          color: Colors.teal,
          backgroundColor: Colors.teal,
          animationDuration: const Duration(milliseconds: 700),
          height: 60,
          index: updatedIndex,
          onTap: (newIndex) {
            RootPage.selectedIndexNotifier.value = newIndex;
          },
          items: const <Widget>[
            Icon(
              IconlyBold.home,
              
              size: 20,
            ),
            Icon(
              IconlyBold.category,
              size: 20,
            ),
            Icon(
              IconlyBold.graph,
              size: 20,
            ),
          ],
        );
      },
    );
  }
}
