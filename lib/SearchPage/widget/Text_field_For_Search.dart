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
  late FocusNode _focusNode;

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      child: TextField(
                        controller: _controller,
                        focusNode: _focusNode,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: MediaQuery.of(context).size.width * .05),
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Color(0xff8994A2)),
                          border: InputBorder.none,
                        ),
                        onChanged: (text) {
                          widget.onSearchChanged(text.isNotEmpty);
                        },
                      ),
                    ),
                    if (_controller.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _controller.clear();
                          widget.onSearchChanged(false);
                        },
                        // child:
                        //     const Icon(Icons.close, color: Color(0xff8994A2)),
                      ),
                  ],
                ),
              ),
            ),
            if (_controller.text.isNotEmpty)
              TextButton(
                onPressed: () {
                  _controller.clear();
                  widget.onSearchChanged(false);
                },
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
    );
  }
}
