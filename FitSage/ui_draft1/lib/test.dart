import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProfilePage());
}

//Trial
@override
Widget build(BuildContext context) {
  return MaterialApp(
    theme: ThemeData(
      primarySwatch: const MaterialColor(0xFFFFFFFF, <int, Color>{
        50: Color(0xFF111111),
      }),
    ),
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: const MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: unused_element
  void _incrementCounter() {
    //This is just a placeholder :3
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe9e6df),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          //Column where all the elements will be
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              ProfileText(),
              WhiteBoxForData(),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: BackButton(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: FloatingActionButton(
        onPressed: null,
        tooltip: 'Back To Home',
        backgroundColor: Color(0xFF6b7a5f),
        child: Icon(Icons.close),
      ),
    );
  }
}

//This is where the actual information of the user will be
class WhiteBoxForData extends StatelessWidget {
  const WhiteBoxForData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final name, weight, height, bmi;
    return SizedBox(
      width: 370,
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          NameDisplay(),
          SizedBox(height: 5), //Adds constant spacing between fields
          NameFromDatabase(),
          SizedBox(height: 5), //Adds constant spacing between fields
          WeightDisplay(),
          SizedBox(height: 5), //Adds constant spacing between fields
          WeightFromDatabase(),
          SizedBox(height: 5), //Adds constant spacing between fields
          HeightDisplay(),
          SizedBox(height: 5), //Adds constant spacing between fields
          HeightFromDatabase(),
          SizedBox(height: 5), //Adds constant spacing between fields
          BMIDisplay(),
          SizedBox(height: 5), //Adds constant spacing between fields
          BMIFromDatabase(),
          SizedBox(height: 5), //Adds constant spacing between fields
        ],
      ),
    );
  }
}

class NameFromDatabase extends StatelessWidget {
  const NameFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3EF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6b7a5f),
            width: 2.0,
          ),
        ),
        child: const SizedBox(
          width: 350,
          height: 30,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 2, 0.0, 0.0),
            child: Text(
              "User \n",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: ".SF UI Display",
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xFF384031),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BMIFromDatabase extends StatelessWidget {
  const BMIFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3EF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6b7a5f),
            width: 2.0,
          ),
        ),
        child: const SizedBox(
          width: 350,
          height: 30,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 2, 0.0, 0.0),
            child: Text(
              "BMI :3 \n",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: ".SF UI Display",
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xFF384031),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HeightFromDatabase extends StatelessWidget {
  const HeightFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3EF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6b7a5f),
            width: 2.0,
          ),
        ),
        child: const SizedBox(
          width: 350,
          height: 30,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 2, 0.0, 0.0),
            child: Text(
              "Height \n",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: ".SF UI Display",
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xFF384031),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeightFromDatabase extends StatelessWidget {
  const WeightFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F3EF),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF6b7a5f),
            width: 2.0,
          ),
        ),
        child: const SizedBox(
          width: 350,
          height: 30,
          child: Padding(
            padding: EdgeInsets.fromLTRB(15.0, 2, 0.0, 0.0),
            child: Text(
              "Weight \n",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontFamily: ".SF UI Display",
                fontSize: 20,
                fontStyle: FontStyle.normal,
                color: Color(0xFF384031),
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BMIDisplay extends StatelessWidget {
  const BMIDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "Body Mass Index",
        textAlign: TextAlign.start,
        style: GoogleFonts.robotoMono(
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Color(0xFF6b7a5f),
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}

class HeightDisplay extends StatelessWidget {
  const HeightDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "Height",
        textAlign: TextAlign.start,
        style: GoogleFonts.robotoMono(
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Color(0xFF6b7a5f),
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}

class WeightDisplay extends StatelessWidget {
  const WeightDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "Weight",
        textAlign: TextAlign.start,
        style: GoogleFonts.robotoMono(
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Color(0xFF6b7a5f),
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}

class NameDisplay extends StatelessWidget {
  const NameDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        "Name",
        textAlign: TextAlign.start,
        style: GoogleFonts.robotoMono(
          textStyle: const TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.normal,
            color: Color(0xFF6b7a5f),
            letterSpacing: 0.0,
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
      height: 107,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the text
        children: [
          Stack(
            children: [
              Text(
                "PROFILE",
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoMono(
                  textStyle: const TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF505B47),
                    letterSpacing: 3.0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
