import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:cinema_x/Movies/widgets/youtubeplayer.dart';
import 'package:flutter/material.dart';

class movie_Screen_ui extends StatelessWidget {
  const movie_Screen_ui({
    super.key,
    required this.screenWidth,
    required this.videoHeight,
    required this.selectedTrailer,
  });

  final double screenWidth;
  final double videoHeight;
  final Video_Movies_model? selectedTrailer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: screenWidth,
            height: videoHeight,
            child: MyYoutubePlayer(
              videoUrl:
                  'https://www.youtube.com/watch?v=${selectedTrailer!.key}',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Row(
            children: [
              Expanded(
                flex: 5,
                child: ElevatedButton(
                  onPressed: () {},
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
        ),
      ],
    );
  }
}
