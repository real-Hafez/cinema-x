import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/widgets/Builder_for_first_popular_in_app.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_row.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_row_body.dart';
import 'package:cinema_x/tending_peoble_movies_series/widgets/trending_coulm.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _hasInternet = false;
  bool _loading = true;
  bool _toastShown = false;

  @override
  void initState() {
    super.initState();
    _checkInternetConnectivity();
  }

  Future<void> _checkInternetConnectivity() async {
    bool hasInternet = await for_you_service_movies().checkConnection();
    setState(() {
      _hasInternet = hasInternet;
      _loading = false;
      if (!_hasInternet && !_toastShown) {
        Fluttertoast.showToast(
          msg: "No internet connection",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          fontSize: 28,
          textColor: Colors.white,
        );
        _toastShown = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const InternetLoading();
    }

    if (!_hasInternet) {
      return const NoInternet();
    }

    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            backdrop_poster_for_popular(),
            SizedBox(height: 20),
            for_you_row(),
            TrendingCoulm(),
          ],
        ),
      ),
    );
  }
}

class InternetLoading extends StatelessWidget {
  const InternetLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
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
}
