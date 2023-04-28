import 'package:FitSage/DatabaseHelper.dart';
import 'package:FitSage/coreWorkouts.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'upperWorkouts.dart';
import 'lowerWorkouts.dart';
import 'package:duration_picker/duration_picker.dart';
import 'calculators.dart';
import 'event.dart';

//import 'package:google_fonts/google_fonts.dart';
class WorkoutModel {
  String name, description;
  double met;
  bool isSelected;

  WorkoutModel(this.name, this.met, this.isSelected, this.description);
}

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  //This is where you create the MaterialApp. This is used to set constants for the whole app, like themes and properties
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = Theme.of(context).textTheme.displaySmall!.copyWith(
          color: const Color.fromRGBO(255, 255, 255, 1),
          fontSize: 28,
        );
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BigCardButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UpperWorkouts(),
                      ),
                    );
                  },
                  child: Text(
                    'Upper Body Workouts',
                    style: cardTextStyle,
                  )),
              BigCardButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LowerWorkouts(),
                    ),
                  );
                },
                child: Text(
                  'Lower Body Workouts',
                  style: cardTextStyle,
                ),
              ),
              BigCardButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CoreWorkouts(),
                      ),
                    );
                  },
                  child: Text(
                    'Core Workouts',
                    style: cardTextStyle,
                  )),
              BigCardButton(
                  onPressed: () async {
                    List<Map<String, dynamic>> allWorkouts =
                        await DatabaseHelper.instance.queryEventsforDay(
                            DateTime.now().day,
                            DateTime.now().month,
                            DateTime.now().year);
                    double userWeight = double.parse(
                        await DatabaseHelper.instance.getUserInfo('weight'));
                    int duration = 0;
                    double met = 0;

                    for (int i = 0; i < allWorkouts.length; i++) {
                      if (allWorkouts[i]['caloriesBurned'] == 0) {
                        // ignore: use_build_context_synchronously
                        Duration? time = await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                '\n\n\nHow long did you take doing ${allWorkouts[i]['workoutName']}?',
                                style: const TextStyle(
                                    backgroundColor: Color(0xFF99a98c),
                                    color: Color(0xFFe9e6df),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                              titleTextStyle: cardTextStyle,
                              insetPadding: const EdgeInsets.all(0),
                              backgroundColor: Colors.transparent,
                              content: SizedBox(
                                height: double
                                    .maxFinite, // Provide a specific height for the content
                                width: double
                                    .maxFinite, // Provide a specific width for the content
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    DurationPickerDialog(
                                      initialTime: Duration.zero,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFe9e6df),
                                        boxShadow: const [BoxShadow()],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        // ignore: unrelated_type_equality_checks
                        if (time != null && time != 0) {
                          duration = time.inMinutes;
                          met = allWorkouts[i]['met'];

                          double caloriesBurned = 0;
                          double totalCaloriesBurned = 0;
                          caloriesBurned = Calculators()
                              .caloriesBurned(userWeight, duration, met);

                          await DatabaseHelper.instance
                              .setCaloriesBurnedForWorkout(
                                  allWorkouts[i]['workoutName'],
                                  allWorkouts[i]['workoutMuscle'],
                                  allWorkouts[i]['day'],
                                  allWorkouts[i]['month'],
                                  allWorkouts[i]['year'],
                                  caloriesBurned);
                          totalCaloriesBurned += caloriesBurned;
                          print("total: $totalCaloriesBurned");
                        }
                      }
                    }
                  },
                  child: Text(
                    'Calculate Calories Burned',
                    style: cardTextStyle,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class BigCardButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const BigCardButton(
      {super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: Container(
          width: 350,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 153, 169, 140),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [child],
          ),
        ),
      ),
    );
  }
}

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
