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
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[900], // Background color for the box
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 4), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Image
                    episode.posterPath.isNotEmpty
                        ? Container(
                            width: double.infinity, // Full width
                            height: 300, // Fixed height
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(
                                      12.0)), // Rounded top corners
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    '${ApiConfig.imageBaseUrl}${episode.posterPath}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 300,
                            color: Colors.grey[800],
                            child: const Icon(Icons.image, size: 90),
                          ),
                    // Text Content
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${episode.episodeNumber}. ${episode.name}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            episode.airDate ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
