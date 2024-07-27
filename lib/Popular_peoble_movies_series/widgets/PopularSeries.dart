import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Popular_Series_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PopularSeries extends StatelessWidget {
  const PopularSeries({super.key, required this.popular_Series});
  final List<Popular_Series_model> popular_Series;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .060,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: 1.18,
            mainAxisSpacing: MediaQuery.of(context).size.width * .040,
          ),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: popular_Series.length,
          itemBuilder: (context, index) {
            final movie = popular_Series[index];
            final imageUrl = '${ApiConfig.imageBaseUrl}${movie.posterPath}';

            return CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.fill,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                  backgroundColor: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          },
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .027)),
    );
  }
}
