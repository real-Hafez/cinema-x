import 'package:cinema_x/Pick_card/models/fav_genre_model.dart';
import 'package:cinema_x/home/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class text_container_for_select_at_least_one extends StatefulWidget {
  const text_container_for_select_at_least_one({
    super.key,
    required this.atLeastOneSelected,
    required this.selectedGenres,
  });

  final bool atLeastOneSelected;
  final List<FavGenre> selectedGenres;

  @override
  State<text_container_for_select_at_least_one> createState() =>
      _text_container_for_select_at_least_oneState();
}

class _text_container_for_select_at_least_oneState
    extends State<text_container_for_select_at_least_one> {
  CollectionReference genra = FirebaseFirestore.instance.collection('genra');

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<void> addUser() async {
    String? email = await _getUserEmail();
    if (email == null) {
      Fluttertoast.showToast(
        msg: 'User email not found',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 18.0,
      );
      return;
    }

    List<Map<String, dynamic>> genresToAdd = widget.selectedGenres
        .map((genre) => {
              'name': genre.name,
              'photo': genre.photo,
              'genre': genre.genra,
              'id': genre.id,
            })
        .toList();

    try {
      await genra.doc(email).set({'fav_genres': genresToAdd});
      print("User Added");
    } catch (error) {
      print("Failed to add user: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      left: 20,
      right: 20,
      child: GestureDetector(
        onTap: () async {
          if (widget.atLeastOneSelected) {
            await addUser();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          } else {
            Fluttertoast.showToast(
              msg: 'Please choose at least one genre',
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 18.0,
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          decoration: widget.atLeastOneSelected
              ? BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(25),
                )
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
          child: Center(
            child: Text(
              widget.atLeastOneSelected ? 'Done' : 'Select at Least 1',
              style: widget.atLeastOneSelected
                  ? TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * .05,
                    )
                  : TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.width * .047,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
