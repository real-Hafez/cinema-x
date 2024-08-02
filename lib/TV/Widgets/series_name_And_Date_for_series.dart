import 'package:cinema_x/TV/model/Episodes_model.dart'; // Ensure this import matches
import 'package:flutter/material.dart';

class series_name_And_Date_for_series extends StatelessWidget {
  const series_name_And_Date_for_series({
    super.key,
    required this.episode,
  });

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
