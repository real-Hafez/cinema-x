import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/home/ApiConfig.dart';
import 'package:cinema_x/home/models/popular/popular_tmdb.dart';
import 'package:flutter/material.dart';

class row_trending_home_view_under_backdrop_item extends StatelessWidget {
  const row_trending_home_view_under_backdrop_item({
    super.key,
    required this.Popular,
  });
  final popular Popular;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .005),
      child: GestureDetector(
        onTap: () {
          print(' ${Popular.video}');
        },
        child: Container(
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.imageBaseUrl}${Popular.backdropPath}',
            fit: BoxFit.scaleDown,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            // fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
