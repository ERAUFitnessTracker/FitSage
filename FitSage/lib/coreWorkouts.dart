import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'event.dart';

class CoreModel {
  String name, muscle, description;
  double met;
  bool isSelected;

  CoreModel(
      this.name, this.muscle, this.met, this.isSelected, this.description);
}

class CoreWorkouts extends StatefulWidget {
  const CoreWorkouts({super.key});

  @override
  State<CoreWorkouts> createState() => _CoreWorkoutsState();
}

class _CoreWorkoutsState extends State<CoreWorkouts> {
  List<CoreModel> workoutsCore = [
    CoreModel("Plank (moderate)", "Core", 3.8, false, """
Duration: 30-60 seconds for 2-3 sets

1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight and engage your core, ensuring that your hips are in line with your shoulders.
3. Hold this position for 30-60 seconds, aiming for 2-3 sets."""),
    CoreModel("Crunches (moderate)", "Core", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head, and lift your shoulders off the ground towards your knees.
3. Keep your neck and spine in a neutral position, and exhale as you lift your shoulders off the ground.
4. Pause for a moment, and then lower your shoulders back to the ground.
5. Aim for 10-15 reps, completing 2-3 sets."""),
    CoreModel("Leg Raises (moderate)", "Core", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your legs straight out in front of you.
2. Place your hands by your sides or under your hips for extra support.
3. Lift your legs off the ground until they are perpendicular to the floor.
4. Lower your legs back down towards the ground without touching it.
5. Aim for 10-15 reps, completing 2-3 sets.
"""),
    CoreModel("Sit Ups (moderate)", "Core", 3.8, false, """
Duration: 10-15 reps for 2-3 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head or crossed on your chest.
3. Engage your core and lift your upper body off the ground towards your knees.
4. Pause for a moment, and then lower your upper body back to the ground.
5. Aim for 10-15 reps, completing 2-3 sets."""),
    CoreModel("Plank (vigorous)", "Core", 8, false, """
Duration: 60-90 seconds for 3-4 sets

1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight and engage your core, ensuring that your hips are in line with your shoulders.
3. Hold this position for 60-90 seconds, aiming for 3-4 sets."""),
    CoreModel("Crunches (vigorous)", "Core", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head, and lift your shoulders off the ground towards your knees.
3. Keep your neck and spine in a neutral position, and exhale as you lift your shoulders off the ground.
4. Pause for a moment, and then lower your shoulders back to the ground.
5. Aim for 15-20 reps, completing 3-4 sets."""),
    CoreModel("Leg Raises (vigorous)", "Core", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your legs straight out in front of you.
2. Place your hands by your sides or under your hips for extra support.
3. Lift your legs off the ground until they are perpendicular to the floor.
4. Lower your legs back down towards the ground without touching it.
5. Aim for 15-20 reps, completing 3-4 sets."""),
    CoreModel("Sit Ups (vigorous)", "Core", 8, false, """
Duration: 15-20 reps for 3-4 sets

1. Lie on your back with your knees bent and your feet flat on the ground.
2. Place your hands behind your head or crossed on your chest.
3. Engage your core and lift your upper body off the ground towards your knees.
4. Pause for a moment, and then lower your upper body back to the ground.
5. Aim for 15-20 reps, completing 3-4 sets."""),
  ];

  List<CoreModel> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: ScrollConfiguration(
              behavior:
                  const ScrollBehavior(), // From this behaviour you can change the behaviour
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color:
                    const Color(0xFF99a98c), // You can change your splash color
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  itemCount: workoutsCore.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CoreWorkoutItem(
                      workoutsCore[index].name,
                      workoutsCore[index].muscle,
                      workoutsCore[index].met,
                      workoutsCore[index].isSelected,
                      workoutsCore[index].description,
                      index,
                    );
                  },
                ),
              ),
            ),
          ),
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
                  "Do selected workouts (${selectedWorkouts.length})",
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
                                  .getCaloriesForDay(pickedDate.day,
                                      pickedDate.month, pickedDate.year));
                        } else {
                          workout = Event(
                              workoutName: selectedWorkouts[i].name,
                              workoutMuscle: selectedWorkouts[i].muscle,
                              met: selectedWorkouts[i].met,
                              day: pickedDate.day,
                              month: pickedDate.month,
                              year: pickedDate.year,
                              totalCalories: 0);
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
  Widget CoreWorkoutItem(String name, String muscle, double met,
      bool isSelected, String description, int index) {
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
              workoutsCore[index].isSelected = !workoutsCore[index].isSelected;
              if (workoutsCore[index].isSelected) {
                selectedWorkouts
                    .add(CoreModel(name, muscle, met, isSelected, description));
              } else if (!(workoutsCore[index].isSelected)) {
                selectedWorkouts.removeWhere(
                    (element) => element.name == workoutsCore[index].name);
              }
            });
          },
        ),
      ),
    );
  }
}
