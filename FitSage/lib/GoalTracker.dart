import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'calculators.dart';
import 'DatabaseHelper.dart';

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

  bool showAvg = false;
  double weight = 0;
  double height = 0;
  int age = 0;
  String gender = '';
  double BMR = 0;

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
              BMR = Calculators().calcBMR(weight, height, age, gender);
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.9,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 70, 25, 10),
                          child: Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: LineChart(
                                mainData(),
                              ),
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

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text((DateTime.now().day - 2).toString(), style: style);
        break;
      case 2:
        text = Text((DateTime.now().day - 1).toString(), style: style);
        break;
      case 3:
        text = Text((DateTime.now().day).toString(), style: style);
        break;
      case 4:
        text = Text((DateTime.now().day + 1).toString(), style: style);
        break;
      case 5:
        text = Text((DateTime.now().day + 2).toString(), style: style);
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
      text = '0';
    } else if (value.toInt() == 1500) {
      text = '1500';
    } else if (value.toInt() == 3000) {
      text = '3000';
    } else {
      return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
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
          spots: const [
            FlSpot(1, 2000),
            FlSpot(2, 1800),
            FlSpot(3, 1500),
            FlSpot(4, 2100),
            FlSpot(5, 1234)
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
