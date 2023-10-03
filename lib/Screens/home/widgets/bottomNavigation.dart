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
        return BottomNavigationBar(
          selectedItemColor: Color.fromARGB(255, 20, 8, 5),
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            RootPage.selectedIndexNotifier.value = newIndex;
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.home,
                size: 20,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.category,
                size: 20,
              ),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IconlyBold.graph,
                size: 20,
              ),
              label: 'Statistics',
            ),
          ],
        );
      },
    );
  }
}
