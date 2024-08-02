import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchSeriesNow extends StatefulWidget {
  final int id;
  final int episode;
  final int sesson_number;
  const WatchSeriesNow(
      {super.key,
      required this.id,
      required this.sesson_number,
      required this.episode}); // Accept id in constructor

  @override
  State<WatchSeriesNow> createState() => _WatchSeriesNowState();
}

class _WatchSeriesNowState extends State<WatchSeriesNow> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Set orientation to landscape
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    // Reset orientation to portrait when disposing
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(
                    'https://vidsrc.net/embed/tv?tmdb=${widget.id}&season=${widget.sesson_number}&episode=${widget.episode}',
                  ),
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    javaScriptCanOpenWindowsAutomatically: false,
                  ),
                  android: AndroidInAppWebViewOptions(),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: false,
                    disallowOverScroll: false,
                  ),
                ),
                initialSettings: InAppWebViewSettings(
                  mediaPlaybackRequiresUserGesture: false,
                  userAgent:
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/604.1',
                ),
                onLoadStop: (controller, url) {
                  setState(() {
                    isLoading = false;
                  });
                  print('Page loaded: $url');
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final requestedUrl = navigationAction.request.url;
                  final mainUrl =
                      Uri.parse('https://vidsrc.net/embed/movie/${widget.id}');

                  if (requestedUrl != null &&
                      requestedUrl.host != mainUrl.host) {
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
