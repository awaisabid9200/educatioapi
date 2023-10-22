import 'dart:io';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Screens/Attendence_Screen.dart';
import 'package:educatioapi/Screens/Events_Screen.dart';
import 'package:educatioapi/Screens/Exam_notes_screen.dart';
import 'package:educatioapi/Screens/LoginScreen.dart';
import 'package:educatioapi/Screens/Student_Profile.dart';
import 'package:educatioapi/Screens/Teacher_Detail_screen.dart';
import 'package:educatioapi/Screens/result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String studentName = '';
  String studentRollNo = '';

  @override
  void initState() {
    super.initState();
    fetchStudentData();
  }

  Future<void> fetchStudentData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      studentName = prefs.getString('student_name') ?? '';
      studentRollNo = prefs.getString('student_roll_no') ?? '';
      // print(studentName);
      // print(studentRollNo);
    });
  }

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          //show confirm dialogue
          //the return value will be from "Yes" or "No" options
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(olive4)),
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child: Text('No'),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(olive4)),
                onPressed: () {
                  // Navigator.of(context).pop(true);
                  SystemNavigator.pop();
                },

                //return true when click on "Yes"
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialouge had returned null, then return false
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        backgroundColor: olive1,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    olive6,
                    olive4,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 30),
                    title: Text('$studentName',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(color: olive0)),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '$studentRollNo',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: olive1),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Theme(
                                data: Theme.of(context).copyWith(
                                  dialogBackgroundColor:
                                      olive1, // Change the background color here
                                ),
                                child: AlertDialog(
                                  title: const Text('Confirmation',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: olive6)),
                                  content: const Text(
                                      'Are you sure you want to log out?',
                                      style: TextStyle(color: olive5)),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(
                                            context); // Close the dialogue box
                                        SharedPreferences sp =
                                            await SharedPreferences
                                                .getInstance();
                                        sp.clear();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignIn()),
                                        );
                                      },
                                      child: const Text('yes',
                                          style: TextStyle(color: olive6)),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No',
                                            style: TextStyle(color: olive6)))
                                  ],
                                ));
                          },
                        );
                      },
                      icon: Image.asset('assets/images/exit.png'),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    olive6,
                    olive4,
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: const BoxDecoration(
                    color: olive1,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(200))),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 30,
                  children: [
                    InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String id = sp.getString('student_id') ?? '';
                        sp.setString('student_id', id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PersonDataScreen()));
                      },
                      child:
                          itemDashboard('Profile', 'assets/images/profile.png'),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String id_t = sp.getString('school_id') ?? '';
                        sp.setString('school_id', id_t);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TeacherDetail()));
                      },
                      child:
                          itemDashboard('Teacher', 'assets/images/teacher.png'),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String id = sp.getString('student_id') ?? '';
                        sp.setString('student_id', id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttendanceScreen()));
                      },
                      child: itemDashboard(
                          'Attendance', ('assets/images/attendance.png')),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Result()));
                      },
                      child: itemDashboard(
                          'Result', 'assets/images/report_card.png'),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String id_IS = sp.getString('school_id') ?? '';
                        String standard_id = sp.getString('standard_id') ?? '';
                        sp.setString('school_id', id_IS);
                        sp.setString('standard_id', standard_id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExamNotes()));
                      },
                      child: itemDashboard('Exams', 'assets/images/exam.png'),
                    ),
                    InkWell(
                      onTap: () async {
                        SharedPreferences sp =
                            await SharedPreferences.getInstance();
                        String id_SE = sp.getString('school_id') ?? '';
                        sp.setString('school_id', id_SE);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EventScreen()));
                      },
                      child: itemDashboard(
                          'Notification', 'assets/images/calendar.png'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  itemDashboard(
    String title,
    String imagePath,
  ) =>
      Container(
          decoration: BoxDecoration(
            color: olive0,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //       offset: const Offset(0, 5),
            //       color: olive1,
            //       spreadRadius: 2,
            //       blurRadius: 5)
            // ]
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final imageSize = constraints.biggest.shortestSide * 0.5;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: imageSize,
                    height: imageSize,
                    child: Image.asset(imagePath),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    title.toUpperCase(),
                    style:
                        TextStyle(color: olive7, fontWeight: FontWeight.w500),
                  ),
                ],
              );
            },
          ));
}
