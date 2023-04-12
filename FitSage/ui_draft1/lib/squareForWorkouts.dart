// ignore: file_names

import 'package:flutter/material.dart';
import 'package:ui_draft1/WorkoutsUpperModel.dart';
import 'package:ui_draft1/upperWorkouts.dart';

class SquareWorkoutsList extends StatefulWidget {
  final String name;
  final String muscle;
  bool isSelected;
  int index;

  SquareWorkoutsList({
    //Creating instance variables
    required this.name,
    required this.muscle,
    required this.isSelected,
    required this.index,
    Key? key, //Idk what this does but its necessary LMAO
  }) : super(key: key);

  @override
  State<SquareWorkoutsList> createState() => _SquareWorkoutsListState();
}

class _SquareWorkoutsListState extends State<SquareWorkoutsList> {
  @override

  //Style of the box in which the workouts will be displayed
  Widget build(BuildContext context) {
    UpperWorkouts uWorkouts = UpperWorkouts();
    int index = 0;
    int selectedIndex = 0;
    List selectedWorkouts = [];
    return Card(
      color: Colors.lightGreen,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: const Icon(
            Icons.access_alarm,
            color: Colors.white,
          ),
          title: Text(
            widget.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text(widget.muscle),
          trailing: widget.isSelected
              ? Icon(
                  Icons.check_circle,
                  color: Colors.blue[700],
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
          onTap: () {
            setState(() {
              selectedIndex = uWorkouts.workoutsUpper[widget.index].index;
              print("Select index: $selectedIndex");
              print("index: $index");
              widget.isSelected = !widget.isSelected;
              if (widget.isSelected) {
                uWorkouts.selectedWorkouts.add([
                  widget.name,
                  widget.muscle,
                  widget.isSelected,
                  widget.index
                ]);

                print(selectedWorkouts.toString());
              } else {
                uWorkouts.selectedWorkouts
                    .remove(uWorkouts.workoutsUpper[selectedIndex]);
              }
            });
          },
        ),
      ),
    );
  }
}
