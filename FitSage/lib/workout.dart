import 'package:FitSage/DatabaseHelper.dart';
import 'package:FitSage/coreWorkouts.dart';
import 'package:flutter/material.dart';
import 'upperWorkouts.dart';
import 'lowerWorkouts.dart';
import 'package:duration_picker/duration_picker.dart';
import 'calculators.dart';

//import 'package:google_fonts/google_fonts.dart';

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
                    List<int> allDurations = [];
                    List<double> allMET = [];

                    for (int i = 1; i < allWorkouts.length; i++) {
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
                            insetPadding: EdgeInsets.all(0),
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

                      if (time != null) {
                        allDurations.add(time.inMinutes);
                        double met = allWorkouts[i]['met'];
                        allMET.add(met);
                      }
                    }
                    for (int i = 0; i < allWorkouts.length - 1; i++) {
                      Calculators().caloriesBurned(userWeight,
                          allDurations.elementAt(i), allMET.elementAt(i));
                    }

                    // for (int i = 1; i < allWorkouts.length; i++) {
                    //   // ignore: use_build_context_synchronously
                    //   showDialog(
                    //       context: context,
                    //       builder: (BuildContext context) => Column(children: [

                    //             Padding(
                    //               padding: const EdgeInsets.fromLTRB(
                    //                   20, 100, 20, 10),
                    //               child: Center(
                    //                   child: Container(
                    //                 height: 20,
                    //                 width: 300,
                    //                 decoration: const BoxDecoration(
                    //                     color: Colors.white),
                    //                 child: SizedBox(
                    //                   child: Center(
                    //                     child: Text(
                    //                       'Workout $i ${allWorkouts[i]['workoutName']}',
                    //                       textAlign: TextAlign.center,
                    //                     ),
                    //                   ),
                    //                 ),
                    //               )),
                    //             ),
                    //             DurationPickerDialog(
                    //                 initialTime: Duration.zero,
                    //                 decoration: BoxDecoration(
                    //                     color: const Color(0xFFe9e6df),
                    //                     boxShadow: const [
                    //                       BoxShadow(
                    //                         spreadRadius: -200,
                    //                       )
                    //                     ],
                    //                     borderRadius:
                    //                         BorderRadius.circular(10))),
                    //           ]),
                    //       barrierColor: Colors.transparent);
                    // }
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
