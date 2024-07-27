// import 'package:flutter/material.dart';

// PageRouteBuilder _rightToLeftTransition(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;
//       var tween = Tween(begin: begin, end: end);
//       var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
//       return SlideTransition(position: offsetAnimation, child: child);
//     },
//   );
// }

// PageRouteBuilder _leftToRightTransition(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       const begin = Offset(-1.0, 0.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;
//       var tween = Tween(begin: begin, end: end);
//       var offsetAnimation = animation.drive(tween.chain(CurveTween(curve: curve)));
//       return SlideTransition(position: offsetAnimation, child: child);
//     },
//   );
// }
