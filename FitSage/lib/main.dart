import 'package:flutter/material.dart';
import 'package:FitSage/NutritionPage/NutritionPage.dart';

import 'package:FitSage/HomePage/HomePage.dart';
import 'Workout.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitSage',
      home: const MyHomePage(),
      theme: ThemeData().copyWith(
        scaffoldBackgroundColor: const Color(0xFFe9e6df),
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: const Color(0xFF99a98c)),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 1;

  final List<Widget> _pages = [
    const NutritionPage(),
    const HomePage(),
    const WorkoutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 153, 169, 140),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.food_bank_rounded,
              size: 40,
            ),
            label: 'Nutrition',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 40,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.fitness_center_rounded,
              size: 40,
            ),
            label: 'Workout',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
