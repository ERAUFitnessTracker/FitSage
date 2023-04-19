import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'event.dart';

class LowerModel {
  String name, muscle, description;
  double met;
  bool isSelected;

  LowerModel(
      this.name, this.muscle, this.met, this.isSelected, this.description);
}

class LowerWorkouts extends StatefulWidget {
  const LowerWorkouts({super.key});

  @override
  State<LowerWorkouts> createState() => _LowerWorkoutsState();
}

class _LowerWorkoutsState extends State<LowerWorkouts> {
  List<LowerModel> workoutsLower = [
    LowerModel("Buttkicks (moderate)", "Lower Body", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Keeping your upper body straight, lift your left foot off the ground and bring your heel towards your buttocks.
3. Lower your left foot back to the ground and repeat the movement with your right foot.
4. Alternate between left and right foot, continuously bringing your heels towards your buttocks.
5. Aim for a moderate pace, kicking your heels up as close to your buttocks as possible.
6. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("High Knees (moderate)", "Lower Body", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Engage your core and bring your left knee towards your chest.
3. Quickly lower your left leg back to the ground and immediately bring your right knee towards your chest.
4. Continue alternating between left and right knees, bringing them towards your chest in a running motion.
5. Aim for a moderate pace, bringing your knees up as high as possible while maintaining good posture.
6. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("Squats (moderate)", "Lower Body", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet slightly wider than hip-width apart, with your toes pointing slightly outwards.
2. Keep your chest up, engage your core, and lower your body by bending your knees.
3. Keep your weight in your heels and push your hips back as if you are sitting on a chair.
4. Lower your body until your thighs are parallel to the ground or as low as comfortable for you.
5. Push through your heels and squeeze your glutes to raise your body back up to the starting position.
6. Aim for a moderate pace, keeping your chest up and your knees pointing in the same direction as your toes.
7. Complete 8-12 reps for 2-3 sets."""),
    LowerModel("Lunges (moderate)", "Lower Body", 3.8, false, """
Duration: 8-12 reps for 2-3 sets

1. Stand with your feet hip-width apart, with your arms at your sides.
2. Take a big step forward with your left foot, and lower your body by bending both knees.
3. Keep your front knee directly above your ankle, and lower your back knee towards the ground without touching it.
4. Push through your front heel to raise your body back up to the starting position.
5. Repeat with your right foot stepping forward, alternating between left and right.
6. Aim for a moderate pace, keeping your upper body straight and your core engaged.
7. Complete 8-12 reps on each side for 2-3 sets."""),
    LowerModel("Buttkicks (vigorous)", "Lower Body", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Keeping your upper body straight, lift your left foot off the ground and bring your heel towards your buttocks.
3. Lower your left foot back to the ground and repeat the movement with your right foot.
4. Alternate between left and right foot, continuously bringing your heels towards your buttocks.
5. Aim for a fast pace, kicking your heels up as close to your buttocks as possible.
6. Complete 12-15 reps on each side for 3-4 sets."""),
    LowerModel("High Knees (vigorous)", "Lower Body", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart and your arms at your sides.
2. Engage your core and bring your left knee towards your chest.
3. Quickly lower your left leg back to the ground and immediately bring your right knee towards your chest.
4. Continue alternating between left and right knees, bringing them towards your chest in a running motion.
5. Aim for a fast pace, bringing your knees up as high as possible while maintaining good posture.
6. Complete 12-15 reps on each side for 3-4 sets."""),
    LowerModel("Squats (vigorous)", "Lower Body", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet slightly wider than hip-width apart, with your toes pointing slightly outwards.
2. Keep your chest up, engage your core, and lower your body by bending your knees.
3. Keep your weight in your heels and push your hips back as if you are sitting on a chair.
4. Lower your body until your thighs are parallel to the ground or as low as comfortable for you.
5. Push through your heels and squeeze your glutes to raise your body back up to the starting position.
6. Aim for a fast pace, keeping your chest up and your knees pointing in the same direction as your toes.
7. Complete 12-15 reps for 3-4 sets."""),
    LowerModel("Lunges (vigorous)", "Lower Body", 8, false, """
Duration: 12-15 reps for 3-4 sets

1. Stand with your feet hip-width apart, with your arms at your sides.
2. Take a big step forward with your left foot, and lower your body by bending both knees.
3. Keep your front knee directly above your ankle, and lower your back knee towards the ground without touching it.
4. Push through your front heel to raise your body back up to the starting position.
5. Repeat with your right foot stepping forward, alternating between left and right.
6. Aim for a fast pace, keeping your upper body straight and your core engaged.
7. Complete 12-15 reps on each side for 3-4 sets."""),
  ];

  List<LowerModel> selectedWorkouts = [];

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
                  itemCount: workoutsLower.length,
                  itemBuilder: (BuildContext context, int index) {
                    return LowerWorkoutItem(
                      workoutsLower[index].name,
                      workoutsLower[index].muscle,
                      workoutsLower[index].met,
                      workoutsLower[index].isSelected,
                      workoutsLower[index].description,
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
  Widget LowerWorkoutItem(String name, String muscle, double met,
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
              workoutsLower[index].isSelected =
                  !workoutsLower[index].isSelected;
              if (workoutsLower[index].isSelected) {
                selectedWorkouts.add(
                    LowerModel(name, muscle, met, isSelected, description));
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
