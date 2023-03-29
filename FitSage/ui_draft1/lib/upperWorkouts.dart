// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

class UpperWorkouts extends StatelessWidget {
  UpperWorkouts({super.key});

  final List _workoutsUpper = [
    'Upper Workout1',
    'Upper Workout2',
    'Upper Workout3',
    'Upper Workout4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                tooltip: 'Back To Home',
                backgroundColor: const Color(0xFF99a98c),
                child: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
