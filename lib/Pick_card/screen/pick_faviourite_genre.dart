import 'package:cinema_x/Pick_card/widgets/Pick_card_u_would_like_to_Watch.dart';
import 'package:cinema_x/Pick_card/widgets/SliverAppBar.dart';
import 'package:cinema_x/Pick_card/widgets/all_genres.dart';
import 'package:flutter/material.dart';

class pick_faviourite_genre extends StatefulWidget {
  const pick_faviourite_genre({super.key});

  @override
  State<pick_faviourite_genre> createState() => _pick_faviourite_genreState();
}

class _pick_faviourite_genreState extends State<pick_faviourite_genre> {
  List<bool> selections = List<bool>.filled(favgenres.length, false);

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
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const sliver_App_Bar(),
                SliverPadding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * .02),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio:
                          MediaQuery.of(context).size.width * .0014,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.width * .02,
                            horizontal: MediaQuery.of(context).size.width * .02,
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
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => AnotherPage()),
                  // );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  decoration: atLeastOneSelected
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
                      atLeastOneSelected ? 'done' : 'Select at Least 1',
                      style: atLeastOneSelected
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * .05,
                            )
                          : TextStyle(
                              color: Colors.black,
                              fontSize:
                                  MediaQuery.of(context).size.width * .047,
                            ),
                    ),
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
