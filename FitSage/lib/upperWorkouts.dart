import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';
import 'event.dart';
import 'workout.dart';

class UpperModel extends WorkoutModel {
  String muscle = 'Upper Body';
  UpperModel(super.name, super.met, super.isSelected, super.description);
}

class UpperWorkouts extends StatefulWidget {
  const UpperWorkouts({super.key});

  @override
  State<UpperWorkouts> createState() => _UpperWorkoutsState();
}

class _UpperWorkoutsState extends State<UpperWorkouts> {
  List<UpperModel> workoutsUpper = [
    UpperModel("Push Ups (moderate)", 3.8, false, """
Duration: 8-12 reps for 2-3 sets


1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight, engage your core, and lower your body towards the ground by bending your arms.
3. Pause for a moment when your chest is just above the ground.
4. Push your body back up to the starting position by straightening your arms.
5. Repeat for 8-12 reps, aiming for 2-3 sets."""),
    UpperModel("Pull Ups (moderate)", 3.8, false, """
Duration: 5-10 reps for 2-3 sets

1. Find a pull up bar and grip it with your palms facing away from you and your hands slightly wider than shoulder-width apart.
2. Hang from the bar with your arms fully extended and your feet off the ground.
3. Engage your core and pull yourself up towards the bar by bending your arms and squeezing your shoulder blades together.
4. Pause when your chin is above the bar, then slowly lower yourself back down to the starting position.
5. Repeat for 5-10 reps, aiming for 2-3 sets."""),
    UpperModel("Dips (moderate)", 3.8, false, """
Duration: 5-10 reps for 2-3 sets

1. Find a parallel bar or dip station and grip it with your palms facing down and your hands slightly wider than shoulder-width apart.
2. Lift yourself up onto the bars and straighten your arms, keeping your feet off the ground.
3. Engage your core and lower yourself down towards the bars by bending your arms.
4. Pause when your upper arms are parallel to the ground, then push yourself back up to the starting position by straightening your arms.
5. Repeat for 5-10 reps, aiming for 2-3 sets."""),
    UpperModel("Wall Handstand (moderate)", 3.8, false, """
Duration: 10-20s for 2-3 sets

1. Stand facing a wall and place your hands on the ground about shoulder-width apart.
2. Kick your feet up and place them against the wall, with your toes pointing towards the ceiling.
3. Slowly walk your hands back towards the wall until your body is in a straight line from your hands to your feet.
4. Engage your core and hold this position for 10-20 seconds, or as long as you can maintain proper form.
5. Lower your feet back down to the ground and rest for 10-20 seconds before repeating for 2-3 sets."""),
    UpperModel("Push Ups (vigorous)", 8, false, """
Duration: 12-15 reps for 4-5 sets

1. Start in a high plank position with your hands slightly wider than shoulder-width apart and your feet together.
2. Keep your body straight, engage your core, and lower your body towards the ground by bending your arms.
3. Pause for a moment when your chest is just above the ground.
4. Push your body back up to the starting position by straightening your arms.
5. Repeat for 12-15 reps, aiming for 4-5 sets."""),
    UpperModel("Pull Ups (vigorous)", 8, false, """
Duration: 8-12 reps for 4-5 sets

1. Find a pull up bar and grip it with your palms facing away from you and your hands slightly wider than shoulder-width apart.
2. Hang from the bar with your arms fully extended and your feet off the ground.
3. Engage your core and pull yourself up towards the bar by bending your arms and squeezing your shoulder blades together.
4. Pause when your chin is above the bar, then slowly lower yourself back down to the starting position.
5. Repeat for 8-12 reps, aiming for 4-5 sets."""),
    UpperModel("Dips (vigorous)", 8, false, """
Duration: 8-12 reps for 4-5 sets

1. Find a parallel bar or dip station and grip it with your palms facing down and your hands slightly wider than shoulder-width apart.
2. Lift yourself up onto the bars and straighten your arms, keeping your feet off the ground.
3. Engage your core and lower yourself down towards the bars by bending your arms.
4. Pause when your upper arms are parallel to the ground, then push yourself back up to the starting position by straightening your arms.
5. Repeat for 8-12 reps, aiming for 4-5 sets."""),
    UpperModel("Wall Handstand (vigorous)", 8, false, """
Duration: muscle failure (as long as you can) for 2-3 sets

1. Stand facing a wall and place your hands on the ground about shoulder-width apart.
2. Kick your feet up and place them against the wall, with your toes pointing towards the ceiling.
3. Slowly walk your hands back towards the wall until your body is in a straight line from your hands to your feet.
4. Engage your core and hold this position until muscle failure (as long as you can).
5. Lower your feet back down to the ground and rest for 30-60 seconds before repeating for 2-3 sets."""),
  ];

  List<UpperModel> selectedWorkouts = [];
  final WorkoutPage _workoutPage = const WorkoutPage();

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
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                  itemCount: workoutsUpper.length,
                  itemBuilder: (BuildContext context, int index) {
                    return UpperWorkoutItem(
                      workoutsUpper[index].name,
                      workoutsUpper[index].muscle,
                      workoutsUpper[index].met,
                      workoutsUpper[index].isSelected,
                      workoutsUpper[index].description,
                      index,
                    );
                  },
                ),
              ),
            ),
          ),
          for (int i = 0;
              i <
                  _workoutPage
                      .printSelectedWorkoutDescription(
                          selectedWorkouts, context)
                      .length;
              i++)
            _workoutPage.printSelectedWorkoutDescription(
                selectedWorkouts, context)[i],
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
  Widget UpperWorkoutItem(String name, String muscle, double met,
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
              workoutsUpper[index].isSelected =
                  !workoutsUpper[index].isSelected;
              if (workoutsUpper[index].isSelected) {
                selectedWorkouts
                    .add(UpperModel(name, met, isSelected, description));
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
