// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:money_manager_db/screens/home/screen_home.dart';

// ValueNotifier<bool> homeicon = ValueNotifier(false);

// class MoneyManagerBottomNavigation extends StatelessWidget {
//   const MoneyManagerBottomNavigation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: ScreenHome.selectedIndexNotifier,
//       builder: (BuildContext ctx, int updatedIndex, Widget? _) {
//         return BottomNavigationBar(
//           selectedLabelStyle: GoogleFonts.acme(fontSize: 15),
//           unselectedLabelStyle: GoogleFonts.acme(fontSize: 15),
//           backgroundColor: const Color.fromARGB(255, 17, 163, 176),
//           selectedItemColor: Colors.purple,
//           unselectedItemColor: Colors.white,
//           currentIndex: updatedIndex,
//           onTap: (newIndex) {
//             ScreenHome.selectedIndexNotifier.value = newIndex;
//             if (newIndex == 1) {
//               homeicon.value = true;
//             } else {
//               homeicon.value = false;
//             }
//           },
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_max),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.category_sharp),
//               label: 'Categories',
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
