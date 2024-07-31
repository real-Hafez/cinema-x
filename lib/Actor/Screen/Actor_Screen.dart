import 'package:flutter/material.dart';

class ActorScreen extends StatelessWidget {
  const ActorScreen({super.key, required this.actorId});
  final int actorId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Series Screen')),
      body: Center(
        child: Text('actor  Screen\nTV ID: $actorId'),
      ),
    );
  }
}
