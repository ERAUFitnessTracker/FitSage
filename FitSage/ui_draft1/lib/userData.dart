import 'dart:ui';
import 'package:flutter/material.dart';
import 'DatabaseHelper.dart';

class UserDataPrint extends StatelessWidget {
  const UserDataPrint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 580,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            NameDisplay(),
            NameFromDatabase(),
            WeightDisplay(),
            WeightFromDatabase(),
            HeightDisplay(),
            HeightFromDatabase(),
            AgeDisplay(),
            AgeFromDatabase(),
            GenderDisplay(),
            GenderFromDatabase(),
          ],
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
    return const Padding(
      padding: EdgeInsets.all(0.0),
      child: Text(
        "NAME \n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ".SF UI Display",
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF3e2723),
          letterSpacing: 1.0,
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
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  (user['name']).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: ".SF UI Display",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF3e2723),
                    letterSpacing: 1.0,
                  ),
                ),
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

class WeightDisplay extends StatelessWidget {
  const WeightDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Text(
        "WEIGHT \n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ".SF UI Display",
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF3e2723),
          letterSpacing: 1.0,
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
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  (user['weight']).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: ".SF UI Display",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF3e2723),
                    letterSpacing: 1.0,
                  ),
                ),
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

class HeightDisplay extends StatelessWidget {
  const HeightDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Text(
        "HEIGHT \n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ".SF UI Display",
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF3e2723),
          letterSpacing: 1.0,
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
    return FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final users = snapshot.data!;
            if (users.isNotEmpty) {
              final user = users[0];
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  (user['height']).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: ".SF UI Display",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF3e2723),
                    letterSpacing: 1.0,
                  ),
                ),
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

class AgeDisplay extends StatelessWidget {
  const AgeDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0.0),
      child: Text(
        "AGE \n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ".SF UI Display",
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF3e2723),
          letterSpacing: 1.0,
        ),
      ),
    );
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
              return Padding(
                padding: EdgeInsets.all(0.0),
                child: Text(
                  (user['age']).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: ".SF UI Display",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF3e2723),
                    letterSpacing: 1.0,
                  ),
                ),
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

class GenderDisplay extends StatelessWidget {
  const GenderDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0.0),
      child: Text(
        "GENDER \n",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ".SF UI Display",
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: Color(0xFF3e2723),
          letterSpacing: 1.0,
        ),
      ),
    );
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
              return Padding(
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  (user['gender']).toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: ".SF UI Display",
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    color: Color(0xFF3e2723),
                    letterSpacing: 1.0,
                  ),
                ),
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
//           fontSize: 30.0,
//           fontWeight: FontWeight.bold,
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
//           fontWeight: FontWeight.bold,
//           fontStyle: FontStyle.normal,
//           color: Color(0xFF3e2723),
//           letterSpacing: 1.0,
//         ),
//       ),
//     );
//   }
// }
