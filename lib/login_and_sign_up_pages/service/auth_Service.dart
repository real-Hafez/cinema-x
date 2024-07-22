import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/home/test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const pick_faviourite_genre(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'The email address is already in use by another account.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'operation-not-allowed') {
        message =
            'Sign-up method not allowed. Please enable the sign-up method in Firebase console.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found with this email address.';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password. Please try again.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please try again later.';
      } else if (e.code == 'auth/credential-already-in-use') {
        message = 'This credential is already associated with another account.';
      } else if (e.code == 'auth/account-exists-with-different-credential') {
        message =
            'An account already exists with the same email address but different sign-in credentials.';
      } else if (e.code == 'auth/popup-closed-by-user') {
        message = 'Popup closed by user before completing sign-in.';
      } else if (e.code == 'auth/popup-blocked') {
        message =
            'Popup blocked by the browser. Please allow popups and try again.';
      } else if (e.code == 'auth/invalid-credential') {
        message = 'Invalid credential. Please check your input and try again.';
      } else {
        message = 'An unknown error occurred. Please try again.';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Fluttertoast.showToast(
        msg: 'Sign in successfully',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );

      await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Home(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'The email address is badly formatted.';
      } else if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else if (e.code == 'user-disabled') {
        message = 'This user has been disabled.';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Try again later.';
      } else if (e.code == 'network-request-failed') {
        message = 'Network error. Please check your connection.';
      } else if (e.code == 'operation-not-allowed') {
        message =
            'Sign-in method not allowed. Please enable the sign-in method in Firebase console.';
      } else {
        message = 'An unkknown error occurred. Please try again.';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

//   Future<void> signout({
//     required BuildContext context
//   }) async {
//     await FirebaseAuth.instance.signOut();
//     await Future.delayed(const Duration(seconds: 1));
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (BuildContext context) =>Login()
//         )
//       );
//   }
//
}
