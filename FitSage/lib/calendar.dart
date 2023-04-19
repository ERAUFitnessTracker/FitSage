// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'DatabaseHelper.dart';

class SelectedWorkouts {
  String name, muscle;

  SelectedWorkouts(this.name, this.muscle);
}

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
          padding: const EdgeInsets.only(top: 130.0),
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
                  print('selected workout $i: $selectedWorkout');
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
                          rowHeight: 40,
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
                          eventLoader: (day) => selectedWorkouts),
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

                  List<String> selectedWorkout = [];

                  for (int i = 0; i < selectedWorkouts.length; i++) {
                    var select = selectedWorkouts[i];
                    String workoutString =
                        '${select['workoutName']}  ${select['workoutMuscle']}';

                    selectedWorkout.add(workoutString);
                  }

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Material(
                      elevation: 10,
                      shadowColor: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                      child: SizedBox(
                        width: 350,
                        height: 100,
                        child: ScrollConfiguration(
                          //makes the boundary color green
                          behavior:
                              const ScrollBehavior(), // From this behaviour you can change the behaviour
                          child: GlowingOverscrollIndicator(
                            axisDirection: AxisDirection.down,
                            color: const Color(0xFF99a98c),
                            child: ListView.builder(
                              itemCount: selectedWorkout.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Text(selectedWorkout[index],
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        textStyle: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 0.0,
                                    )));
                              },
                            ),
                          ),
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
