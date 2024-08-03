import 'package:cinema_x/Watch_Movies/screen/Watch_Movies.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class watch_Now_And_Add_to_wishlist_button extends StatefulWidget {
  const watch_Now_And_Add_to_wishlist_button({
    super.key,
    required this.id,
    required this.imageUrl,
  });

  final int id;
  final String imageUrl;

  @override
  _watch_Now_And_Add_to_wishlist_buttonState createState() =>
      _watch_Now_And_Add_to_wishlist_buttonState();
}

class _watch_Now_And_Add_to_wishlist_buttonState
    extends State<watch_Now_And_Add_to_wishlist_button> {
  bool isAddedToWishlist = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    checkIfAddedToWishlist();
  }

  @override
  void dispose() {
    _isDisposed = true; // Mark as disposed
    super.dispose();
  }

  Future<void> checkIfAddedToWishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('wishlist')
          .doc(email)
          .collection('movies')
          .doc(widget.id.toString())
          .get();

      if (!_isDisposed && doc.exists) {
        setState(() {
          isAddedToWishlist = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WatchMoviesNow(
                      id: widget.id,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              child: Text(
                'Watch Now',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * .02,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .03),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () {
                if (!isAddedToWishlist) {
                  _addToWishlist(widget.id, widget.imageUrl); // Add to wishlist
                } else {
                  _removeFromWishlist(widget.id); // Remove from wishlist
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02),
                backgroundColor:
                    isAddedToWishlist ? Colors.grey : Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: isAddedToWishlist ? Colors.yellow : Colors.white,
                    size: MediaQuery.of(context).size.height * .03,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * .01),
                  Text(
                    isAddedToWishlist
                        ? 'Remove from Wishlist'
                        : 'Add to Wishlist',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .02,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addToWishlist(int id, String imageUrl) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      try {
        await FirebaseFirestore.instance
            .collection('wishlist')
            .doc(email)
            .collection('movies')
            .doc(id.toString())
            .set({
          'movieId': id,
          'imageUrl': imageUrl,
          'timestamp': DateTime.now(),
        });
        Fluttertoast.showToast(
          msg: 'Added to Wishlist.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 18.0,
        );
        if (!_isDisposed) {
          setState(() {
            isAddedToWishlist = true;
          });
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'There was an error.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } else {
      print('Email not found in SharedPreferences');
    }
  }

  Future<void> _removeFromWishlist(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    if (email != null) {
      try {
        await FirebaseFirestore.instance
            .collection('wishlist')
            .doc(email)
            .collection('movies')
            .doc(id.toString())
            .delete();
        Fluttertoast.showToast(
          msg: 'Removed from Wishlist.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 18.0,
        );
        if (!_isDisposed) {
          setState(() {
            isAddedToWishlist = false;
          });
        }
      } catch (e) {
        Fluttertoast.showToast(
          msg: 'There was an error.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }
    } else {
      print('Email not found in SharedPreferences');
    }
  }
}
