// import 'package:cinema_x/Home.dart';
// import 'package:cinema_x/Search/screen/Search_Screen.dart';
// import 'package:cinema_x/profile/screen/profile_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:get/get.dart';

// class BaseScreen extends StatefulWidget {
//   final int initialIndex;

//   const BaseScreen({this.initialIndex = 0, Key? key}) : super(key: key);

//   @override
//   _BaseScreenState createState() => _BaseScreenState();
// }

// class _BaseScreenState extends State<BaseScreen> {
//   final ScrollController _scrollController = ScrollController();
//   bool _isNavBarVisible = true;
//   late int _currentIndex;

//   final List<Widget> _screens = [
//     Home(),
//     SearchScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(_onScroll);
//     _currentIndex = widget.initialIndex;
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _onScroll() {
//     if (_scrollController.offset > 200 &&
//         _scrollController.position.userScrollDirection == ScrollDirection.reverse) {
//       if (_isNavBarVisible) {
//         setState(() {
//           _isNavBarVisible = false;
//         });
//       }
//     } else if (_scrollController.offset <= 150 ||
//         _scrollController.position.userScrollDirection == ScrollDirection.forward) {
//       if (!_isNavBarVisible) {
//         setState(() {
//           _isNavBarVisible = true;
//         });
//       }
//     }
//   }

//   void _onNavItemTap(int index) {
//     if (_currentIndex != index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff090E17),
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             controller: _scrollController,
//             child: _screens[_currentIndex],
//           ),
//           _buildNavBar(context),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavBar(BuildContext context) {
//     return Positioned(
//       bottom: _isNavBarVisible ? 10 : -80,
//       left: 0,
//       right: 0,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 400),
//         margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
//         padding: const EdgeInsets.symmetric(vertical: 15),
//         decoration: BoxDecoration(
//           color: Colors.black.withOpacity(0.6),
//           borderRadius: BorderRadius.circular(50),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.6),
//               spreadRadius: 5,
//               blurRadius: 10,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _buildNavItem(Icons.home, 'Home', 0),
//             _buildNavItem(Icons.search, 'Search', 1),
//             _buildNavItem(Icons.person, 'Profile', 2),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavItem(IconData icon, String title, int index) {
//     return GestureDetector(
//       onTap: () => _onNavItemTap(index),
//       child: AnimatedScale(
//         scale: _currentIndex == index ? 1.3 : 1.0,
//         duration: const Duration(milliseconds: 300),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               icon,
//               color: _currentIndex == index ? Colors.blue : Colors.grey,
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                 color: _currentIndex == index ? Colors.blue : Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
