import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/TV/model/Episodes_model.dart';
import 'package:cinema_x/TV/service/Episodes_Servicec.dart';
import 'package:flutter/material.dart';

class SeasonEpisodesTab extends StatefulWidget {
  final int seriesId;
  final int seasonNumber;

  const SeasonEpisodesTab({
    super.key,
    required this.seriesId,
    required this.seasonNumber,
  });

  @override
  _SeasonEpisodesTabState createState() => _SeasonEpisodesTabState();
}

class _SeasonEpisodesTabState extends State<SeasonEpisodesTab> {
  late Future<SeasonDetails> futureSeasonDetails;

  @override
  void initState() {
    super.initState();
    futureSeasonDetails = EpisodesService()
        .fetchTVShowDetails(widget.seriesId, widget.seasonNumber);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SeasonDetails>(
      future: futureSeasonDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load episodes'));
        } else if (!snapshot.hasData || snapshot.data!.episodes.isEmpty) {
          return const Center(child: Text('No episodes available.'));
        }

        final seasonDetails = snapshot.data!;
        return ListView.builder(
          itemCount: seasonDetails.episodes.length,
          itemBuilder: (context, index) {
            final episode = seasonDetails.episodes[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(8.0),
                leading: episode.posterPath.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl:
                            '${ApiConfig.imageBaseUrl}${episode.posterPath}',
                        width: 200,
                        height: 250,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.blue),
                                    backgroundColor: Colors.white,
                                  ),
                                ))
                    : const SizedBox(
                        width: 200,
                        height: 200,
                        child: Icon(Icons.image, size: 90)),
                title: Text(
                  '${episode.episodeNumber}. ${episode.name}',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  episode.airDate ?? 'unkonw' '${episode.airDate}' '',
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  // Handle episode tap if needed
                },
              ),
            );
          },
        );
      },
    );
  }
}
