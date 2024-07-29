import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/SearchPage/widget/Text_field_For_Search.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/models/popular/popular_tmdb.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  final List<popular> Popular;
  final ValueNotifier<bool> bottomBarVisibilityNotifier;
  final ValueNotifier<bool> isSearchingNotifier;

  const SearchScreen({
    super.key,
    required this.Popular,
    required this.bottomBarVisibilityNotifier,
    required this.isSearchingNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: Column(
        children: [
          Text_field_For_Search(
            bottomBarVisibilityNotifier: bottomBarVisibilityNotifier,
            onSearchChanged: (isSearching) {
              isSearchingNotifier.value = isSearching;
            },
          ),
          Expanded(
            child: ValueListenableBuilder<bool>(
              valueListenable: isSearchingNotifier,
              builder: (context, isSearching, child) {
                return Visibility(
                  visible: !isSearching,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.5,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 9,
                    ),
                    itemCount: Popular.length,
                    itemBuilder: (context, index) {
                      final posterPath = Popular[index].posterPath ?? '';
                      final imageUrl = '${ApiConfig.imageBaseUrl}$posterPath';
                      print('Image URL: $imageUrl');

                      return ClipRRect(
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
                                (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                    Colors.blue),
                                backgroundColor: Colors.white,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
