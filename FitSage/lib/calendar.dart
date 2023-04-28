// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'DatabaseHelper.dart';
import 'package:intl/intl.dart';

import 'event.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9e6df),
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              content(),
              const Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget content() {
    return Column(
      children: [
        Calendar(today: today),
      ],
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({
    super.key,
    required this.today,
  });

  final DateTime today;

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends State<Calendar> {
  DateTime? _selectedDay;
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDay == null) {
        _selectedDay = selectedDay;
      } else if (_selectedDay == selectedDay) {
        _selectedDay = null;
      } else if (_selectedDay != null) {
        _selectedDay = selectedDay;
      }
    });
  }

  var selectedWorkout = [];

  @override
  Widget build(BuildContext context) {
    int day, month, year;
    if (_selectedDay != null) {
      day = _selectedDay!.day;
      month = _selectedDay!.month;
      year = _selectedDay!.year;
    } else {
      day = 1;
      month = 1;
      year = 2010;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FutureBuilder<List<Map<String, dynamic>>>(
            future: DatabaseHelper.instance.queryEventsforDay(day, month, year),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final selectedWorkouts = snapshot.data!;

                for (int i = 0; i < selectedWorkouts.length; i++) {
                  selectedWorkout.add(selectedWorkouts[i]);
                }

                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Card(
                    color: const Color(0xFF99a98c),
                    elevation: 4,
                    margin: const EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TableCalendar(
                        daysOfWeekHeight: 30,
                        rowHeight: 34,
                        locale: "en_US",
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          headerPadding: const EdgeInsets.all(1),
                          titleTextStyle: const TextStyle(
                            color: Color.fromARGB(255, 46, 51, 42),
                            fontFamily: ".SF UI Display",
                            fontSize: 20,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFe9e6df),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        sixWeekMonthsEnforced: true,
                        focusedDay: DateTime.now(),
                        firstDay: DateTime.utc(2010, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        calendarStyle: const CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Color.fromARGB(183, 233, 230, 223),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xFFe9e6df),
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle: TextStyle(
                            color: Color(0xFFe9e6df),
                          ),
                          outsideTextStyle: TextStyle(
                            color: Color.fromARGB(113, 233, 230, 223),
                          ),
                          weekendTextStyle: TextStyle(
                            color: Color(0xFFe9e6df),
                          ),
                          todayTextStyle: TextStyle(
                            color: Color(0xFF99a98c),
                          ),
                          selectedTextStyle: TextStyle(
                            color: Color(0xFF99a98c),
                          ),
                        ),
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        // ignore: no_leading_underscores_for_local_identifiers
                      ),
                    ),
                  ),
                );
              } else {
                return const CircularProgressIndicator();
              }
            }),
        if (_selectedDay != null)
          FutureBuilder<List<Map<String, dynamic>>>(
              future:
                  DatabaseHelper.instance.queryEventsforDay(day, month, year),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final selectedWorkouts = snapshot.data!;
                  List<Event> workoutsForDay = [];
                  for (int i = 0; i < selectedWorkouts.length; i++) {
                    var select = selectedWorkouts[i];
                    if (select['workoutName'].toString().isNotEmpty) {
                      Event workout = Event(
                          workoutName: select['workoutName'],
                          workoutMuscle: select['workoutMuscle'],
                          met: select['met'],
                          day: select['day'],
                          month: select['month'],
                          year: select['year'],
                          totalCalories: select['totalCalories'],
                          caloriesBurned: select['caloriesBurned']);
                      workoutsForDay.add(workout);
                    }
                  }
                  double totalCaloriesBurned = 0;
                  for (int i = 0; i < selectedWorkouts.length; i++) {
                    var select = selectedWorkouts[i];
                    totalCaloriesBurned += select['caloriesBurned'];
                  }
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        width: 350,
                        height: 170,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              DateFormat('yMMMMEEEEd').format(_selectedDay!),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 20, 0),
                                child: ScrollConfiguration(
                                  behavior:
                                      const ScrollBehavior(), // From this behaviour you can change the behaviour
                                  child: GlowingOverscrollIndicator(
                                    axisDirection: AxisDirection.down,
                                    color: const Color(
                                        0xFF99a98c), // You can change your splash color
                                    child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 10),
                                        itemCount: workoutsForDay.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: 40,
                                            child: Card(
                                              color: const Color(0xFF99a98c),
                                              child: Center(
                                                child: Text(
                                                  '${workoutsForDay[index].workoutName}   (${workoutsForDay[index].workoutMuscle})',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    decoration: workoutsForDay[
                                                                    index]
                                                                .caloriesBurned !=
                                                            0
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : null,
                                                    decorationThickness: 2,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            if (workoutsForDay.isEmpty)
                              if (_selectedDay!.day == DateTime.now().day &&
                                  _selectedDay!.month == DateTime.now().month &&
                                  _selectedDay!.year == DateTime.now().year &&
                                  selectedWorkouts.isNotEmpty)
                                Text(
                                  'Calorie Intake: ${selectedWorkouts[0]['totalCalories']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              else
                                const Text(
                                  'Calorie Intake: 0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                            else if (workoutsForDay.isNotEmpty)
                              Text(
                                'Calorie Intake: ${workoutsForDay[0].totalCalories}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            const SizedBox(height: 10),
                            if (workoutsForDay.isEmpty)
                              if (_selectedDay!.day == DateTime.now().day &&
                                  _selectedDay!.month == DateTime.now().month &&
                                  _selectedDay!.year == DateTime.now().year &&
                                  selectedWorkouts.isNotEmpty)
                                Text(
                                  'Calories Burned: ${selectedWorkouts[0]['caloriesBurned']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                )
                              else
                                const Text(
                                  'Calories Burned: 0',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                            else if (workoutsForDay.isNotEmpty)
                              Text(
                                'Calories Burned: $totalCaloriesBurned',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
      ],
    );
  }
}
