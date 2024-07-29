import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';
import 'package:flutter/material.dart';

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
  List<MediaItem> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        if (_focusNode.hasFocus) {
          widget.bottomBarVisibilityNotifier.value = false;
        } else {
          widget.bottomBarVisibilityNotifier.value = true;
        }
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .04,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .04,
                      vertical: MediaQuery.of(context).size.height * .015,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2C39),
                      borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * .07,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Color(0xff8994A2)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                          height: MediaQuery.of(context).size.width * .04,
                        ),
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).size.width * .05,
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
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * .035,
                      ),
                    ),
                  ),
              ],
            ),
            if (_isWriting)
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                  itemCount: _searchResults.length,
                  itemBuilder: (context, index) {
                    final item = _searchResults[index];
                    return _buildSearchResultItem(
                      item.title,
                      item.releaseDate,
                      item.posterPath,
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResultItem(
      String title, String subtitle, String posterPath) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                image:
                    NetworkImage('https://image.tmdb.org/t/p/w500$posterPath'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
