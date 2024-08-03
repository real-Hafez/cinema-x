import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/widgets/watch_Now_And_Add_to_wishlist_button.dart';
import 'package:cinema_x/TV/Widgets/Series_sesone_And_episods.dart';
import 'package:cinema_x/TV/model/Details_Series_Model.dart';
import 'package:cinema_x/TV/model/videos_series/result.dart';
import 'package:cinema_x/TV/service/Details_Series_Service.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/Movies/widgets/youtubeplayer.dart';

class SeriesScreenUI extends StatefulWidget {
  const SeriesScreenUI({
    super.key,
    required this.screenWidth,
    required this.videoHeight,
    required this.seriesId,
    required this.trailers,
    required this.onTrailerSelected,
  });

  final double screenWidth;
  final double videoHeight;
  final int seriesId;
  final List<Result> trailers;
  final ValueChanged<Result> onTrailerSelected;

  @override
  _SeriesScreenUIState createState() => _SeriesScreenUIState();
}

class _SeriesScreenUIState extends State<SeriesScreenUI> {
  Result? selectedTrailer;
  TVShowModel? tvShowDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.trailers.isNotEmpty) {
      selectedTrailer = widget.trailers.first;
    }
    _fetchTVShowDetails();
  }

  Future<void> _fetchTVShowDetails() async {
    try {
      TVShowService tvShowService = TVShowService();
      TVShowModel details = await tvShowService.getTVShow(widget.seriesId);
      setState(() {
        tvShowDetails = details;
        isLoading = false;
      });
    } catch (e) {
      // Handle error (e.g., show a message to the user)
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while fetching data
      return const Center(child: CircularProgressIndicator());
    }

    // Handle case where tvShowDetails is still null
    final details = tvShowDetails;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Container(
            width: widget.screenWidth,
            height: widget.videoHeight,
            child: MyYoutubePlayer(
              videoUrl: selectedTrailer != null
                  ? 'https://www.youtube.com/watch?v=${selectedTrailer!.key}'
                  : '', // Handle case where selectedTrailer is null
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .02),
        // watch_Now_And_Add_to_wishlist_button(
        //   imageUrl: details!.posterPath ?? '',
        //   id: details.id ?? 1,
        // ),
        // SizedBox(height: MediaQuery.of(context).size.height * .03),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: AutoSizeText(
            details!.overview ?? 'No overview available',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .04,
              color: Colors.white,
            ),
            maxFontSize: 25,
            minFontSize: 14,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        Series_sesone_And_episods(
          tvShow: tvShowDetails!,
        ),
      ],
    );
  }
}
