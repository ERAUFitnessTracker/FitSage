// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

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
          padding: const EdgeInsets.only(top: 150.0),
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
        const Text(""),
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
      _selectedDay = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Card(
            color: const Color(0xFF99a98c),
            elevation: 4,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: TableCalendar(
                daysOfWeekHeight: 30,
                locale: "en_US",
                rowHeight: 50,
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
                focusedDay: DateTime.now(),
                firstDay: DateTime.utc(2010, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
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
                    color: Color.fromARGB(196, 233, 230, 223),
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
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
              ),
            ),
          ),
        ),
        if (_selectedDay != null) DayInformation(selectedDay: _selectedDay),
        if (_selectedDay == null) DayInformation(selectedDay: widget.today)
      ],
    );
  }
}

class DayInformation extends StatelessWidget {
  const DayInformation({
    super.key,
    required DateTime? selectedDay,
  }) : _selectedDay = selectedDay;

  final DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    var formattedDate = DateFormat('yMMMMEEEEd').format(_selectedDay!);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Material(
        elevation: 10,
        shadowColor: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: 350,
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(formattedDate,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
