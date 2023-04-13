import 'package:flutter/material.dart';
import 'package:ui_draft1/squareForWorkouts.dart';

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
    UpperModel("pushUps", "Chest", false),
    UpperModel("Vladimir", "Biceps", false),
    UpperModel("I love", "XDD", false),
    UpperModel("Kryptiax", "Erection", false),
    UpperModel("Other xd :3", "All", false),
    UpperModel("huh", "ye", false),
    UpperModel("we :3", "lol", false),
  ];

  List<UpperModel> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 700,
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
              child: ElevatedButton(
                child: Text(
                  "Do selected Workouts (${selectedWorkouts.length})",
                  style: const TextStyle(
                      color: Color(0xFFe9e6df), fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  //This will send the workouts to the calendar table
                  for (int i = 0; i < selectedWorkouts.length; i++) {
                    print(
                        "${selectedWorkouts[i].name} ${selectedWorkouts[i].muscle}");
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
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
