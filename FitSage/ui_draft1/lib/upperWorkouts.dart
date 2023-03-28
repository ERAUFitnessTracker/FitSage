// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

class UpperWorkouts extends StatelessWidget {
  UpperWorkouts({super.key});

  final List _workoutsUpper = [
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
              itemCount: _workoutsUpper.length,
              itemBuilder: (context, index) {
                return SquareWorkoutsList(
                  child: _workoutsUpper[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
