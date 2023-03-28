// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

class LowerWorkouts extends StatelessWidget {
  LowerWorkouts({super.key});

  final List _workoutsLower = [
    'Workout1',
    'Workout2',
    'Workout3',
    'Workout4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Container(
            height: 750,
            child: ListView.builder(
              itemCount: _workoutsLower.length,
              itemBuilder: (context, index) {
                return SquareWorkoutsList(
                  child: _workoutsLower[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
