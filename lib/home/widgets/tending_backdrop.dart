import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/popular/popular_tmdb.dart';
import '../ApiConfig.dart';

class trending_backdrop extends StatelessWidget {
  final popular Popular;

  const trending_backdrop({
    super.key,
    required this.Popular,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5,
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.imageBaseUrl}${Popular.backdropPath}',
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
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.03,
          bottom: MediaQuery.of(context).size.width * 0.01,
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Text(
                'watch now ',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.025,
                ),
              )),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * -0.35,
          bottom: MediaQuery.of(context).size.width * -0.01,
          child: Container(
            width: 100,
            child: Image.asset(
              'assets/Images/logo_transpernent.png',
            ),
          ),
        ),
      ],
    );
  }
}
