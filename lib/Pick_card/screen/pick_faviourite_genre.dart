import 'package:cinema_x/Pick_card/models/fav_genre_model.dart';
import 'package:cinema_x/Pick_card/widgets/Pick_card_u_would_like_to_Watch.dart';
import 'package:cinema_x/Pick_card/widgets/SliverAppBar.dart';
import 'package:cinema_x/Pick_card/widgets/all_genres.dart';
import 'package:cinema_x/Pick_card/widgets/text_container_for_select_at_least_one.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class pick_faviourite_genre extends StatefulWidget {
  const pick_faviourite_genre({super.key});

  @override
  State<pick_faviourite_genre> createState() => _pick_faviourite_genreState();
}

class _pick_faviourite_genreState extends State<pick_faviourite_genre> {
  List<bool> selections = List<bool>.filled(favgenres.length, false);
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserGenres();
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email'); // Assuming 'userEmail' is the key
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

    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('genra').doc(email).get();
    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      List<dynamic> favGenres = data['fav_genres'];

      setState(() {
        for (var genre in favGenres) {
          int index = favgenres.indexWhere((g) => g.name == genre['name']);
          if (index != -1) {
            selections[index] = true;
          }
        }
        isLoading = false;
      });
    } else {
      print("No data found for user");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _updateSelection(int index, bool isSelected) {
    setState(() {
      selections[index] = isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool atLeastOneSelected = selections.contains(true);

    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      const sliver_App_Bar(),
                      SliverPadding(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * .02),
                        sliver: SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width * .0014,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * .02,
                                  horizontal:
                                      MediaQuery.of(context).size.width * .02,
                                ),
                                child: Pick_card_u_would_like_to_Watch(
                                  favGenre: favgenres[index],
                                  isSelected: selections[index],
                                  onSelected: (bool isSelected) {
                                    _updateSelection(index, isSelected);
                                  },
                                ),
                              );
                            },
                            childCount: favgenres.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                  text_container_for_select_at_least_one(
                      atLeastOneSelected: atLeastOneSelected,
                      selectedGenres: _getSelectedGenres())
                ],
              ),
      ),
    );
  }

  List<FavGenre> _getSelectedGenres() {
    List<FavGenre> selectedGenres = [];
    for (int i = 0; i < selections.length; i++) {
      if (selections[i]) {
        selectedGenres.add(favgenres[i]);
      }
    }
    return selectedGenres;
  }
}
