import 'package:flutter/material.dart';

import 'DatabaseHelper.dart';
import 'event.dart';

List<Widget> printSelectedWorkoutDescription(selectedWorkouts, context) {
  return [
    if (selectedWorkouts.isNotEmpty)
      Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
        child: Card(
          color: const Color(0xFF99a98c),
          child: Center(
            child: SizedBox(
              height: 150,
              width: 700,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SingleChildScrollView(
                  child: ScrollConfiguration(
                    behavior:
                        const ScrollBehavior(), // From this behaviour you can change the behaviour
                    child: GlowingOverscrollIndicator(
                      axisDirection: AxisDirection.down,
                      color: const Color(0xFF99a98c),
                      child: Text(
                        "${selectedWorkouts.last.name}:\n${selectedWorkouts.last.description}",
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFe9e6df)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    Padding(
      padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          child: Text(
            "Do selected Workouts (${selectedWorkouts.length})",
            style: const TextStyle(
                color: Color(0xFFe9e6df), fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            final messenger = ScaffoldMessenger.of(context);
            Event workout;
            if (selectedWorkouts.isNotEmpty) {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.utc(2023, 1, 1),
                  lastDate: DateTime.utc(2030, 12, 31));
              for (int i = 0; i < selectedWorkouts.length; i++) {
                if (pickedDate != null) {
                  if (await DatabaseHelper.instance
                      .doesNullEventExist('', '')) {
                    workout = Event(
                        workoutName: selectedWorkouts[i].name,
                        workoutMuscle: selectedWorkouts[i].muscle,
                        met: selectedWorkouts[i].met,
                        day: pickedDate.day,
                        month: pickedDate.month,
                        year: pickedDate.year,
                        totalCalories: await DatabaseHelper.instance
                            .getCaloriesForDay(pickedDate.day, pickedDate.month,
                                pickedDate.year),
                        caloriesBurned: await DatabaseHelper.instance
                            .getCaloriesBurnedForWorkout(
                                selectedWorkouts[i].name,
                                selectedWorkouts[i].muscle,
                                pickedDate.day,
                                pickedDate.month,
                                pickedDate.year));
                  } else {
                    workout = Event(
                        workoutName: selectedWorkouts[i].name,
                        workoutMuscle: selectedWorkouts[i].muscle,
                        met: selectedWorkouts[i].met,
                        day: pickedDate.day,
                        month: pickedDate.month,
                        year: pickedDate.year,
                        totalCalories: 0,
                        caloriesBurned: 0);
                  }
                  if (!(await DatabaseHelper.instance.doesEventExist(
                      selectedWorkouts[i].name,
                      selectedWorkouts[i].muscle,
                      pickedDate.day,
                      pickedDate.month,
                      pickedDate.year))) {
                    DatabaseHelper.instance.insertEvent(workout);
                    // print(await DatabaseHelper.queryAllEvents());
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text(
                            "Added ${selectedWorkouts[i].name} for ${pickedDate.month}/${pickedDate.day}/${pickedDate.year}"),
                      ),
                    );
                  } else {
                    messenger.showSnackBar(const SnackBar(
                      content: Text("Event Already Exists"),
                    ));
                  }
                }
              }
            }
          },
        ),
      ),
    )
  ];
}
