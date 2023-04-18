import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'event.dart';

class UpperModel {
  String name, muscle;
  bool isSelected;

  UpperModel(this.name, this.muscle, this.isSelected);
}

class UpperWorkouts extends StatefulWidget {
  const UpperWorkouts({super.key});

  @override
  State<UpperWorkouts> createState() => _UpperWorkoutsState();
}

class _UpperWorkoutsState extends State<UpperWorkouts> {
  List<UpperModel> workoutsUpper = [
    UpperModel("Upper Workout 1", "All", false),
    UpperModel("Upper Workout 2", "Biceps", false),
    UpperModel("Upper Workout 3", "Back", false),
    UpperModel("Upper Workout 4", "Chest", false),
    UpperModel("Upper Workout 5", "Core", false),
    UpperModel("Upper Workout 6", "Core", false),
    UpperModel("Upper Workout 7", "Shoulders", false),
    UpperModel("Upper Workout 8", "Shoulders", false),
  ];

  List<UpperModel> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 630,
            child: ListView.builder(
              itemCount: workoutsUpper.length,
              itemBuilder: (BuildContext context, int index) {
                return UpperWorkoutItem(
                  workoutsUpper[index].name,
                  workoutsUpper[index].muscle,
                  workoutsUpper[index].isSelected,
                  index,
                );
              },
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
                  if (selectedWorkouts.isNotEmpty) {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(2023, 1, 1),
                        lastDate: DateTime.utc(2030, 12, 31));
                    for (int i = 0; i < selectedWorkouts.length; i++) {
                      if (pickedDate != null) {
                        Event workout = Event(
                            workoutName: selectedWorkouts[i].name,
                            workoutMuscle: selectedWorkouts[i].muscle,
                            day: pickedDate.day,
                            month: pickedDate.month,
                            year: pickedDate.year);
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
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
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

  //This widget enables the items to be created and clickable
  // ignore: non_constant_identifier_names
  Widget UpperWorkoutItem(
      String name, String muscle, bool isSelected, int index) {
    return Card(
      color: const Color(0xFF99a98c),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFe9e6df),
            ),
          ),
          subtitle: Text(
            muscle,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(132, 233, 230, 223)),
          ),
          trailing: isSelected
              ? const Icon(
                  Icons.check_circle,
                  color: Color(0xFFe9e6df),
                )
              : const Icon(Icons.check_circle,
                  color: Color.fromARGB(132, 233, 230, 223)),
          onTap: () {
            setState(() {
              workoutsUpper[index].isSelected =
                  !workoutsUpper[index].isSelected;
              if (workoutsUpper[index].isSelected) {
                selectedWorkouts.add(UpperModel(name, muscle, isSelected));
              } else if (!(workoutsUpper[index].isSelected)) {
                selectedWorkouts.removeWhere(
                    (element) => element.name == workoutsUpper[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}
