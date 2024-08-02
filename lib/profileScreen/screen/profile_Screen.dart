import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/Pick_card/widgets/all_genres.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;
  bool _hasInternetConnection = true;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkInitialConnectivity();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      setState(() {
        // Handle the first item in the list
        _hasInternetConnection =
            result.isNotEmpty && result[0] != ConnectivityResult.none;
      });
    });
    _loadEmail();
  }

  Future<void> _checkInitialConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasInternetConnection = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? 'No email found';
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SafeArea(
        child: _hasInternetConnection
            ? _buildProfileContent()
            : _buildNoConnectionMessage(),
      ),
    );
  }

  Widget _buildProfileContent() {
    return Column(
      children: [
        Center(
          child: AutoSizeText(
            'Your email: $_email',
            style: const TextStyle(
              color: Colors.white,
            ),
            minFontSize: 12,
            maxFontSize: 50,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 100,
        ),
        ListTile(
          leading: const Icon(Icons.movie, color: Colors.blue),
          title: const Text(
            'Your Favorite Genre',
            style: TextStyle(color: Colors.white),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          onTap: () {
            Get.to(const pick_faviourite_genre());
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .05,
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF2A2E3D),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: TextButton(
            onPressed: () {
              AuthService().signout(context: context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              backgroundColor: Colors.transparent,
            ),
            child: const Text(
              'Log Out',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoConnectionMessage() {
    return const Center(
      child: Text(
        'There was an error. Make sure you have an internet connection.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
