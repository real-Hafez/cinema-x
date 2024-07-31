import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MyYoutubePlayer extends StatefulWidget {
  final String videoUrl;

  const MyYoutubePlayer({super.key, required this.videoUrl});

  @override
  State<MyYoutubePlayer> createState() => _MyYoutubePlayerState();
}

class _MyYoutubePlayerState extends State<MyYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    String videoId = _extractVideoId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildPlayer(),
    );
  }

  Widget _buildPlayer() {
    return YoutubePlayer(
      controller: _controller,
      showVideoProgressIndicator: true,
      onReady: () {
        _controller.addListener(listener);
      },
    );
  }

  String _extractVideoId(String url) {
    final uri = Uri.parse(url);
    return uri.queryParameters['v'] ?? '';
  }

  void listener() {
    if (_controller.value.playerState == PlayerState.ended) {
      print('Video has ended');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
