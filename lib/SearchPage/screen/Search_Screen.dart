import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Popular_Series_model.dart';
import 'package:cinema_x/Popular_peoble_movies_series/service/Popular_movies_service.dart';
import 'package:cinema_x/SearchPage/widget/Text_field_For_Search.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/models/popular/popular_tmdb.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/TV/Screen/Series_Screen.dart';
import 'package:cinema_x/Actor/Screen/Actor_Screen.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/service/popular_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SearchScreen extends StatefulWidget {
  final List<popular> Popular;
  final ValueNotifier<bool> bottomBarVisibilityNotifier;
  final ValueNotifier<bool> isSearchingNotifier;
  final ScrollController scrollController;

  const SearchScreen({
    super.key,
    required this.Popular,
    required this.bottomBarVisibilityNotifier,
    required this.isSearchingNotifier,
    required this.scrollController,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SearchResultModel> _searchResults = [];

  void _updateSearchResults(List<SearchResultModel> results) {
    setState(() {
      _searchResults = results;
    });
  }

  void _navigateToDetailScreen(dynamic item) {
    if (item is popular) {
      print('Navigating to: ${item.mediaType} with ID: ${item.id}');
      if (item.mediaType == 'movie') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesScreen(movieId: item.id),
          ),
        );
      } else if (item.mediaType == 'tv') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TvSeriesScreen(tvId: item.id),
          ),
        );
      } else if (item.mediaType == 'person') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActorScreen(actorId: item.id),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: Column(
        children: [
          Text_field_For_Search(
            bottomBarVisibilityNotifier: widget.bottomBarVisibilityNotifier,
            onSearchChanged: (isSearching) {
              widget.isSearchingNotifier.value = isSearching;
            },
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  if (scrollNotification.scrollDelta! > 0) {
                    widget.bottomBarVisibilityNotifier.value = false;
                  } else if (scrollNotification.scrollDelta! < 0) {
                    widget.bottomBarVisibilityNotifier.value = true;
                  }
                }
                return true;
              },
              child: ValueListenableBuilder<bool>(
                valueListenable: widget.isSearchingNotifier,
                builder: (context, isSearching, child) {
                  return Visibility(
                    visible: !isSearching,
                    child: GridView.builder(
                      controller: widget.scrollController,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.5,
                        mainAxisSpacing: 9,
                        crossAxisSpacing: 9,
                      ),
                      itemCount: _searchResults.isEmpty
                          ? widget.Popular.length
                          : _searchResults.length,
                      itemBuilder: (context, index) {
                        final item = _searchResults.isEmpty
                            ? widget.Popular[index]
                            : _searchResults[index];

                        // Type-checking and casting
                        final String posterPath;
                        if (item is popular) {
                          posterPath = item.posterPath ?? '';
                        } else if (item is SearchResultModel) {
                          posterPath = item.posterPath ?? '';
                        } else {
                          posterPath =
                              ''; // Fallback to an empty path if type is unknown
                        }

                        final imageUrl = '${ApiConfig.imageBaseUrl}$posterPath';
                        print('Image URL: $imageUrl');

                        return GestureDetector(
                          onTap: () {
                            print('Tapped on item: $item');
                            _navigateToDetailScreen(item);
                          },
                          child: Container(
                            color: Colors.transparent, // Ensure it's tappable
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                      backgroundColor: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
