import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/Logo.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/watch_now_button.dart';
import 'package:flutter/material.dart';

class TrendingBackdrop extends StatelessWidget {
  final String imageUrl;
  final String nameOrTitle;

  const TrendingBackdrop({
    super.key,
    required this.imageUrl,
    required this.nameOrTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
              child: CircularProgressIndicator(
                value: downloadProgress.progress,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.blue,
                ),
                backgroundColor: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => const Icon(Icons.error),
            fit: BoxFit.fitWidth,
            alignment: Alignment.center,
          ),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.width * 0.20,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: AutoSizeText(
              nameOrTitle,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 12,
              stepGranularity: 0.1,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.06,
          left: MediaQuery.of(context).size.width * 0.03,
          bottom: MediaQuery.of(context).size.width * 0.01,
          child: const watch_now_button(),
        ),
        const Logo(),
      ],
    );
  }
}
