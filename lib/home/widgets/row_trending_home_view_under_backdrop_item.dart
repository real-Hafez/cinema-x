import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/home/ApiConfig.dart';
import 'package:cinema_x/home/models/popular/popular_tmdb.dart';
import 'package:flutter/material.dart';

class RowTrendingHomeViewUnderBackdropItem extends StatelessWidget {
  const RowTrendingHomeViewUnderBackdropItem({
    super.key,
    required this.Popular,
    required this.onImageTap,
  });

  final popular Popular;
  final Function(String) onImageTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .07,
          horizontal: MediaQuery.of(context).size.height * .005),
      child: GestureDetector(
        onTap: () {
          onImageTap(
            '${ApiConfig.imageBaseUrl}${Popular.backdropPath}',
          );
        },
        child: CachedNetworkImage(
          imageUrl: '${ApiConfig.imageBaseUrl}${Popular.backdropPath}',
          fit: BoxFit.scaleDown,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(
              value: downloadProgress.progress,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.blue,
              ),
              backgroundColor: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
