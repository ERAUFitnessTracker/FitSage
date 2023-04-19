import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'event.dart';

class LowerModel {
  String name, muscle;
  bool isSelected;

  LowerModel(this.name, this.muscle, this.isSelected);
}

class LowerWorkouts extends StatefulWidget {
  const LowerWorkouts({super.key});

  @override
  State<LowerWorkouts> createState() => _LowerWorkoutsState();
}

class _LowerWorkoutsState extends State<LowerWorkouts> {
  List<LowerModel> workoutsLower = [
    LowerModel("Lower Workout 1", "All", false),
    LowerModel("Lower Workout 2", "Calves", false),
    LowerModel("Lower Workout 3", "Glutes", false),
    LowerModel("Lower Workout 4", "Groin", false),
    LowerModel("Lower Workout 5", "Hamstrings", false),
    LowerModel("Lower Workout 6", "Hamstrings", false),
    LowerModel("Lower Workout 7", "Quads", false),
    LowerModel("Lower Workout 8", "Quads", false),
  ];

  List<LowerModel> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 630,
            child: ScrollConfiguration(
              behavior:
                  const ScrollBehavior(), // From this behaviour you can change the behaviour
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color:
                    const Color(0xFF99a98c), // You can change your splash color
                child: ListView.builder(
                  itemCount: workoutsLower.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LowerWorkoutItem(
                      workoutsLower[index].name,
                      workoutsLower[index].muscle,
                      workoutsLower[index].isSelected,
                      index,
                    );
                  },
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

  // ignore: non_constant_identifier_names
  Widget LowerWorkoutItem(
      String name, String muscle, bool isSelected, int index) {
    return Card(
      color: const Color(0xFF99a98c),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: const Icon(
            Icons.access_alarm,
            color: Color(0xFFe9e6df),
          ),
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
              : const Icon(Icons.check_circle_outline,
                  color: Color.fromARGB(132, 233, 230, 223)),
          onTap: () {
            setState(() {
              workoutsLower[index].isSelected =
                  !workoutsLower[index].isSelected;
              if (workoutsLower[index].isSelected) {
                selectedWorkouts.add(LowerModel(name, muscle, isSelected));
              } else if (!(workoutsLower[index].isSelected)) {
                selectedWorkouts.removeWhere(
                    (element) => element.name == workoutsLower[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}
