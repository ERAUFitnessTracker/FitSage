// ignore: file_names
import 'package:flutter/material.dart';

class SquareWorkoutsList extends StatelessWidget {
  final String child;

  const SquareWorkoutsList({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 200,
        color: const Color(0xFF99a98c),
        child: Text(child),
      ),
    );
  }
}
