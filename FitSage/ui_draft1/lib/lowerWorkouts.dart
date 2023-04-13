import 'package:flutter/material.dart';

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
    LowerModel("pushUps", "Chest", false),
    LowerModel("Vladimir", "Biceps", false),
    LowerModel("I love Jack", "XDD", false),
    LowerModel("Kryptiax", "Erection", false),
    LowerModel("Other xd :3", "All", false),
  ];

  List<LowerModel> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 750,
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
