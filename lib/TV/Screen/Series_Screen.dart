import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/TV/model/videos_series/result.dart';
import 'package:cinema_x/TV/service/Video_Service.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/TV/Widgets/Series_Screen_ui.dart';

class TvSeriesScreen extends StatefulWidget {
  final int tvId;

  const TvSeriesScreen({super.key, required this.tvId});

  @override
  _TvSeriesScreenState createState() => _TvSeriesScreenState();
}

class _TvSeriesScreenState extends State<TvSeriesScreen> {
  Result? seriesData;
  Result? selectedTrailer;
  List<Result> trailers = [];
  String seriesName = 'Loading...'; // Placeholder for the series name

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final seriesDetails = await TMDbService().getSeriesDetails(widget.tvId);
      final videoList = await TMDbService().fetchVideosSeries(widget.tvId);

      final trailerList = videoList.where((video) => video.type == 'Trailer').toList();
      if (trailerList.isNotEmpty) {
        final officialTrailers = trailerList.where((video) => (video.official ?? false)).toList();
        if (officialTrailers.isNotEmpty) {
          officialTrailers.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
          selectedTrailer = officialTrailers.first;
        } else {
          trailerList.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
          selectedTrailer = trailerList.first;
        }
        trailers = trailerList;
      }

      if (selectedTrailer == null && trailers.isNotEmpty) {
        selectedTrailer = trailers.first;
      }

      setState(() {
        seriesData = seriesDetails;
        seriesName = seriesDetails.name ?? 'Unknown'; // Set the series name
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        shadowColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xff090E17),
        title: AutoSizeText(
          seriesName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: seriesData == null
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: SeriesScreenUI(
                  seriesId: widget.tvId,  // Pass the tvId to SeriesScreenUI
                  screenWidth: MediaQuery.of(context).size.width,
                  videoHeight: MediaQuery.of(context).size.width / (16 / 9),
                  trailers: trailers,
                  onTrailerSelected: (trailer) {
                    setState(() {
                      selectedTrailer = trailer;
                    });
                  },
                ),
              ),
      ),
    );
  }
}
