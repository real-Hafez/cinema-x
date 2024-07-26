import 'package:audioplayers/audioplayers.dart';
import 'package:cinema_x/Home.dart';
import 'package:cinema_x/layout.dart';
import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/Splash_screen/widgets/SlideImageAnimationant_Text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Splash_Screen_body extends StatefulWidget {
  const Splash_Screen_body({super.key});

  @override
  _Splash_Screen_bodyState createState() => _Splash_Screen_bodyState();
}

class _Splash_Screen_bodyState extends State<Splash_Screen_body>
    with TickerProviderStateMixin {
  late String finelemail = ""; // Initialize variable
  late String finelepassword = ""; // Initialize variable
  bool isLoading = true;

  late AudioPlayer _audioPlayer;
  late AnimationController _controller;
  late AnimationController _textController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late AnimationController _sloganController;
  late Animation<Offset> _SloganAnimation;

  bool _showFirstAnimation = true;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _fetchUserGenres();

    Future.delayed(
      const Duration(seconds: 0),
      _playSound,
    );

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _sloganController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 3.0, end: 0.7).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0))
            .animate(_controller);
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(3.5, 0), end: const Offset(-0.2, 0))
            .animate(_textController);

    _controller.forward().whenComplete(() {
      setState(() {
        _showFirstAnimation = false;
      });
      _controller.reset();
      _controller.duration = const Duration(milliseconds: 10);
      _controller.forward().whenComplete(() {
        setState(() {
          _textController.forward();
        });
      });
    });

    _SloganAnimation =
        Tween<Offset>(begin: const Offset(-5, 0), end: const Offset(0, 0))
            .animate(_sloganController);
    _sloganController.forward();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    await getvalidation();

    if (finelemail.isEmpty || finelepassword.isEmpty) {
      Get.off(
        transition: Transition.fade,
        () => const layout(),
        duration: const Duration(seconds: 0),
      );
    } else {
      try {
        final QuerySnapshot result = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: finelemail)
            .limit(1)
            .get();
        final List<DocumentSnapshot> documents = result.docs;

        if (documents.isEmpty) {
          //       print("Email does not exist in Firestore");
          Get.off(
            transition: Transition.fadeIn,
            () => const Home(),
            duration: const Duration(seconds: 0),
          );
        } else {
          print("Email exists in Firestore");
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: finelemail,
            password: finelepassword,
          );
          Get.off(
            transition: Transition.zoom,
            () => const pick_faviourite_genre(),
            duration: const Duration(seconds: 0),
          );
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: 'Make sure you have a valid email and password',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        Get.off(
          transition: Transition.fade,
          () => const layout(),
          duration: const Duration(seconds: 0),
        );
      }
    }
  }

  Future<void> getvalidation() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedemail = sharedPreferences.getString('email');
    var obtainedpassword = sharedPreferences.getString('password');

    setState(() {
      finelemail = obtainedemail ?? "";
      finelepassword = obtainedpassword ?? "";
    });
    print('Email: $finelemail');
    print('Password: $finelepassword');
    await Future.delayed(const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    _textController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideImageAnimationant_Text(
      controller: _controller,
      showFirstAnimation: _showFirstAnimation,
      scaleAnimation: _scaleAnimation,
      slideAnimation: _slideAnimation,
      textSlideAnimation: _textSlideAnimation,
      sloganController: _sloganController,
      SloganAnimation: _SloganAnimation,
    );
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(
        volume: 0.7,
        AssetSource('sounds/app opening - Sound Effect.mp3'),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Sorry, there is a problem now with audio')),
      );
    }
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> _fetchUserGenres() async {
    String? email = await _getUserEmail();
    if (email == null) {
      print("User email not found");
      setState(() {
        isLoading = false;
      });
      return;
    }

    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;

    if (documents.isEmpty) {
      //  print("Email does not exist in our database");
    } else {
      print("Email exists in database");
    }
    setState(() {
      isLoading = false;
    });
  }
}
