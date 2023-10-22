import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Model_Classes/Attendance_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with TickerProviderStateMixin {
  bool isLoading = false;
  List<AttendanceItem> attendanceItems = [];
  String studentId = '';
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  double textSize = 16.0;

  @override
  void initState() {
    super.initState();
    retrieveStudentId();
  }

  Future<void> retrieveStudentId() async {
    final preferences = await SharedPreferences.getInstance();

    final storedStudentId = preferences.getString('student_id');

    setState(() {
      studentId = storedStudentId ?? '';
      fetchAttendanceData(studentId, selectedYear, selectedMonth);
    });
  }

  Future<void> fetchAttendanceData(
      String studentId, int year, int month) async {
    final preferences = await SharedPreferences.getInstance();

    preferences.setString('student_id', studentId);

    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
        'http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$year&month=$month');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];

        setState(() {
          attendanceItems =
              data.map((item) => AttendanceItem.fromJson(item)).toList();
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      isLoading = false;
    });
  }

  double getTextSize(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    // Adjust the text size based on the screen width
    if (screenWidth < 600) {
      return 14.0;
    } else if (screenWidth >= 600 && screenWidth < 900) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    textSize = getTextSize(context);
    return Scaffold(
      backgroundColor: olive1,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [olive0, olive1],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: olive6),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Student Attendance', style: TextStyle(color: olive6)),
      ),
      body: Column(
        children: [
          Container(
            height: 70,
            color: olive,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<int>(
                  dropdownColor: olive3,
                  iconEnabledColor: olive3,
                  value: selectedMonth,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                    });
                  },
                  items: List<int>.generate(12, (index) => index + 1)
                      .map<DropdownMenuItem<int>>(
                        (int value) {
                      final monthName = DateFormat.MMMM().format(
                        DateTime(selectedYear, value),
                      );
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(monthName,
                            style: TextStyle(
                                color: olive7,
                                fontWeight: FontWeight.w500,
                                fontSize: textSize)),
                      );
                    },
                  ).toList(),
                ),
                DropdownButton<int>(
                  dropdownColor: olive3,
                  iconEnabledColor: olive3,
                  value: selectedYear,
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedYear = newValue!;
                    });
                  },
                  items: List<int>.generate(
                      10, (index) => DateTime.now().year - index)
                      .map<DropdownMenuItem<int>>(
                        (int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString(),
                            style: TextStyle(
                                color: olive7,
                                fontWeight: FontWeight.w500,
                                fontSize: textSize)),
                      );
                    },
                  ).toList(),
                ),
                ElevatedButton(
                  onPressed: () {
                    fetchAttendanceData(studentId, selectedYear, selectedMonth);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(olive3),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(16.0)),
                  ),
                  child: Text(
                    'View',
                    style: TextStyle(
                      fontSize: textSize,
                      color: olive7,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
              child: SpinKitThreeInOut(
                size: 32.0,
                itemBuilder: (BuildContext context, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: index.isEven ? olive4 : olive6,
                    ),
                  );
                },
                controller: AnimationController(
                  vsync: this,
                  duration: const Duration(milliseconds: 1200),
                ),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(18.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: DateTime(selectedYear, selectedMonth + 1, 0).day,
              itemBuilder: (context, index) {
                final currentDate =
                DateTime(selectedYear, selectedMonth, index + 1);
                final attendanceItem = attendanceItems.firstWhere(
                      (item) =>
                  item.attendanceDate ==
                      currentDate.toString().split(' ')[0],
                  orElse: () => AttendanceItem(
                    attendanceId: '',
                    schoolId: '',
                    standardId: '',
                    studentId: '',
                    attendanceDate: '',
                    attended: '',
                    attendanceReason: '',
                    onDate: '',
                  ),
                );
                String status;
                if (attendanceItem.attended == '0') {
                  status = 'A';
                } else if (attendanceItem.attended == '1') {
                  status = 'P';
                } else {
                  status = 'N/A';
                }

                final isPresent = attendanceItem.attended == '1';
                final isAbsent = attendanceItem.attended == '0';

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => Container(


                        child: AlertDialog(
                          title: Container(
                              height: 40,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: olive4,

                              ),
                              child: Center(
                                child: Text(
                                  'Attendance Reason',
                                  style: TextStyle(
                                    color: olive0,
                                    fontSize: 15,
                                  ),
                                ),
                              )),
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${attendanceItem.attendanceReason}',style: TextStyle(
                                    color: olive6,
                                ),),
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK',
                                  style: TextStyle(color: olive6)),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      color: isAbsent
                          ? olive3
                          : (isPresent ? olive : olive4),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          DateFormat.E().format(currentDate),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: olive0,
                            fontSize: textSize,
                          ),
                        ),
                        Text(
                          currentDate.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: olive0,
                            fontSize: textSize,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: olive0,
                            fontSize: textSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}