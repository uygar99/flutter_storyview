import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/routes.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({
    super.key,
    required this.index,
    required this.selected,
  });

  final int index;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 10,
      selectedItemColor: const Color(0xFF162FD8),
      unselectedItemColor: const Color(0xFF676D7C),
      unselectedFontSize: 14,
      backgroundColor: Colors.white,
      currentIndex: index,
      type: BottomNavigationBarType.fixed,
      onTap: (indexTap) {
        switch (indexTap) {
          case 0:
            if (indexTap != index) Get.offAllNamed(Routes.home);
            break;
          case 1:
            if (indexTap != index) Get.offAllNamed(Routes.chooseAccount);
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout_outlined),
          label: "Logout",
        ),
        /*BottomNavigationBarItem(
          icon: Icon(Icons.logout_outlined),
          label: "Stories",
        ),*/
      ],
    );
  }
}
