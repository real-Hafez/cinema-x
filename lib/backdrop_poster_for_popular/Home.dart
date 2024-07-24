import 'package:cinema_x/for_you_row/widgets/for_you_row.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/Builder_for_first_popular_in_app.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _hasInternet = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    bool hasInternet = await _checkConnection();
    setState(() {
      _hasInternet = hasInternet;
      _loading = false;
    });
  }

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xff090E17),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_hasInternet) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        fontSize: 28,
        textColor: Colors.white,
      );
      return const Scaffold(
        backgroundColor: Color(0xff090E17),
        body: Center(
          child: Text(
            "No internet connection",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
            ),
          ),
        ),
      );
    }

    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            backdrop_poster_for_popular(),
            SizedBox(height: 20),
            for_you_row(),
          ],
        ),
      ),
    );
  }
}

