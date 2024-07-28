import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  final ValueNotifier<bool> bottomBarVisibilityNotifier;

  const SearchScreen({super.key, required this.bottomBarVisibilityNotifier});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool _isSearching = false;
  final TextEditingController _controller = TextEditingController();

  void _onFocusChange(bool hasFocus) {
    setState(() {
      _isSearching = hasFocus;
      widget.bottomBarVisibilityNotifier.value = !hasFocus;
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _controller.clear();
      FocusScope.of(context).unfocus();
      widget.bottomBarVisibilityNotifier.value = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Row(
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
                        MediaQuery.of(context).size.width * .07),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Color(0xff8994A2)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * .04,
                          height: MediaQuery.of(context).size.width * .04),
                      Expanded(
                        child: Focus(
                          onFocusChange: _onFocusChange,
                          child: TextField(
                            controller: _controller,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width * .05),
                            decoration: const InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(color: Color(0xff8994A2)),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      if (_isSearching && _controller.text.isNotEmpty)
                        GestureDetector(
                          onTap: () => _controller.clear(),
                          child:
                              const Icon(Icons.close, color: Color(0xff8994A2)),
                        ),
                    ],
                  ),
                ),
              ),
              if (_isSearching)
                TextButton(
                  onPressed: _cancelSearch,
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width * .035),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
