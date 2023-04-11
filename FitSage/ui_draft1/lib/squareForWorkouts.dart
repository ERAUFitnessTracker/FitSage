// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/WorkoutsUpperModel.dart';
import 'package:ui_draft1/upperWorkouts.dart';

class SquareWorkoutsList extends StatelessWidget {
  final String name;
  final String muscle;
  bool isSelected;
  final int index;

  SquareWorkoutsList({
    //Creating instance variables
    required this.name,
    required this.muscle,
    required this.isSelected,
    required this.index,
    Key? key, //Idk what this does but its necessary LMAO
  }) : super(key: key);

  get _workoutsUpper => false;

  get selectedWorkouts => false;

  @override
  //Style of the box in which the workouts will be displayed
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[700],
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: const Icon(
            Icons.access_alarm,
            color: Colors.white,
          ),
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(muscle),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.blue[700],
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            isSelected = !isSelected;
            if (_workoutsUpper[index].isSelected == true) {
              selectedWorkouts.add(UpperModel(name, muscle, true, index));
            } else if (_workoutsUpper[index].isSelected == false) {
              selectedWorkouts
                  .removeWhere(UpperModel(name, muscle, true, index));
            }
            print(isSelected);
          },
        ),
      ),
    );
  }
}
