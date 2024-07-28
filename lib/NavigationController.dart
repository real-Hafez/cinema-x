// // navigation_controller.dart
// import 'package:cinema_x/HomePage/screen/Home_Screen.dart';
// import 'package:cinema_x/SearchPage/screen/Search_Screen.dart';
// import 'package:cinema_x/profileScreen/screen/profile_Screen.dart';
// import 'package:get/get.dart';
// import 'package:flutter/widgets.dart';

// class NavigationController extends GetxController {
//   late ScrollController scrollController;

//   NavigationController({required this.scrollController});

//   void navigateTo(int index) {
//     switch (index) {
//       case 0:
//         Get.to(() => HomeScreen(scrollController: scrollController),
//             transition: Transition.rightToLeft,
//             duration: const Duration(milliseconds: 300));
//         break;
//       case 1:
//         Get.to(() => const SearchScreen(),
//             transition: Transition.leftToRight,
//             duration: const Duration(milliseconds: 300));
//         break;
//       case 2:
//         Get.to(() => const ProfileScreen(),
//             transition: Transition.fadeIn,
//             duration: const Duration(milliseconds: 300));
//         break;
//       default:
//         // Handle other cases if needed
//         break;
//     }
//   }
// }
