import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'user.dart';
import 'DatabaseHelper.dart';
import 'userData.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 580,
      child: Card(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your name.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Weight (in lbs)',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your weight.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (in inches)',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your height.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                ),
                validator: (value) {
                  if (value== null) {
                    return 'Please enter your age.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: InputDecoration(
                  labelText: 'Gender',
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter your gender.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      _nameController.clear();
                      _weightController.clear();
                      _heightController.clear();
                      _ageController.clear();
                      _genderController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF99a98c),
                    ),
                    child: const Text('Clear'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      int lastID = 0;
                      while (!(await DatabaseHelper.instance.isIDEmpty(lastID))) {
                        lastID++;
                      }

                      try {
                        if (_formKey.currentState!.validate()) {
                          User user = User(
                            id: lastID,
                            name: _nameController.text,
                            weight: double.parse(_weightController.text),
                            height: double.parse(_heightController.text),
                            age: int.parse(_ageController.text),
                            gender: _genderController.text,
                          );
                          int id = await DatabaseHelper.instance.insert(user);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('User added with ID: $id'),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF99a98c),
                    ),
                    child: const Text('Confirm'),
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