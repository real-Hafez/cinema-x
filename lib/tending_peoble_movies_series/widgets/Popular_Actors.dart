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
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Text(
                  personModel[index].name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * .02,
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
