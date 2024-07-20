import 'package:cinema_x/Pick_card/widgets/Pick_card_u_would_like_to_Watch.dart';
import 'package:cinema_x/Pick_card/widgets/SliverAppBar.dart';
import 'package:cinema_x/Pick_card/widgets/all_genres.dart';
import 'package:flutter/material.dart';

class pick_faviourite_genre extends StatelessWidget {
  const pick_faviourite_genre({super.key});

  @override
  Widget build(BuildContext context) {
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
                            horizontal: MediaQuery.of(context).size.width * .02,
                          ),
                          child: Pick_card_u_would_like_to_Watch(
                            favGenre: favgenres[index],
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      'Select at Least 1',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * .047,
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
