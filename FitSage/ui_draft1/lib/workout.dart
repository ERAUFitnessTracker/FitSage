import 'package:flutter/material.dart';
import 'upperWorkouts.dart';
import 'lowerWorkouts.dart';
//import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const WorkoutPage()); // Run the app

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  //This is where you create the MaterialApp. This is used to set constants for the whole app, like themes and properties
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Workout',
      home: WorkoutHome(),
    );
  }
}

class WorkoutHome extends StatelessWidget {
  const WorkoutHome({super.key});

  //Making the Home page of the Workouts :3
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
          body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Upper(),
              Lower(),
            ],
          ),
        ),
      )),
    );
  }
}

class Lower extends StatelessWidget {
  const Lower({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LowerWorkouts(),
          ),
        );
      },
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Lower Workouts"),
        ),
      ),
    );
  }
}

class Upper extends StatelessWidget {
  const Upper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const UpperWorkouts(),
          ),
        );
      },
      child: const Card(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Upper Workouts"),
        ),
      ),
    );
  }
}
