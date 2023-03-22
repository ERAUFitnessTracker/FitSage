import 'package:flutter/material.dart';
import 'package:ui_draft1/UserDataPrint.dart';
import 'UserForm.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar.dart';

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
      fit: StackFit.expand,
      children: [
        const CalendarPage(),
        Positioned(
          top: 40.0,
          right: 20.0,
          child: FloatingActionButton(
              backgroundColor: const Color(0xFF99a98c),
              child: const Icon(Icons.person_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage1()),
                );
              }),
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

class ProfilePage1 extends StatelessWidget {
  const ProfilePage1({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF99a98c),
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          //Column where all the elements will be
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: <Widget>[
                const UserDataPrint(),
                // const UserForm(),
                Expanded(
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfilePage2 extends StatelessWidget {
  const ProfilePage2({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'PROFILE',
          style: GoogleFonts.ubuntu(
            textStyle: const TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              color: Color(0xFFFFFFFF),
              letterSpacing: 3.0,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF99a98c),
      ),
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: <Widget>[
                const UserForm(),
                Expanded(
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
