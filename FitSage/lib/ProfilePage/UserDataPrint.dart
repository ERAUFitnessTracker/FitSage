// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:FitSage/ProfilePage/ProfilePage.dart';
import 'package:FitSage/ProfilePage/BiometricInput.dart';
import '../DatabaseHelper.dart';
import '../calculators.dart';

class UserDataPrint extends StatelessWidget {
  const UserDataPrint({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 0, 25.0, 0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 10,
            children: [
              NameFromDatabase(),
              WeightFromDatabase(),
              HeightFromDatabase(),
              AgeFromDatabase(),
              GenderFromDatabase(),
              GoalFromDatabase(),
              BMIFromDatabase(),
              BFPFromDatabase(),
              const EditButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget NameFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              String name = (user['name'])[0].toString().toUpperCase() +
                  (user['name']).toString().substring(1);
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: SizedBox(
                      height: 59,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(LineAwesomeIcons.user),
                          labelText: 'Name',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const OutlineInputBorder(),
                          hintText: name,
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: SizedBox(
                      height: 59,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(LineAwesomeIcons.user),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                          hintText: 'Name',
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget WeightFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: SizedBox(
                      height: 59,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(LineAwesomeIcons.weight),
                          labelText: 'Weight (lbs)',
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: const OutlineInputBorder(),
                          hintText: user['weight'].toString(),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: SizedBox(
                      height: 59,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(LineAwesomeIcons.weight),
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                          hintText: 'Weight (lbs)',
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget HeightFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.ruler),
                        labelText: 'Height (in)',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: user['height'].toString(),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.ruler),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: 'Height (in)',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget AgeFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.running),
                        labelText: 'Age',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: user['age'].toString(),
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.running),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: 'Age',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget GenderFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              String gender = (user['gender'])[0].toString().toUpperCase() +
                  (user['gender']).toString().substring(1);
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.venus_mars),
                        labelText: 'Gender',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: gender,
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.venus_mars),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: 'Gender',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget GoalFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              String goal = (user['goal'])[0].toString().toUpperCase() +
                  (user['goal']).toString().substring(1);
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.bullseye),
                        labelText: 'Goal',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: goal,
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.bullseye),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: 'Goal',
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

// ignore: must_be_immutable
  Widget BMIFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              double weight = user['weight'];
              double height = user['height'];
              double BMI = Calculators().calcBMI(weight, height);
              String BMIType = BiometricInput(
                      weight: user['weight'],
                      height: user['height'],
                      age: user['age'],
                      gender: user['gender'])
                  .bmiType(BMI);

              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.bar_chart),
                        labelText: 'Body Mass Index',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: "$BMIType: ${BMI.toStringAsPrecision(4)}",
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.bar_chart),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: "Body Mass Index",
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }

  Widget BFPFromDatabase() {
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              int age = user['age'];
              String gender = (user['gender'])[0].toString().toUpperCase() +
                  (user['gender']).toString().substring(1);
              double BMI =
                  Calculators().calcBMI(user['weight'], user['height']);
              double BFP = Calculators().calcBFP(gender, age, BMI);
              String BFPType = BiometricInput(
                      weight: user['weight'],
                      height: user['height'],
                      age: user['age'],
                      gender: user['gender'])
                  .bfpType(BFP);

              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(LineAwesomeIcons.percent),
                        labelText: 'Body-Fat Percentage',
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: "$BFPType: ${BFP.toStringAsPrecision(3)}%",
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                alignment: Alignment.center,
                children: [
                  Material(
                    elevation: 10,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFFe9e6df),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        prefixIcon: Icon(LineAwesomeIcons.percent),
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        hintText: "Body-Fat Percentage",
                      ),
                      readOnly: true,
                    ),
                  ),
                ],
              );
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ProfileFormPage()));
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF99a98c),
          fixedSize: const Size(299.4, 50)),
      child: Text(
        'Edit Profile',
        style: GoogleFonts.firaSans(
          textStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            letterSpacing: 0.0,
          ),
        ),
      ),
    );
  }
}
