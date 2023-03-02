// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'WhiteBoxForData.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Draft 2',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
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
      backgroundColor: const Color(0xFFe9e6df),
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

class NutritionPage extends StatelessWidget {
  const NutritionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Nutrition Menu',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 40.0,
          right: 20.0,
          child: FloatingActionButton(
              backgroundColor: const Color(0xFF99a98c),
              child: const Icon(Icons.person_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }),
        ),
        Center(
          child: Text(
            'Home Page',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ],
    );
  }
}

class WorkoutPage extends StatelessWidget {
  const WorkoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Workout Menu',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          //Column where all the elements will be
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: ListView(
              children: <Widget>[
                const ProfileText(),
                const WhiteBoxForData(),
                Expanded(
                    child: Align(
                  heightFactor: 1.18,
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    tooltip: 'Back To Home',
                    backgroundColor: const Color(0xFF99a98c),
                    child: const Icon(Icons.close),
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileText extends StatelessWidget {
  const ProfileText({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Card(
          color: const Color(0xFF99a98c),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the text
              children: [
                Stack(
                  children: [
                    const Text(
                      "PROFILE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: ".SF UI Display",
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Color(0xFFFFFFFF),
                        letterSpacing: 3.0,
                      ),
                    ),
                    Text(
                      "PROFILE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: ".SF UI Display",
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal,
                        color: Colors.white.withOpacity(0.2),
                        letterSpacing: 3.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
