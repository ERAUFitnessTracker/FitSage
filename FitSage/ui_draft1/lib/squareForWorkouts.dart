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
      color: const Color(0xFF99a98c),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            '\t${widget.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          subtitle: Text('\t${widget.muscle}'),
          trailing: widget.isSelected
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
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
