import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/tending_peoble_movies_series/models/Person_Model.dart';
import 'package:flutter/material.dart';

class PopularActors extends StatelessWidget {
  const PopularActors({super.key, required this.personModel});
  final List<Person_Model> personModel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .3,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: personModel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.height * .2,
                  child: ClipOval(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .03,
                          vertical: MediaQuery.of(context).size.height * .005),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://image.tmdb.org/t/p/original${personModel[index].profilePath}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .04,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        personModel[index].name,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.height * .026,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 309),
                      ),
                      ColorizeAnimatedText(
                        personModel[index].name,
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .026,
                          fontWeight: FontWeight.bold,
                        ),
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    repeatForever: false,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
