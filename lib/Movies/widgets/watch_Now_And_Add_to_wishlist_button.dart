import 'package:cinema_x/Watch_Movies/screen/Watch_Movies.dart';
import 'package:flutter/material.dart';

class watch_Now_And_Add_to_wishlist_button extends StatelessWidget {
  const watch_Now_And_Add_to_wishlist_button({
    super.key,
    required this.id,
  });
  final int id;
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
                              id: id,
                            )));
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
                    color: Colors.white),
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * .03),
          Expanded(
            flex: 4,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .02),
                backgroundColor: Colors.blueGrey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bookmark,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.height * .03,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.height * .01),
                  Text(
                    'Add to Wishlist',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .02,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
