import 'package:cinema_x/Actor/Screen/Actor_Screen.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/TV/Screen/Series_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';

class Text_field_For_Search extends StatefulWidget {
  const Text_field_For_Search({
    super.key,
    required this.bottomBarVisibilityNotifier,
    required this.onSearchChanged,
  });

  final ValueNotifier<bool> bottomBarVisibilityNotifier;
  final Function(bool) onSearchChanged;

  @override
  State<Text_field_For_Search> createState() => _Text_field_For_SearchState();
}

class _Text_field_For_SearchState extends State<Text_field_For_Search> {
  final TextEditingController _controller = TextEditingController();
  final TMDbService _tmdbService = TMDbService();
  late FocusNode _focusNode;
  bool _isWriting = false;
  List<SearchResultModel> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        widget.bottomBarVisibilityNotifier.value = !_focusNode.hasFocus;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) async {
    if (query.isNotEmpty) {
      final results = await _tmdbService.searchMedia(query);
      setState(() {
        _isWriting = true;
        _searchResults = results;
      });
    } else {
      setState(() {
        _isWriting = false;
        _searchResults = [];
      });
    }
    widget.onSearchChanged(_isWriting);
  }

  void _navigateToDetailScreen(SearchResultModel item) {
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

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).size.width * 0.04;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: padding,
                      vertical: MediaQuery.of(context).size.height * 0.010,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2C39),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xff8994A2)),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Color(0xff8994A2)),
                              border: InputBorder.none,
                            ),
                            onChanged: _onSearchChanged,
                          ),
                        ),
                        if (_controller.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _controller.clear();
                              setState(() {
                                _isWriting = false;
                                _searchResults = [];
                                widget.onSearchChanged(false);
                              });
                            },
                            child: const Icon(Icons.close,
                                color: Color(0xff8994A2)),
                          ),
                      ],
                    ),
                  ),
                ),
                if (_controller.text.isNotEmpty)
                  TextButton(
                    onPressed: () {
                      _controller.clear();
                      setState(() {
                        _isWriting = false;
                        _searchResults = [];
                        widget.onSearchChanged(false);
                      });
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.white, fontSize: 14.0),
                    ),
                  ),
              ],
            ),
            if (_isWriting)
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final item = _searchResults[index];
                      return _buildSearchResultItem(
                        item.title ?? item.name ?? '',
                        item.releaseDate ?? item.firstAirDate ?? '',
                        item.posterPath ?? '',
                        item,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(String title, String subtitle,
      String posterPath, SearchResultModel item) {
    return GestureDetector(
      onTap: () => _navigateToDetailScreen(item),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.017),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.width * 0.4 * 1.5,
              child: CachedNetworkImage(
                imageUrl: '${ApiConfig.imageBaseUrl}$posterPath',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.blue),
                    backgroundColor: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  AutoSizeText(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
