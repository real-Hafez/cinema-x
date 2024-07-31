import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/Pick_card/widgets/all_genres.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadEmail();
  }

  Future<void> _loadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email') ?? 'No email found';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SafeArea(
        child: Column(
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
                color: const Color(
                    0xFF2A2E3D), // Adjust this color to match the button's background color
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors
                      .blue, // Adjust this color if the button has a border
                  width: 1, // Adjust the width of the border
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextButton(
                onPressed: () {
                  AuthService().signout(context: context);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            )
          ],
        ),
      ),
    );
  }
}
