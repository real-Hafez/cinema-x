import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/TV/Screen/Watch_Now_Series.dart';
import 'package:cinema_x/TV/Widgets/series_name_And_Date_for_series.dart';
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

  void _navigateToWatchSeriesNow(int episodeNumber) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WatchSeriesNow(
          id: widget.seriesId,
          sesson_number: widget.seasonNumber,
          episode: episodeNumber, // Use episodeNumber instead of id
        ),
      ),
    );
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
            return GestureDetector(
              onTap: () => _navigateToWatchSeriesNow(episode.episodeNumber), // Use episodeNumber
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                                    top: Radius.circular(12.0)), // Rounded top corners
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
                      series_name_And_Date_for_series(episode: episode),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
