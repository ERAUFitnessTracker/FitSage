import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'calculators.dart';
import 'DatabaseHelper.dart';
import 'event.dart';

class GoalTracker extends StatefulWidget {
  const GoalTracker({super.key});

  @override
  State<GoalTracker> createState() => _GoalTrackerState();
}

class _GoalTrackerState extends State<GoalTracker> {
  List<Color> gradientColors = [
    const Color.fromARGB(255, 205, 221, 191),
    const Color(0xFF99a98c),
    const Color.fromARGB(255, 205, 221, 191),
  ];

  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  bool showAvg = false;
  double weight = 0;
  double height = 0;
  int age = 0;
  String gender = '';
  String goal = '';
  double BMR = 0;
  double goalRange = 0;
  String goalPrint = '';
  double totalCalories = 0;
  double totalCalories1 = 0;
  double totalCalories2 = 0;
  double totalCalories3 = 0;
  double totalCalories4 = 0;
  double totalCalories5 = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              weight = (user['weight']);
              height = (user['height']);
              age = (user['age']);
              gender = (user['gender']);
              goal = (user['goal']);
              BMR = Calculators().calcBMR(weight, height, age, gender);
              goalRange =
                  Calculators().calcGoalRange(BMR, goal).roundToDouble();
              if (goal == 'Lose Weight') {
                goalPrint = 'Recommended Total Calories per day: < $goalRange';
              } else if (goal == 'Gain Weight') {
                goalPrint = 'Recommended Total Calories per day: $goalRange';
              } else if (goal == 'Maintain Weight') {
                goalPrint = 'Recommended Total Calories per day: > $goalRange';
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 60, 25, 10),
                        child: Card(
                          child: SizedBox(
                            height: 150,
                            width: 350,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: 130,
                                    width: 350,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 25, 0),
                                      child: LineChart(
                                        mainData(),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 5, 10, 10),
                                    child: Text(goalPrint,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                for (int i = 0; i < 5; i++)
                                  getCals(day - i, month, year, i),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }

  Widget getCals(int day, int month, int year, int i) {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.instance.queryEventsforDay(day, month, year),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final events = snapshot.data!;
            print(i);
            if (events.isNotEmpty) {
              final event = events[0];
              print(i);
              totalCalories = double.parse(event['totalCalories'].toString());
              double calBurned = 0;
              for (int j = 0; j < events.length; j++) {
                calBurned = events[j]['caloriesBurned'];
                totalCalories -= calBurned;
              }
              switch (i) {
                case 0:
                  totalCalories1 = totalCalories;
                  break;
                case 1:
                  totalCalories2 = totalCalories;
                  break;
                case 2:
                  totalCalories3 = totalCalories;
                  break;
                case 3:
                  totalCalories4 = totalCalories;
                  break;
                case 4:
                  totalCalories5 = totalCalories;
                  break;
              }
            }

            return Container();
          } else {
            return Container();
          }
        });
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text((DateTime.now().day - 4).toString(), style: style);
        break;
      case 2:
        text = Text((DateTime.now().day - 3).toString(), style: style);
        break;
      case 3:
        text = Text((DateTime.now().day - 2).toString(), style: style);
        break;
      case 4:
        text = Text((DateTime.now().day - 1).toString(), style: style);
        break;
      case 5:
        text = Text((DateTime.now().day).toString(), style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;

    if (value.toInt() == 0) {
      text = '0  -';
    } else if (value.toInt() == 500) {
      text = '500 -';
    } else if (value.toInt() == 1000) {
      text = '1000 -';
    } else if (value.toInt() == 1500) {
      text = '1500 -';
    } else if (value.toInt() == 2000) {
      text = '2000 -';
    } else if (value.toInt() == 2500) {
      text = '2500 -';
    } else if (value.toInt() == 3000) {
      text = '3000 -';
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.right);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xFFe9e6df),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xFFe9e6df),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 1,
      maxX: 5,
      minY: 0,
      maxY: 3000,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, totalCalories5),
            FlSpot(2, totalCalories4),
            FlSpot(3, totalCalories3),
            FlSpot(4, totalCalories2),
            FlSpot(5, totalCalories1)
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
