import 'package:flutter/material.dart';

class PuzzleScreen extends StatelessWidget {
  const PuzzleScreen({
    required this.seed,
    Key? key,
  }) : super(key: key);

  final String seed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('PuzzleScreen: $seed')),
    );
  }
}
