import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'navitems.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  String _email = '';
  String _phone = '';
  List<String> _professions = ['Developer', 'Designer', 'Other'];
  late String _selectedProfession = 'Developer';


  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = {
      'name': _name,
      'password': _password,
      'email': _email,
      'phone': _phone,
      'profession': _selectedProfession, // fix typo here
    };
    prefs.setString('userData', json.encode(userData));

    final storedData = prefs.getString('userData');
    if (storedData != null) {
      final storedUserData = json.decode(storedData);
      if (_name == storedUserData['name'] &&
          _password == storedUserData['password'] &&
          _email == storedUserData['email'] &&
          _phone == storedUserData['phone'] &&
          _selectedProfession == storedUserData['profession']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NavItems()),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invalid Credentials'),
            content: const Text('Please enter valid credentials.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Sign up',style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text('Create an Account its Free',style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                )),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _name = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _password = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _email = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _phone = value!;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: DropdownButtonFormField(
                            value: _selectedProfession,
                            items: _professions.map((profession) {
                              return DropdownMenuItem(
                                value: profession,
                                child: Text(profession),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedProfession = value!;
                              });
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
                        child: Center(
                          child: SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0, backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _saveData();
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text('Signup'),

                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Already have an account?',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
                  ),
                ),
                TextButton(onPressed: () {
                  const snackBar = SnackBar(
                    content: Text('This page is currently under development'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }, child: const Text('Login'))
              ],
            ),
          ],
        )
    );
  }
}

