import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:FitSage/calculators.dart';
import 'package:FitSage/DatabaseHelper.dart';

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
  double bmr = 0;
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
              bmr = Calculators().calcBMR(weight, height, age, gender);
              goalRange =
                  Calculators().calcGoalRange(bmr, goal).roundToDouble();
              if (goal == 'Lose Weight') {
                goalPrint = 'Calories to Lose Weight: < $goalRange';
              } else if (goal == 'Gain Weight') {
                goalPrint = 'Calories to Gain Weight: > $goalRange';
              } else if (goal == 'Maintain Weight') {
                goalPrint = 'Calories to Maintain Weight: = $goalRange';
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Material(
                        elevation: 10,
                        shadowColor: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(4),
                        child: SizedBox(
                          height: 170,
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
                                        10, 5, 40, 0),
                                    child: LineChart(
                                      mainData(),
                                    ),
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                                  child: Text('Goal Tracker',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(5, 0, 8, 0),
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: FloatingActionButton(
                                      heroTag: 'bt2',
                                      backgroundColor:
                                          const Color(0xFF99a98c),
                                      child: const Icon(
                                        Icons.refresh,
                                        size: 15,
                                      ),
                                      onPressed: () => setState(() {
                                        for (int i = 0; i < 5; i++) {
                                          getCals(day - i, month, year, i);
                                        }
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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

  Future<void> getCals(int day, int month, int year, int i) async {
    List<Map<String, dynamic>> events =
        await DatabaseHelper.instance.queryEventsforDay(day, month, year);

    if (events.isNotEmpty) {
      double totalCalories =
          double.parse(events[0]['totalCalories'].toString());
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
          return const FlLine(
            color: Color(0xFFe9e6df),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xFFe9e6df),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
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
      extraLinesData: ExtraLinesData(
        horizontalLines: [
          HorizontalLine(
              y: goalRange,
              color: const Color(0xFF99a98c),
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topCenter,
                labelResolver: (value) => goalPrint,
                style: const TextStyle(
                  color: Color(0xFF99a98c),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(1, totalCalories5),
            FlSpot(2, totalCalories4),
            FlSpot(3, totalCalories3),
            FlSpot(4, totalCalories2),
            FlSpot(5, totalCalories1),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            cutOffY: 0,
            applyCutOffY: true,
            show: false,
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
