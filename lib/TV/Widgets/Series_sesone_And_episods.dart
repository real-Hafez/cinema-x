import 'package:cinema_x/TV/model/Details_Series_Model.dart';
import 'package:flutter/material.dart';

class Series_sesone_And_episods extends StatelessWidget {
  final TVShowModel tvShow;

  const Series_sesone_And_episods({super.key, required this.tvShow});

  @override
  Widget build(BuildContext context) {
    if (tvShow.seasons == null || tvShow.seasons!.isEmpty) {
      return const Center(child: Text('No seasons available.'));
    }

    // Filter out invalid seasons and remove season 0 if it exists
    final validSeasons = tvShow.seasons!
        .where((season) =>
            season.seasonNumber != null &&
            season.episodeCount != null &&
            season.episodeCount! > 0)
        .where((season) => season.seasonNumber != 0)
        .toList();

    if (validSeasons.isEmpty) {
      return Center(
        child: Text(
          'There is a problem while Showing Seasons.',
          style: TextStyle(
            color: Colors.blue,
            fontSize: MediaQuery.of(context).size.height * .02,
          ),
        ),
      );
    }

    return DefaultTabController(
      length: validSeasons.length,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            TabBar(
              tabAlignment: TabAlignment.center,
              physics: const BouncingScrollPhysics(),
              isScrollable: true,
              padding: const EdgeInsets.all(1),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 8, color: Colors.blue),
              ),
              tabs: validSeasons.asMap().entries.map((entry) {
                Season season = entry.value;

                return Tab(
                  text:
                      'Season ${season.seasonNumber} (${season.episodeCount ?? 0} episodes)',
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
