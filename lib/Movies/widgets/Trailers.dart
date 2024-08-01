import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:intl/intl.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart'; // Add this dependency to your pubspec.yaml

class Trailers extends StatelessWidget {
  final List<Video_Movies_model> trailers;
  final void Function(Video_Movies_model) onTrailerSelected;

  const Trailers({
    super.key,
    required this.trailers,
    required this.onTrailerSelected,
  });

  void _showVideoPlayer(BuildContext context, String videoId) {
    final YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sortedTrailers = List<Video_Movies_model>.from(trailers)
      ..sort((a, b) => a.publishedAt!.compareTo(b.publishedAt!));

    return ListView.builder(
      itemCount: sortedTrailers.length,
      itemBuilder: (context, index) {
        final trailer = sortedTrailers[index];
        final formattedDate = DateFormat.yMMMd().format(trailer.publishedAt!);

        return GestureDetector(
          onTap: () => onTrailerSelected(trailer),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: 'https://img.youtube.com/vi/${trailer.key}/0.jpg',
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
                  width: MediaQuery.of(context).size.width * .4,
                  height: MediaQuery.of(context).size.height * .12,
                  // alignment: Alignment.center,
                ),
                SizedBox(width: MediaQuery.of(context).size.width * .02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        trailer.name!,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .07,
                          color: Colors.white,
                        ),
                        maxFontSize: 21,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                      AutoSizeText(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        maxFontSize: 14,
                        minFontSize: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.blue),
                  onPressed: () => _showVideoPlayer(context, trailer.key!),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
