import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_series.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_series.dart';
import 'package:flutter/material.dart';

class for_you_item_series extends StatefulWidget {
  const for_you_item_series({super.key, this.showAll = false});
  final bool showAll;

  @override
  State<for_you_item_series> createState() => _for_you_item_seriesState();
}

class _for_you_item_seriesState extends State<for_you_item_series> {
  late Future<List<for_you_model_series>> futureseries;
  final for_you_service_series seriesService = for_you_service_series();

  @override
  void initState() {
    super.initState();
    futureseries = Future.value([]);

    seriesService.printUserEmail().then((_) {
      if (seriesService.Fav_series_list.isNotEmpty) {
        setState(() {
          futureseries = seriesService.fetchseries(1);
        });
      } else {
        print('No favorite genres available to fetch series.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          fit: FlexFit.loose,
          child: FutureBuilder<List<for_you_model_series>>(
            future: futureseries,
            builder: (BuildContext context,
                AsyncSnapshot<List<for_you_model_series>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const pick_faviourite_genre(),
                        ),
                      );
                    },
                    child: const Text('Select Your Favorite Genres'),
                  ),
                );
                //return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const pick_faviourite_genre(),
                        ),
                      );
                    },
                    child: const Text('Select Your Favorite Genres'),
                  ),
                );
              } else {
                final series = snapshot.data!;
                return GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: series.length,
                  itemBuilder: (BuildContext context, int index) {
                    final seriess = series[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .02,
                          vertical: 0),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiConfig.imageBaseUrl}${seriess.posterPath}',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
