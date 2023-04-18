import 'package:flutter/material.dart';
import 'upperWorkouts.dart';
import 'lowerWorkouts.dart';

//import 'package:google_fonts/google_fonts.dart';

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  //This is where you create the MaterialApp. This is used to set constants for the whole app, like themes and properties
  @override
  Widget build(BuildContext context) {
    var cardTextStyle = Theme.of(context).textTheme.displaySmall!.copyWith(
          color: const Color.fromRGBO(255, 255, 255, 1),
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
                    'Upper Workouts',
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
                  'Lower Workouts',
                  style: cardTextStyle,
                ),
              ),
              // Upper(), --- I changed the buttons to each use the same Widget. this way we only need one class
              // Lower(),
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
