// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

class LowerWorkouts extends StatelessWidget {
  LowerWorkouts({super.key});

  final List _workoutsLower = [
    'Lower Workout1',
    'Lower Workout2',
    'Lower Workout3',
    'Lower Workout4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Expanded(
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
            )),
          )
        ],
      ),
    );
  }
}
