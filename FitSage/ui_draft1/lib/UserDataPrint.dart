import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ui_draft1/main.dart';
import 'DatabaseHelper.dart';
import 'UserForm.dart';

class UserDataPrint extends StatelessWidget {
  const UserDataPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 600,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NameFromDatabase(),
            SizedBox(height: 10),
            WeightFromDatabase(),
            SizedBox(height: 10),
            HeightFromDatabase(),
            SizedBox(height: 10),
            AgeFromDatabase(),
            SizedBox(height: 10),
            GenderFromDatabase(),
            SizedBox(height: 50),
            EditButton(),
          ],
        ),
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
              return const Text("No users found");
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class WeightFromDatabase extends StatelessWidget {
  const WeightFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              return const Text("No users found");
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class HeightFromDatabase extends StatelessWidget {
  const HeightFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              return const Text("No users found");
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class AgeFromDatabase extends StatelessWidget {
  const AgeFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
              return const Text("No users found");
            }
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}

class GenderFromDatabase extends StatelessWidget {
  const GenderFromDatabase({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                        prefixIcon: const Icon(LineAwesomeIcons.weight),
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
              return const Text("No users found");
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
            MaterialPageRoute(builder: (context) => const ProfilePage2()));
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

// class BMIDisplay extends StatelessWidget {
//   const BMIDisplay({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
//       child: Text(
//         "Body Mass Index (BMI) \n",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontFamily: ".SF UI Display",
//           fontSize: 25.0,
//           fontWeight: FontWeight.w600,
//           fontStyle: FontStyle.normal,
//           color: Color(0xFF3e2723),
//           letterSpacing: 1.0,
//         ),
//       ),
//     );
//   }
// }
//
// class BMIFromDatabase extends StatelessWidget {
//   const BMIFromDatabase({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.all(0.0),
//       child: Text(
//         "BMI \n",
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontFamily: ".SF UI Display",
//           fontSize: 15,
//           fontWeight: FontWeight.w600,
//           fontStyle: FontStyle.normal,
//           color: Color(0xFF3e2723),
//           letterSpacing: 1.0,
//         ),
//       ),
//     );
//   }
// }







