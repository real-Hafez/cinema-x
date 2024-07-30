import 'package:flutter/material.dart';

class TvSeriesScreen extends StatelessWidget {
  final int tvId;

  const TvSeriesScreen({super.key, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Series Screen')),
      body: Center(
        child: Text('TV Series Screen\nTV ID: $tvId'),
      ),
    );
  }
}
