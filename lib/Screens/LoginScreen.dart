import 'dart:async';
import 'dart:convert';

import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:educatioapi/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;

  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter username and password')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String url = ConstValue.LOGIN_URL;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {'student_user_name': username, 'student_password': password},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData.containsKey('data') && responseData['data'] != null) {
          final data = responseData['data'];

          // Store the user data in shared preferences
          final prefs = await SharedPreferences.getInstance();
          String standard_id = data['student_standard'].toString();
          print(standard_id);
          prefs.setString('standard_id', standard_id);
          prefs.setBool('isUserLogin', true);
          prefs.setString('student_name', data['student_name']);
          prefs.setString('student_id', data['student_id']);
          prefs.setString('school_id', data['school_id']);

          prefs.setString('student_roll_no', data['student_roll_no']);
          prefs.setString('student_birthdate', data['student_birthdate']);
          prefs.setString('student_branch', data['student_branch']);
          prefs.setString('student_division', data['student_division']);
          prefs.setString('student_batch', data['student_batch']);

          // Navigate to the next screen
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));

          showLoaderDialog(context);
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successfully')),
          );
        } else {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Wrong username or password')),
          );
        }
      } else {
        // Show an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred')),
        );
      }
    } catch (error) {
      // Handle the error
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: olive1,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isDesktop(context))
              Center(
                child: Container(
                  height: 500,
                  width: 450,
                  decoration: BoxDecoration(
                      color: olive0,
                      boxShadow: [
                        BoxShadow(
                          color: olive3.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/SU.png',
                        height: 100,
                        width: 100,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            cursorColor: olive7,
                            controller: _usernameController,
                            decoration: InputDecoration(
                                labelText: 'username',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: olive5,
                                ),
                                hoverColor: olive5,
                                labelStyle: TextStyle(color: olive5),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: olive5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: olive5),
                                  borderRadius: BorderRadius.circular(5),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: 40,
                          child: TextFormField(
                            cursorColor: olive7,
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: 'password',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                  child: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: olive4,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: olive5,
                                ),
                                hoverColor: olive5,
                                labelStyle: TextStyle(color: olive5),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: olive5),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: olive5),
                                  borderRadius: BorderRadius.circular(5),
                                )),
                            obscureText: _obscurePassword,
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Container(
                        width: 250,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: olive5,
                          ),
                          onPressed: _isLoading
                              ? null
                              : () {
                            showLoaderDialog(context);
                            _login().then((_) {});
                          },
                          child: _isLoading
                              ? Container()
                          //   ? SpinKitWave(
                          //   color: Colors.blue,
                          //   size: 32.0,
                          // )
                              : Text('Login'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (isMobile(context))
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                        'assets/images/SU.png',
                        height: 100,
                        width: 100,
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        cursorColor: olive7,
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: 'username',
                            prefixIcon: Icon(
                              Icons.person,
                              color: olive5,
                            ),
                            hoverColor: olive5,
                            labelStyle: TextStyle(color: olive5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: olive5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: olive5),
                              borderRadius: BorderRadius.circular(5),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      height: 40,
                      child: TextFormField(
                        cursorColor: olive7,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            labelText: 'password',
                            focusColor: olive4,
                            fillColor: olive4,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                              child: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: olive4,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: olive5,
                            ),
                            hoverColor: olive5,
                            labelStyle: TextStyle(color: olive5),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: olive5),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: olive5),
                              borderRadius: BorderRadius.circular(5),
                            )),
                        obscureText: _obscurePassword,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Container(
                    width: 250,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: olive5,
                      ),
                      onPressed: _isLoading ? null : _login,
                      child: _isLoading
                          ? Container()
                      //   ? SpinKitWave(
                      //   color: Colors.blue,
                      //   size: 32.0,
                      // )
                          : Text('Login'),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

Future<void> showLoaderDialog(BuildContext context) {
  // Create a Completer to handle the loading completion
  Completer<void> completer = Completer<void>();

  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          color: olive4,
        ),
        Container(
          margin: EdgeInsets.only(left: 7),
          child: Text(
            "Loading...",
            style: TextStyle(color: olive4),
          ),
        ),
      ],
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  // Simulate the loading process
  // Replace this with your actual data loading logic
  loadData().then((_) {
    // Complete the completer when the data has loaded
    completer.complete();

    // Delay the dismissal of the dialog by a duration of your choice
    // For example, 2 seconds
    const duration = Duration(seconds: 2);
    Timer(duration, () {
      Navigator.of(context).pop(); // Dismiss the dialog
    });
  });

  // Return the completer's future
  return completer.future;
}

// Simulated data loading function
Future<void> loadData() async {
  // Replace this with your actual data loading logic
  await Future.delayed(Duration(seconds: 2));
}