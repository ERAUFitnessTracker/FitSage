import 'package:flutter/material.dart';
import 'package:ui_draft1/WorkoutsUpperModel.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

class UpperWorkouts extends StatelessWidget {
  UpperWorkouts({super.key});

  List<UpperModel> workoutsUpper = [
    UpperModel("pushUps", "Chest", false, 0),
    UpperModel("Vladimir", "Biceps", false, 1),
    UpperModel("I love Jack", "XDD", false, 2),
    UpperModel("Kryptiax", "Erection", false, 3),
    UpperModel("Other xd :3", "All", false, 4),
  ];

  List selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 750,
            child: ListView.builder(
              itemCount: workoutsUpper.length,
              itemBuilder: (BuildContext context, int index) {
                return SquareWorkoutsList(
                  name: workoutsUpper[index].name,
                  muscle: workoutsUpper[index].muscle,
                  isSelected: workoutsUpper[index].isSelected,
                  index: workoutsUpper[index].index,
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
