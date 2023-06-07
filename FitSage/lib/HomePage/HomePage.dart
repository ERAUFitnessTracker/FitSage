// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'calendar.dart';
import 'package:FitSage/ProfilePage/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 30, 20),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
                backgroundColor: const Color(0xFF99a98c),
                child: const Icon(Icons.person_rounded),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileDataPage()),
                  );
                }),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 40),
              child: Calendar(today: today),),
        ),
      ],
    );
  }
}