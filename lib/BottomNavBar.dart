// import 'package:flutter/material.dart';

// class BottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final bool isVisible;
//   final Function(int) onTabTapped;

//   const BottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.isVisible,
//     required this.onTabTapped,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       bottom: 0,
//       left: 0,
//       right: 0,
//       child: AnimatedOpacity(
//         opacity: isVisible ? 1.0 : 0.0,
//         duration: const Duration(milliseconds: 300),
//         child: Container(
//           margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           padding: const EdgeInsets.symmetric(vertical: 10),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               _buildNavItem(Icons.home, 'Home', 0),
//               _buildNavItem(Icons.search, 'Search', 1),
//               _buildNavItem(Icons.person, 'Profile', 2),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String title, int index) {
//     final isSelected = currentIndex == index;
//     return GestureDetector(
//       onTap: () => onTabTapped(index),
//       child: AnimatedScale(
//         scale: isSelected ? 1.3 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: isSelected ? Colors.blue : Colors.grey,
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                 color: isSelected ? Colors.blue : Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
