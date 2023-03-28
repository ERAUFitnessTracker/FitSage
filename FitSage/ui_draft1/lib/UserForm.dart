// ignore_for_file: must_be_immutable, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ui_draft1/main.dart';
import 'user.dart';
import 'DatabaseHelper.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _genderController;
  List<String> genderSelection = [
    'Male',
    'Female',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      height: 600,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //////// NAME ////////
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper.getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      if (users.isNotEmpty) {
                        final user = users[0];

                        String name =
                            (user['name'])[0].toString().toUpperCase() +
                                (user['name']).toString().substring(1);
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.user),
                              border: const OutlineInputBorder(),
                              hintText: name,
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name.';
                              }
                              final validChar = RegExp(r'^[a-zA-Z]$');
                              for (int i = 0; i < value.length; i++) {
                                if (!validChar.hasMatch(value[i])) {
                                  return 'Please enter your name.';
                                }
                              }
                              return null;
                            },
                          ),
                        );
                      } else {
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(LineAwesomeIcons.user),
                              border: OutlineInputBorder(),
                              hintText: 'Name',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Name',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name.';
                              }
                              final validChar = RegExp(r'^[a-zA-Z]$');
                              for (int i = 0; i < value.length; i++) {
                                if (!validChar.hasMatch(value[i])) {
                                  return 'Please enter your name.';
                                }
                              }
                              return null;
                            },
                          ),
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),

              const SizedBox(height: 10),

              //////// Weight ////////
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper.getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      if (users.isNotEmpty) {
                        final user = users[0];
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.weight),
                              border: const OutlineInputBorder(),
                              hintText: (user['weight']).toString(),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Weight (in lbs)',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your weight in lbs.';
                              }
                              if (double.tryParse(value) is! double) {
                                return 'Please enter your weight in lbs.';
                              }
                              return null;
                            },
                          ),
                        );
                      } else {
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _weightController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(LineAwesomeIcons.weight),
                              border: OutlineInputBorder(),
                              hintText: 'Weight',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Weight (lbs)',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your weight in lbs.';
                              }
                              if (double.tryParse(value) is! double) {
                                return 'Please enter your weight in lbs.';
                              }
                              return null;
                            },
                          ),
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),

              const SizedBox(height: 10),

              //////// Height ////////
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper.getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      if (users.isNotEmpty) {
                        final user = users[0];
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _heightController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.ruler),
                              border: const OutlineInputBorder(),
                              hintText: (user['height']).toString(),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Height (in)',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your height in inches.';
                              }
                              if (double.tryParse(value) is! double) {
                                return 'Please enter your weight in lbs.';
                              }
                              return null;
                            },
                          ),
                        );
                      } else {
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _heightController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(LineAwesomeIcons.ruler),
                              border: OutlineInputBorder(),
                              hintText: 'Height',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Height (in inches)',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your height in inches.';
                              }
                              if (double.tryParse(value) is! double) {
                                return 'Please enter your weight in lbs.';
                              }
                              return null;
                            },
                          ),
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),

              const SizedBox(height: 10),

              //////// Age ////////
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper.getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      if (users.isNotEmpty) {
                        final user = users[0];

                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(LineAwesomeIcons.running),
                              border: const OutlineInputBorder(),
                              hintText: (user['age']).toString(),
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Age',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your age.';
                              }
                              if (int.tryParse(value) is! int) {
                                return 'Please enter your age.';
                              }
                              return null;
                            },
                          ),
                        );
                      } else {
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          color: const Color(0xFFe9e6df),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _ageController,
                            decoration: const InputDecoration(
                              prefixIcon: Icon(LineAwesomeIcons.running),
                              border: OutlineInputBorder(),
                              hintText: 'Age',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 131, 129, 125)),
                              labelText: 'Age',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              floatingLabelAlignment:
                                  FloatingLabelAlignment.center,
                            ),
                            validator: (value) {
                              if (value == null) {
                                return 'Please enter your age.';
                              }
                              if (int.tryParse(value) is! int) {
                                return 'Please enter your age.';
                              }
                              return null;
                            },
                          ),
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),

              const SizedBox(height: 10),

              //////// Gender ////////
              FutureBuilder<List<Map<String, dynamic>>>(
                  future: DatabaseHelper.getUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final users = snapshot.data!;
                      if (users.isNotEmpty) {
                        final user = users[0];
                        String gender1 =
                            (user['gender'])[0].toString().toUpperCase() +
                                (user['gender']).toString().substring(1);
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 59,
                            color: const Color(0xFFe9e6df),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                prefixIcon:
                                    const Icon(LineAwesomeIcons.venus_mars),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                fillColor: const Color(0xFFe9e6df),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              dropdownColor: const Color(0xFFe9e6df),
                              hint: Text(
                                gender1,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 131, 129, 125)),
                              ),
                              items: genderSelection
                                  .map((gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _genderController = value as String;
                                });
                              },
                            ),
                          ),
                        );
                      } else {
                        return Material(
                          elevation: 10,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(4),
                          child: Container(
                            height: 59,
                            color: const Color(0xFFe9e6df),
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                labelText: 'Gender',
                                prefixIcon:
                                    const Icon(LineAwesomeIcons.venus_mars),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                fillColor: const Color(0xFFe9e6df),
                                floatingLabelAlignment:
                                    FloatingLabelAlignment.center,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              dropdownColor: const Color(0xFFe9e6df),
                              hint: const Text(
                                'Gender',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 131, 129, 125)),
                              ),
                              items: genderSelection
                                  .map((gender) => DropdownMenuItem<String>(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  _genderController = value as String;
                                });
                              },
                            ),
                          ),
                        );
                      }
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),

              const SizedBox(height: 50),

              //////// Button ////////
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final messenger = ScaffoldMessenger.of(context);
                      User user = User(
                        id: 0,
                        name: _nameController.text,
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                        age: int.parse(_ageController.text),
                        gender: _genderController.toString(),
                      );
                      int id;
                      String textForSnackBar;
                      if (await DatabaseHelper.instance.hasData()) {
                        id = await DatabaseHelper.instance.updateUser(user);
                        textForSnackBar = 'User $id updated!';
                      } else {
                        id = await DatabaseHelper.instance.createUser(user);
                        textForSnackBar = 'User added with ID: $id';
                      }
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text(textForSnackBar),
                        ),
                      );

                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileDataPage()));
                    } catch (e) {
                      if (kDebugMode) {
                        print(e);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF99a98c),
                      fixedSize: const Size(299.4, 50)),
                  child: Text(
                    'Confirm Changes',
                    style: GoogleFonts.firaSans(
                      textStyle: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
