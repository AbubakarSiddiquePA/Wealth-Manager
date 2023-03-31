import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_manager_db/screens/home/screen_home.dart';

ValueNotifier<bool> homeicon = ValueNotifier(false);

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
            buttonBackgroundColor: const Color.fromARGB(255, 17, 163, 176),
            height: 60,
            animationDuration: const Duration(milliseconds: 300),
            color: const Color.fromARGB(255, 17, 163, 176),
            backgroundColor: const Color.fromARGB(128, 57, 52, 52),
            index: updatedIndex,
            onTap: (newIndex) {
              ScreenHome.selectedIndexNotifier.value = newIndex;
              if (newIndex == 1) {
                homeicon.value = true;
              } else {
                homeicon.value = false;
              }
            },
            items: const [
              Icon(
                Icons.home,
                color: Colors.black,
              ),
              Icon(
                Icons.category_sharp,
                color: Colors.black,
              )
            ]);
      },
    );
  }
}
