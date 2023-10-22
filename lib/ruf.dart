// // // // import 'package:flutter/material.dart';
// // // // import 'package:http/http.dart' as http;
// // // // import 'package:shared_preferences/shared_preferences.dart';
// // // //
// // // //
// // // // class AttendanceScreen extends StatefulWidget {
// // // //   @override
// // // //   _AttendanceScreenState createState() => _AttendanceScreenState();
// // // // }
// // // //
// // // // class _AttendanceScreenState extends State<AttendanceScreen> {
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     fetchAttendanceData('student_id', 2023, 6);
// // // //   }
// // // //
// // // //   Future<void> fetchAttendanceData(String studentId, int year, int month) async {
// // // //     final url = Uri.parse('http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$year&month=$month');
// // // //     SharedPreferences preferences = await SharedPreferences.getInstance();
// // // //      String student_id = preferences.getString('student_id') ?? '';
// // // //      print(student_id);
// // // //
// // // //     try {
// // // //       final response = await http.get(url);
// // // //
// // // //       if (response.statusCode == 200) {
// // // //         // Successful API call
// // // //         final responseData = response.body;
// // // //         // Process the responseData as needed
// // // //         print(responseData);
// // // //       } else {
// // // //         // Handle API error
// // // //         print('Error: ${response.statusCode}');
// // // //       }
// // // //     } catch (e) {
// // // //       // Handle network or other errors
// // // //       print('Error: $e');
// // // //     }
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text('Attendance'),
// // // //       ),
// // // //       body: Center(
// // // //         child: Text('Fetching Attendance Data...'),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:http/http.dart' as http;
// // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // //
// // // // // void main() {
// // // // //   runApp(MyApp());
// // // // // }
// // // // //
// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //       title: 'Attendance App',
// // // // //       theme: ThemeData(
// // // // //         primarySwatch: Colors.blue,
// // // // //       ),
// // // // //       home: AttendanceScreen(),
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // // // class AttendanceScreen extends StatefulWidget {
// // // // //   @override
// // // // //   _AttendanceScreenState createState() => _AttendanceScreenState();
// // // // // }
// // // // //
// // // // // class _AttendanceScreenState extends State<AttendanceScreen> {
// // // // //   late SharedPreferences _prefs;
// // // // //   String selectedData = '';
// // // // //   String studentId = '';
// // // // //   int selectedYear = 0;
// // // // //   int selectedMonth = 0;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     initializePreferences();
// // // // //   }
// // // // //
// // // // //   Future<void> initializePreferences() async {
// // // // //     _prefs = await SharedPreferences.getInstance();
// // // // //     setState(() {
// // // // //       studentId = _prefs.getString('student_id') ?? '';
// // // // //       selectedYear = _prefs.getInt('selected_year') ?? 0;
// // // // //       selectedMonth = _prefs.getInt('selected_month') ?? 0;
// // // // //     });
// // // // //   }
// // // // //
// // // // //   Future<void> savePreferences() async {
// // // // //     await _prefs.setString('student_id', studentId);
// // // // //     await _prefs.setInt('selected_year', selectedYear);
// // // // //     await _prefs.setInt('selected_month', selectedMonth);
// // // // //   }
// // // // //
// // // // //   Future<void> fetchAttendanceData() async {
// // // // //     final url = Uri.parse('http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$selectedYear&month=$selectedMonth');
// // // // //
// // // // //     try {
// // // // //       final response = await http.get(url);
// // // // //
// // // // //       if (response.statusCode == 200) {
// // // // //         // Successful API call
// // // // //         final responseData = response.body;
// // // // //         // Process the responseData as needed
// // // // //         setState(() {
// // // // //           selectedData = responseData;
// // // // //         });
// // // // //       } else {
// // // // //         // Handle API error
// // // // //         print('Error: ${response.statusCode}');
// // // // //       }
// // // // //     } catch (e) {
// // // // //       // Handle network or other errors
// // // // //       print('Error: $e');
// // // // //     }
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Attendance'),
// // // // //       ),
// // // // //       body: Center(
// // // // //         child: Column(
// // // // //           mainAxisAlignment: MainAxisAlignment.center,
// // // // //           children: [
// // // // //             Text(
// // // // //               'Selected Data: $selectedData',
// // // // //               style: TextStyle(fontSize: 18),
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             ElevatedButton(
// // // // //               onPressed: () {
// // // // //                 fetchAttendanceData();
// // // // //               },
// // // // //               child: Text('View'),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //       floatingActionButton: FloatingActionButton(
// // // // //         onPressed: () async {
// // // // //           // Navigate to a page where the user can select the desired data and year
// // // // //           final selectedData = await Navigator.push(
// // // // //             context,
// // // // //             MaterialPageRoute(builder: (context) => DataSelectionScreen()),
// // // // //           );
// // // // //
// // // // //           if (selectedData != null) {
// // // // //             setState(() {
// // // // //               studentId = selectedData['studentId'];
// // // // //               selectedYear = selectedData['year'];
// // // // //               selectedMonth = selectedData['month'];
// // // // //             });
// // // // //             await savePreferences();
// // // // //           }
// // // // //         },
// // // // //         child: Icon(Icons.edit),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // // // class DataSelectionScreen extends StatefulWidget {
// // // // //   @override
// // // // //   _DataSelectionScreenState createState() => _DataSelectionScreenState();
// // // // // }
// // // // //
// // // // // class _DataSelectionScreenState extends State<DataSelectionScreen> {
// // // // //   final TextEditingController _studentIdController = TextEditingController();
// // // // //   final TextEditingController _yearController = TextEditingController();
// // // // //   final TextEditingController _monthController = TextEditingController();
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     _studentIdController.dispose();
// // // // //     _yearController.dispose();
// // // // //     _monthController.dispose();
// // // // //     super.dispose();
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text('Data Selection'),
// // // // //       ),
// // // // //       body: Padding(
// // // // //         padding: EdgeInsets.all(16.0),
// // // // //         child: Column(
// // // // //           children: [
// // // // //             TextField(
// // // // //               controller: _studentIdController,
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Student ID',
// // // // //               ),
// // // // //             ),
// // // // //             TextField(
// // // // //               controller: _yearController,
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Year',
// // // // //               ),
// // // // //               keyboardType: TextInputType.number,
// // // // //             ),
// // // // //             TextField(
// // // // //               controller: _monthController,
// // // // //               decoration: InputDecoration(
// // // // //                 labelText: 'Month',
// // // // //               ),
// // // // //               keyboardType: TextInputType.number,
// // // // //             ),
// // // // //             SizedBox(height: 20),
// // // // //             ElevatedButton(
// // // // //               onPressed: () {
// // // // //                 final selectedData = {
// // // // //                   'studentId': _studentIdController.text,
// // // // //                   'year': int.tryParse(_yearController.text) ?? 0,
// // // // //                   'month': int.tryParse(_monthController.text) ?? 0,
// // // // //                 };
// // // // //                 Navigator.pop(context, selectedData);
// // // // //               },
// // // // //               child: Text('Save'),
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // import 'dart:convert';
// // //
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // void main() {
// // //   runApp(MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Attendance App',
// // //       theme: ThemeData(
// // //         primarySwatch: Colors.blue,
// // //       ),
// // //       home: AttendanceScreen(),
// // //     );
// // //   }
// // // }
// // //
// // // class AttendanceScreen extends StatefulWidget {
// // //   @override
// // //   _AttendanceScreenState createState() => _AttendanceScreenState();
// // // }
// // //
// // // class _AttendanceScreenState extends State<AttendanceScreen> {
// // //   List<AttendanceItem> attendanceItems = [];
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     fetchAttendanceData('75', 2023, 6);
// // //   }
// // //
// // //   Future<void> fetchAttendanceData(String studentId, int year, int month) async {
// // //     final url =
// // //     Uri.parse('http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$year&month=$month');
// // //     SharedPreferences preferences = await SharedPreferences.getInstance();
// // //      String student_id = preferences.getString('student_id') ?? '';
// // //      print(student_id);
// // //
// // //     try {
// // //       final response = await http.get(url);
// // //
// // //       if (response.statusCode == 200) {
// // //         // Successful API call
// // //         final responseData = jsonDecode(response.body);
// // //         final List<dynamic> data = responseData['data'];
// // //
// // //         setState(() {
// // //           attendanceItems = data.map((item) => AttendanceItem.fromJson(item)).toList();
// // //         });
// // //       } else {
// // //         // Handle API error
// // //         print('Error: ${response.statusCode}');
// // //       }
// // //     } catch (e) {
// // //       // Handle network or other errors
// // //       print('Error: $e');
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('Attendance'),
// // //       ),
// // //       body: ListView.builder(
// // //         itemCount: attendanceItems.length,
// // //         itemBuilder: (context, index) {
// // //           final attendanceItem = attendanceItems[index];
// // //           return ListTile(
// // //             title: Text('Attendance Date: ${attendanceItem.attendanceDate}'),
// // //             subtitle: Text('Status: ${attendanceItem.attended == "1" ? "Present" : "Absent"}'),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // // class AttendanceItem {
// // //   final String attendanceId;
// // //   final String schoolId;
// // //   final String standardId;
// // //   final String studentId;
// // //   final String attendanceDate;
// // //   final String attended;
// // //   final String attendanceReason;
// // //   final String onDate;
// // //
// // //   AttendanceItem({
// // //     required this.attendanceId,
// // //     required this.schoolId,
// // //     required this.standardId,
// // //     required this.studentId,
// // //     required this.attendanceDate,
// // //     required this.attended,
// // //     required this.attendanceReason,
// // //     required this.onDate,
// // //   });
// // //
// // //   factory AttendanceItem.fromJson(Map<String, dynamic> json) {
// // //     return AttendanceItem(
// // //       attendanceId: json['attendence_id'],
// // //       schoolId: json['school_id'],
// // //       standardId: json['standard_id'],
// // //       studentId: json['student_id'],
// // //       attendanceDate: json['attendence_date'],
// // //       attended: json['attended'],
// // //       attendanceReason: json['attendence_reason'],
// // //       onDate: json['on_date'],
// // //     );
// // //   }
// // // }
// //
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() {
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Attendance App',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: AttendanceScreen(),
// //     );
// //   }
// // }
// //
// // class AttendanceScreen extends StatefulWidget {
// //   @override
// //   _AttendanceScreenState createState() => _AttendanceScreenState();
// // }
// //
// // class _AttendanceScreenState extends State<AttendanceScreen> {
// //   List<AttendanceItem> attendanceItems = [];
// //   String studentId = '';
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     retrieveStudentId();
// //   }
// //
// //   Future<void> retrieveStudentId() async {
// //     final preferences = await SharedPreferences.getInstance();
// //
// //     // Retrieve the student_id from shared preferences
// //     final storedStudentId = preferences.getString('student_id');
// //
// //     setState(() {
// //       studentId = storedStudentId ?? ''; // If student_id is not stored, set it as an empty string
// //       fetchAttendanceData(studentId, 2023, 6);
// //     });
// //   }
// //
// //   Future<void> fetchAttendanceData(String studentId, int year, int month) async {
// //     final preferences = await SharedPreferences.getInstance();
// //
// //     // Save the student_id to shared preferences
// //     preferences.setString('student_id', studentId);
// //
// //     final url = Uri.parse(
// //         'http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$year&month=$month');
// //
// //     try {
// //       final response = await http.get(url);
// //
// //       if (response.statusCode == 200) {
// //         // Successful API call
// //         final responseData = jsonDecode(response.body);
// //         final List<dynamic> data = responseData['data'];
// //
// //         setState(() {
// //           attendanceItems = data.map((item) => AttendanceItem.fromJson(item)).toList();
// //         });
// //       } else {
// //         // Handle API error
// //         print('Error: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       // Handle network or other errors
// //       print('Error: $e');
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Attendance'),
// //       ),
// //       body: studentId.isEmpty
// //           ? Center(child: CircularProgressIndicator())
// //           : ListView.builder(
// //         itemCount: attendanceItems.length,
// //         itemBuilder: (context, index) {
// //           final attendanceItem = attendanceItems[index];
// //           return ListTile(
// //             title: Text('Attendance Date: ${attendanceItem.attendanceDate}'),
// //             subtitle: Text('Status: ${attendanceItem.attended == "1" ? "Present" : "Absent"}'),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// //
// // class AttendanceItem {
// //   final String attendanceId;
// //   final String schoolId;
// //   final String standardId;
// //   final String studentId;
// //   final String attendanceDate;
// //   final String attended;
// //   final String attendanceReason;
// //   final String onDate;
// //
// //   AttendanceItem({
// //     required this.attendanceId,
// //     required this.schoolId,
// //     required this.standardId,
// //     required this.studentId,
// //     required this.attendanceDate,
// //     required this.attended,
// //     required this.attendanceReason,
// //     required this.onDate,
// //   });
// //
// //   factory AttendanceItem.fromJson(Map<String, dynamic> json) {
// //     return AttendanceItem(
// //       attendanceId: json['attendence_id'],
// //       schoolId: json['school_id'],
// //       standardId: json['standard_id'],
// //       studentId: json['student_id'],
// //       attendanceDate: json['attendence_date'],
// //       attended: json['attended'],
// //       attendanceReason: json['attendence_reason'],
// //       onDate: json['on_date'],
// //     );
// //   }
// // }
// //
//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Attendance App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: AttendanceScreen(),
//     );
//   }
// }
//
// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }
//
// class _AttendanceScreenState extends State<AttendanceScreen> {
//   List<AttendanceItem> attendanceItems = [];
//   String studentId = '';
//   int selectedMonth = DateTime.now().month;
//   int selectedYear = DateTime.now().year;
//
//   @override
//   void initState() {
//     super.initState();
//     retrieveStudentId();
//   }
//
//   Future<void> retrieveStudentId() async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Retrieve the student_id from shared preferences
//     final storedStudentId = preferences.getString('student_id');
//
//     setState(() {
//       studentId = storedStudentId ?? ''; // If student_id is not stored, set it as an empty string
//       fetchAttendanceData(studentId, selectedYear, selectedMonth);
//     });
//   }
//
//   Future<void> fetchAttendanceData(String studentId, int year, int month) async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Save the student_id to shared preferences
//     preferences.setString('student_id', studentId);
//
//     final url = Uri.parse(
//         'http://schoolportal.mtemporary.hol.es/index.php/api/get_student_attendence?student_id=$studentId&year=$year&month=$month');
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // Successful API call
//         final responseData = jsonDecode(response.body);
//         final List<dynamic> data = responseData['data'];
//
//         setState(() {
//           attendanceItems = data.map((item) => AttendanceItem.fromJson(item)).toList();
//         });
//       } else {
//         // Handle API error
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Attendance'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 DropdownButton<int>(
//                   value: selectedMonth,
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       selectedMonth = newValue!;
//                     });
//                   },
//                   items: List<int>.generate(12, (index) => index + 1)
//                       .map<DropdownMenuItem<int>>(
//                         (int value) {
//                       return DropdownMenuItem<int>(
//                         value: value,
//                         child: Text(value.toString()),
//                       );
//                     },
//                   ).toList(),
//                 ),
//                 SizedBox(width: 16.0),
//                 DropdownButton<int>(
//                   value: selectedYear,
//                   onChanged: (int? newValue) {
//                     setState(() {
//                       selectedYear = newValue!;
//                     });
//                   },
//                   items: List<int>.generate(10, (index) => DateTime.now().year - index)
//                       .map<DropdownMenuItem<int>>(
//                         (int value) {
//                       return DropdownMenuItem<int>(
//                         value: value,
//                         child: Text(value.toString()),
//                       );
//                     },
//                   ).toList(),
//                 ),
//                 SizedBox(width: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     fetchAttendanceData(studentId, selectedYear, selectedMonth);
//                   },
//                   child: Text('View'),
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: studentId.isEmpty
//                 ? Center(child: CircularProgressIndicator())
//                 : ListView.builder(
//               itemCount: attendanceItems.length,
//               itemBuilder: (context, index) {
//                 final attendanceItem = attendanceItems[index];
//                 return ListTile(
//                   title: Text('Attendance Date: ${attendanceItem.attendanceDate}'),
//                   subtitle: Text(
//                       'Status: ${attendanceItem.attended == "1" ? "Present" : "Absent"}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class AttendanceItem {
//   final String attendanceId;
//   final String schoolId;
//   final String standardId;
//   final String studentId;
//   final String attendanceDate;
//   final String attended;
//   final String attendanceReason;
//   final String onDate;
//
//   AttendanceItem({
//     required this.attendanceId,
//     required this.schoolId,
//     required this.standardId,
//     required this.studentId,
//     required this.attendanceDate,
//     required this.attended,
//     required this.attendanceReason,
//     required this.onDate,
//   });
//
//   factory AttendanceItem.fromJson(Map<String, dynamic> json) {
//     return AttendanceItem(
//       attendanceId: json['attendence_id'],
//       schoolId: json['school_id'],
//       standardId: json['standard_id'],
//       studentId: json['student_id'],
//       attendanceDate: json['attendence_date'],
//       attended: json['attended'],
//       attendanceReason: json['attendence_reason'],
//       onDate: json['on_date'],
//     );
//   }
// }



////// holiday


// // import 'dart:convert';
// // import 'package:educatioapi/Model_Classes/Holiday_Model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class HolidayScreen extends StatefulWidget {
// //   @override
// //   _HolidayScreenState createState() => _HolidayScreenState();
// // }
// //
// // class _HolidayScreenState extends State<HolidayScreen> {
// //   bool isLoading = false;
// //
// //   List<Holiday> holidayItems = [];
// //   String schoolId = '';
// //   int selectedMonth = DateTime.now().month;
// //   int selectedYear = DateTime.now().year;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     retrieveSchoolId();
// //   }
// //
// //   Future<void> retrieveSchoolId() async {
// //     final preferences = await SharedPreferences.getInstance();
// //
// //     // Retrieve the student_id from shared preferences
// //     final storedSchoolId = preferences.getString('school_id');
// //
// //     setState(() {
// //       schoolId = storedSchoolId ??
// //           ''; // If student_id is not stored, set it as an empty string
// //       fetchAttendanceData(schoolId, selectedYear, selectedMonth);
// //     });
// //   }
// //
// //   Future<void> fetchAttendanceData(String schoolId, int year, int month) async {
// //     final preferences = await SharedPreferences.getInstance();
// //
// //     // Save the student_id to shared preferences
// //     preferences.setString('school_id', schoolId);
// //
// //     setState(() {
// //       isLoading = true; // Set isLoading to true before making the API call
// //     });
// //
// //     final url = Uri.parse(
// //         'http://schoolportal.mtemporary.hol.es/index.php/api/get_holidays?student_id=$schoolId&year=$year&month=$month');
// //
// //     try {
// //       final response = await http.get(url);
// //
// //       if (response.statusCode == 200) {
// //         // Successful API call
// //         final responseData = jsonDecode(response.body);
// //         final List<dynamic> data = responseData['data'];
// //
// //         setState(() {
// //           holidayItems = data.map((item) => Holiday.fromJson(item)).toList();
// //         });
// //       } else {
// //         // Handle API error
// //         print('Error: ${response.statusCode}');
// //       }
// //     } catch (e) {
// //       // Handle network or other errors
// //       print('Error: $e');
// //     }
// //     setState(() {
// //       isLoading = false; // Set isLoading to false after API call is complete
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Holidays'),
// //       ),
// //       body: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 DropdownButton<int>(
// //                   value: selectedMonth,
// //                   onChanged: (int? newValue) {
// //                     setState(() {
// //                       selectedMonth = newValue!;
// //                     });
// //                   },
// //                   items: List<int>.generate(12, (index) => index + 1)
// //                       .map<DropdownMenuItem<int>>(
// //                         (int value) {
// //                       return DropdownMenuItem<int>(
// //                         value: value,
// //                         child: Text(value.toString()),
// //                       );
// //                     },
// //                   ).toList(),
// //                 ),
// //                 SizedBox(width: 16.0),
// //                 DropdownButton<int>(
// //                   value: selectedYear,
// //                   onChanged: (int? newValue) {
// //                     setState(() {
// //                       selectedYear = newValue!;
// //                     });
// //                   },
// //                   items: List<int>.generate(
// //                       10, (index) => DateTime.now().year - index)
// //                       .map<DropdownMenuItem<int>>(
// //                         (int value) {
// //                       return DropdownMenuItem<int>(
// //                         value: value,
// //                         child: Text(value.toString()),
// //                       );
// //                     },
// //                   ).toList(),
// //                 ),
// //                 SizedBox(width: 16.0),
// //                 ElevatedButton(
// //                   onPressed: () {
// //                     fetchAttendanceData(schoolId, selectedYear, selectedMonth);
// //                   },
// //                   child: Text('View'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Expanded(
// //             child: isLoading
// //                 ? Center(child: CircularProgressIndicator())
// //                 : GridView.builder(
// //               padding: EdgeInsets.all(16.0),
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: MediaQuery.of(context).size.width ~/ 70,
// //               ),
// //               itemCount: DateTime(selectedYear, selectedMonth + 1, 0).day,
// //               itemBuilder: (context, index) {
// //                 final currentDate =
// //                 DateTime(selectedYear, selectedMonth, index + 1);
// //                 final holidayItem = holidayItems.firstWhere(
// //                       (item) =>
// //                   item.holidayDate ==
// //                       currentDate.toString().split(' ')[0],
// //                   orElse: () => Holiday(
// //                     holidayId: '',
// //                     schoolId: '',
// //                     holidayTitle: '',
// //                     holidayDate: '',
// //                   ),
// //                 );
// //
// //                 final weekdays = [
// //                   'Mon',
// //                   'Tue',
// //                   'Wed',
// //                   'Thu',
// //                   'Fri',
// //                   'Sat',
// //                   'Sun'
// //                 ];
// //                 final weekdayIndex = currentDate.weekday -
// //                     1; // Adjust index to start from 0
// //
// //                 return Container(
// //                   decoration: BoxDecoration(
// //                     border: Border.all(),
// //                   ),
// //                   child: Column(
// //                     mainAxisAlignment: MainAxisAlignment.center,
// //                     children: [
// //                       Text(
// //                         weekdays[weekdayIndex],
// //                         style: TextStyle(
// //                           fontSize: 16.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                       SizedBox(height: 4.0),
// //                       Text(
// //                         currentDate.day.toString(),
// //                         style: TextStyle(
// //                           fontSize: 16.0,
// //                           fontWeight: FontWeight.bold,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Holiday App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HolidayScreen(),
//     );
//   }
// }
//
// class HolidayScreen extends StatefulWidget {
//   @override
//   _HolidayScreenState createState() => _HolidayScreenState();
// }
//
// class _HolidayScreenState extends State<HolidayScreen> {
//   List<HolidayItem> holidayItems = [];
//   String schoolId = '';
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//
//   @override
//   void initState() {
//     super.initState();
//     retrieveSchoolId();
//   }
//
//   Future<void> retrieveSchoolId() async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Retrieve the school_id from shared preferences
//     final storedSchoolId = preferences.getString('school_id');
//
//     setState(() {
//       schoolId = storedSchoolId ?? ''; // If school_id is not stored, set it as an empty string
//       fetchHolidayData(schoolId, selectedYear, selectedMonth);
//       print(schoolId);
//       print(selectedYear);
//       print(selectedMonth);
//
//     });
//   }
//
//   Future<void> fetchHolidayData(String schoolId, int year, int month) async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Save the school_id to shared preferences
//     preferences.setString('school_id', schoolId);
//
//     final url = Uri.parse(
//         'http://schoolportal.mtemporary.hol.es/index.php/api/get_holidays?school_id=$schoolId&year=$year&month=$month');
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // Successful API call
//         final responseData = jsonDecode(response.body);
//         print(responseData);
//         final List<dynamic> data = responseData['data'];
//
//         setState(() {
//           holidayItems = data.map((item) => HolidayItem.fromJson(item)).toList();
//           print(holidayItems);
//         });
//       } else {
//         // Handle API error
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Holidays'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               DropdownButton<int>(
//                 value: selectedMonth,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedMonth = newValue!;
//                   });
//                 },
//                 items: List<int>.generate(12, (index) => index + 1)
//                     .map((month) => DropdownMenuItem<int>(
//                   value: month,
//                   child: Text(month.toString()),
//                 ))
//                     .toList(),
//               ),
//               SizedBox(width: 8.0),
//               DropdownButton<int>(
//                 value: selectedYear,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedYear = newValue!;
//                   });
//                 },
//                 items: List<int>.generate(10, (index) => DateTime.now().year - index)
//                     .map((year) => DropdownMenuItem<int>(
//                   value: year,
//                   child: Text(year.toString()),
//                 ))
//                     .toList(),
//               ),
//               SizedBox(width: 8.0),
//               ElevatedButton(
//                 onPressed: () {
//                   fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                 },
//                 child: Text('View'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: holidayItems.length,
//               itemBuilder: (context, index) {
//                 final holidayItem = holidayItems[index];
//                 return ListTile(
//                   title: Text('Holiday Date: ${holidayItem.holidayDate}'),
//                   subtitle: Text('Holiday Name: ${holidayItem.holidayName}'),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Holiday App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HolidayScreen(),
//     );
//   }
// }
//
// class HolidayScreen extends StatefulWidget {
//   @override
//   _HolidayScreenState createState() => _HolidayScreenState();
// }
//
// class _HolidayScreenState extends State<HolidayScreen> {
//   List<HolidayItem> holidayItems = [];
//   String schoolId = '';
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//   List<DateTime> calendarDays = [];
//
//   @override
//   void initState() {
//     super.initState();
//     retrieveSchoolId();
//     calendarDays = generateCalendar(selectedYear, selectedMonth);
//   }
//
//   Future<void> retrieveSchoolId() async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Retrieve the school_id from shared preferences
//     final storedSchoolId = preferences.getString('school_id');
//
//     setState(() {
//       schoolId = storedSchoolId ?? ''; // If school_id is not stored, set it as an empty string
//       fetchHolidayData(schoolId, selectedYear, selectedMonth);
//     });
//   }
//
//   Future<void> fetchHolidayData(String schoolId, int year, int month) async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Save the school_id to shared preferences
//     preferences.setString('school_id', schoolId);
//
//     final url = Uri.parse(
//         'http://schoolportal.mtemporary.hol.es/index.php/api/get_holidays?school_id=$schoolId&year=$year&month=$month');
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // Successful API call
//         final responseData = jsonDecode(response.body);
//         final List<dynamic> data = responseData['data'];
//
//         setState(() {
//           holidayItems = data.map((item) => HolidayItem.fromJson(item)).toList();
//         });
//       } else {
//         // Handle API error
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//     }
//   }
//
//   List<DateTime> generateCalendar(int year, int month) {
//     final firstDayOfMonth = DateTime(year, month, 1);
//     final lastDayOfMonth = DateTime(year, month + 1, 0);
//     final List<DateTime> days = [];
//
//     // Fill the days list with DateTime objects for each day of the month
//     for (var i = 0; i < lastDayOfMonth.day; i++) {
//       final day = firstDayOfMonth.add(Duration(days: i));
//       days.add(day);
//     }
//
//     return days;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Holidays'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               DropdownButton<int>(
//                 value: selectedMonth,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedMonth = newValue!;
//                     calendarDays = generateCalendar(selectedYear, selectedMonth);
//                     fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                   });
//                 },
//                 items: List<int>.generate(12, (index) => index + 1)
//                     .map((month) => DropdownMenuItem<int>(
//                   value: month,
//                   child: Text(month.toString()),
//                 ))
//                     .toList(),
//               ),
//               DropdownButton<int>(
//                 value: selectedYear,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedYear = newValue!;
//                     calendarDays = generateCalendar(selectedYear, selectedMonth);
//                     fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                   });
//                 },
//                 items: List<int>.generate(10, (index) => DateTime.now().year - 5 + index)
//                     .map((year) => DropdownMenuItem<int>(
//                   value: year,
//                   child: Text(year.toString()),
//                 ))
//                     .toList(),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                 },
//                 child: Text('View'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 7,
//               ),
//               itemCount: calendarDays.length,
//               itemBuilder: (context, index) {
//                 final day = calendarDays[index];
//                 final isHoliday = holidayItems.any((item) =>
//                 DateTime.parse(item.holidayDate).day == day.day &&
//                     DateTime.parse(item.holidayDate).month == day.month &&
//                     DateTime.parse(item.holidayDate).year == day.year);
//
//                 return Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     color: isHoliday ? Colors.yellow : Colors.white,
//                   ),
//                   child: Center(
//                     child: Text(day.day.toString()),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Holiday App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: HolidayScreen(),
//     );
//   }
// }
//
// class HolidayScreen extends StatefulWidget {
//   @override
//   _HolidayScreenState createState() => _HolidayScreenState();
// }
//
// class _HolidayScreenState extends State<HolidayScreen> {
//   List<HolidayItem> holidayItems = [];
//   String schoolId = '';
//   int selectedYear = DateTime.now().year;
//   int selectedMonth = DateTime.now().month;
//   List<DateTime> calendarDays = [];
//
//   @override
//   void initState() {
//     super.initState();
//     retrieveSchoolId();
//     calendarDays = generateCalendar(selectedYear, selectedMonth);
//   }
//
//   Future<void> retrieveSchoolId() async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Retrieve the school_id from shared preferences
//     final storedSchoolId = preferences.getString('school_id');
//
//     setState(() {
//       schoolId = storedSchoolId ?? ''; // If school_id is not stored, set it as an empty string
//       fetchHolidayData(schoolId, selectedYear, selectedMonth);
//     });
//   }
//
//   Future<void> fetchHolidayData(String schoolId, int year, int month) async {
//     final preferences = await SharedPreferences.getInstance();
//
//     // Save the school_id to shared preferences
//     preferences.setString('school_id', schoolId);
//
//     final url = Uri.parse(
//         'http://schoolportal.mtemporary.hol.es/index.php/api/get_holidays?school_id=$schoolId&year=$year&month=$month');
//
//     try {
//       final response = await http.get(url);
//
//       if (response.statusCode == 200) {
//         // Successful API call
//         final responseData = jsonDecode(response.body);
//         final List<dynamic> data = responseData['data'];
//
//         setState(() {
//           holidayItems = data.map((item) => HolidayItem.fromJson(item)).toList();
//         });
//       } else {
//         // Handle API error
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       // Handle network or other errors
//       print('Error: $e');
//     }
//   }
//
//   List<DateTime> generateCalendar(int year, int month) {
//     final firstDayOfMonth = DateTime(year, month, 1);
//     final lastDayOfMonth = DateTime(year, month + 1, 0);
//     final List<DateTime> days = [];
//
//     // Fill the days list with DateTime objects for each day of the month
//     for (var i = 0; i < lastDayOfMonth.day; i++) {
//       final day = firstDayOfMonth.add(Duration(days: i));
//       days.add(day);
//     }
//
//     return days;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Holidays'),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               DropdownButton<int>(
//                 value: selectedMonth,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedMonth = newValue!;
//                     calendarDays = generateCalendar(selectedYear, selectedMonth);
//                     fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                   });
//                 },
//                 items: List<int>.generate(12, (index) => index + 1)
//                     .map((month) => DropdownMenuItem<int>(
//                   value: month,
//                   child: Text(month.toString()),
//                 ))
//                     .toList(),
//               ),
//               DropdownButton<int>(
//                 value: selectedYear,
//                 onChanged: (newValue) {
//                   setState(() {
//                     selectedYear = newValue!;
//                     calendarDays = generateCalendar(selectedYear, selectedMonth);
//                     fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                   });
//                 },
//                 items: List<int>.generate(10, (index) => DateTime.now().year - 5 + index)
//                     .map((year) => DropdownMenuItem<int>(
//                   value: year,
//                   child: Text(year.toString()),
//                 ))
//                     .toList(),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   fetchHolidayData(schoolId, selectedYear, selectedMonth);
//                 },
//                 child: Text('View'),
//               ),
//             ],
//           ),
//           Expanded(
//             child: GridView.builder(
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 7,
//               ),
//               itemCount: calendarDays.length,
//               itemBuilder: (context, index) {
//                 final day = calendarDays[index];
//                 final isHoliday = holidayItems.any((item) =>
//                 DateTime.parse(item.holidayDate).day == day.day &&
//                     DateTime.parse(item.holidayDate).month == day.month &&
//                     DateTime.parse(item.holidayDate).year == day.year);
//                 final isSunday = day.weekday == DateTime.sunday;
//
//                 return Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey),
//                     color: isHoliday ? Colors.yellow : (isSunday ? Colors.orange : Colors.white),
//                   ),
//                   child: Center(
//                     child: Text(day.day.toString()),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// result details


// import 'dart:convert';
// import 'package:educatioapi/Constants/Colors.dart';
// import 'package:educatioapi/Constants/consturl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import '../Model_Classes/result_detail_model.dart';
//
// class ResultDetail extends StatefulWidget {
//   final String examId;
//
//   ResultDetail(this.examId);
//
//   @override
//   _ResultDetailState createState() => _ResultDetailState();
// }
//
// class _ResultDetailState extends State<ResultDetail>
//     with SingleTickerProviderStateMixin {
//   Future<List<Detail_Result>>? _resultListDetail;
//   late String storedExamId;
//   final String url = ConstValue.RESULTS_REPORT_URL;
//   late int obtainMarks = 0;
//   late int totalMarks = 0;
//   late double percentage = 0.0;
//
//   @override
//   void initState() {
//     super.initState();
//     _resultListDetail = urlDetail();
//     storedExamId = widget.examId;
//   }
//
//   Future<List<Detail_Result>> urlDetail() async {
//     SharedPreferences pref_detail = await SharedPreferences.getInstance();
//     String student_id = pref_detail.getString('student_id') ?? '';
//     String exam_id = storedExamId;
//     print(exam_id);
//     print(student_id);
//
//     final response = await http.post(Uri.parse(url),
//         body: {'student_id': student_id, 'exam_id': exam_id});
//
//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       List<Detail_Result> results = List<Detail_Result>.from(responseData['data']
//           .map((x) => Detail_Result.fromJson(x)));
//       return results;
//     } else {
//       throw Exception('Failed to fetch results');
//     }
//   }
//
//   int calculateObtainMarks(List<Detail_Result>? resultList) {
//     obtainMarks = 0;
//     if (resultList != null) {
//       for (var result in resultList) {
//         obtainMarks += int.parse(result.mark_obtain);
//       }
//     }
//     return obtainMarks;
//   }
//
//   int calculateTotalMarks(List<Detail_Result>? resultList) {
//     totalMarks = 0;
//     if (resultList != null) {
//       for (var result in resultList) {
//         totalMarks += int.parse(result.total_mark);
//       }
//     }
//     return totalMarks;
//   }
//
//   // Percentage
//   double calculatePercentage(int obtainMarks, int totalMarks) {
//     if (totalMarks == 0) {
//       return 0.0;
//     } else {
//       return (obtainMarks / totalMarks) * 100;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: olive0,
//       appBar: AppBar(
//         flexibleSpace: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [olive0, olive1],
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//             ),
//           ),
//         ),
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: olive6),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: Text('Result Detail', style: TextStyle(color: olive6)),
//       ),
//       body: Column(
//         children: [
//           Container(
//             height: 100,
//             color: olive3,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Row(
//                   children: [
//                     Text('${obtainMarks.toString()}',
//                         style: TextStyle(
//                             color: olive7,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 26)),
//                     Text('/',
//                         style: TextStyle(
//                             color: olive4,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 26)),
//                     Text('${totalMarks.toString()}',
//                         style: TextStyle(
//                             color: olive7,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 26)),
//                   ],
//                 ),
//                 Text('$percentage%',
//                     style: TextStyle(
//                         color: olive7,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 26)),
//               ],
//             ),
//           ),
//           Container(
//             height: 60,
//             color: olive4,
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Subject',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     'Obtain Marks',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                   Text(
//                     'Total Marks',
//                     style: TextStyle(fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: FutureBuilder<List<Detail_Result>>(
//               future: _resultListDetail,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return SpinKitThreeInOut(
//                     size: 32.0,
//                     itemBuilder: (BuildContext context, int index) {
//                       return DecoratedBox(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(30),
//                           color:
//                           index.isEven ? Colors.blueAccent : Colors.black54,
//                         ),
//                       );
//                     },
//                     controller: AnimationController(
//                       vsync: this,
//                       duration: const Duration(milliseconds: 1200),
//                     ),
//                   );
//                 } else if (snapshot.hasError) {
//                   return Center(
//                     child: Text('Error: ${snapshot.error}'),
//                   );
//                 } else if (snapshot.hasData) {
//                   List<Detail_Result>? resultList = snapshot.data;
//                    calculateObtainMarks(resultList);
//                    calculateTotalMarks(resultList);
//                    calculatePercentage(obtainMarks, totalMarks);
//                   return ListView.builder(
//                     itemCount: resultList!.length + 1,
//                     itemBuilder: (context, index) {
//                       if (index == resultList.length) {
//                         // Last item in the list
//                         return Container(
//                           color: olive6,
//                           child: ListTile(
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text('Total Marks',
//                                     style: TextStyle(
//                                         color: olive1,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16)),
//                                 Text('$obtainMarks',
//                                     style: TextStyle(
//                                         color: olive2,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16)),
//                                 Text('$totalMarks',
//                                     style: TextStyle(
//                                         color: olive2,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16)),
//                                 // Text('Percentage: $percentage%'),
//                               ],
//                             ),
//                           ),
//                         );
//                       } else {
//                         return Container(
//                           color: olive1,
//                           child: ListTile(
//                             subtitle: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(resultList[index].subject,
//                                     style: TextStyle(
//                                         color: olive7,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14)),
//                                 Text('${resultList[index].mark_obtain}',
//                                     style: TextStyle(
//                                         color: olive5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14)),
//                                 Text('${resultList[index].total_mark}',
//                                     style: TextStyle(
//                                         color: olive5,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 14)),
//                               ],
//                             ),
//                           ),
//                         );
//                       }
//                     },
//                   );
//                 } else {
//                   return Center(
//                     child: Text('No results found'),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

/// homeScreen

// // // import 'package:educatioapi/Screens/Events_Screen.dart';
// // // import 'package:educatioapi/Screens/Exam_notes_screen.dart';
// // // import 'package:educatioapi/Screens/LoginScreen.dart';
// // // import 'package:educatioapi/Screens/Student_Profile.dart';
// // // import 'package:educatioapi/Screens/Teacher_Detail_screen.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // //
// // // class HomeScreen extends StatefulWidget {
// // //   HomeScreen({super.key});
// // //
// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }
// // //
// // // class _HomeScreenState extends State<HomeScreen> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text('HomeScreen'),
// // //         automaticallyImplyLeading: false,
// // //       ),
// // //       body: SingleChildScrollView(
// // //         child: Center(
// // //           child: Column(children: [
// // //             Text('Welcome'),
// // //             SizedBox(
// // //               height: 20,
// // //             ),
// // //             ElevatedButton(onPressed: () async {
// // //               SharedPreferences sp = await SharedPreferences.getInstance();
// // //               sp.clear();
// // //               Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
// // //             }, child: Text('Logoff')),
// // //             InkWell(
// // //               onTap: () async{
// // //                 SharedPreferences sp = await SharedPreferences.getInstance();
// // //                 String id = sp.getString('student_id') ?? '';
// // //                 sp.setString('student_id',id) ;
// // //                 // sp.get('student_id');
// // //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDataScreen()));
// // //               },
// // //               child: Container(
// // //                 height: 200,
// // //                 width: 200,
// // //                 color: Colors.green,
// // //               ),
// // //             ),
// // //             InkWell(
// // //               onTap: () async{
// // //                 SharedPreferences sp = await SharedPreferences.getInstance();
// // //                 String id_t = sp.getString('school_id') ?? '';
// // //
// // //                 sp.setString('school_id',id_t) ;
// // //                 // sp.get('student_id');
// // //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherDetail()));
// // //               },
// // //               child: Container(
// // //                 height: 200,
// // //                 width: 200,
// // //                 color: Colors.blue,
// // //               ),
// // //             ),
// // //             InkWell(
// // //               onTap: () async{
// // //                 SharedPreferences sp = await SharedPreferences.getInstance();
// // //                 String id_IS = sp.getString('school_id') ?? '';
// // //                 String id_SI = sp.getString('standard_id') ?? '';
// // //                 sp.setString('school_id',id_IS) ;
// // //                 sp.setString('standard_id', id_SI);
// // //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>ExamNotes()));
// // //               },
// // //               child: Container(
// // //                 height: 200,
// // //                 width: 200,
// // //                 color: Colors.red,
// // //               ),
// // //             ),
// // //             InkWell(
// // //               onTap: () async{
// // //                 SharedPreferences sp = await SharedPreferences.getInstance();
// // //                 String id_SE = sp.getString('school_id') ?? '';
// // //                 sp.setString('school_id',id_SE) ;
// // //                 Navigator.push(context, MaterialPageRoute(builder: (context)=>EventScreen()));
// // //               },
// // //               child: Container(
// // //                 height: 200,
// // //                 width: 200,
// // //                 color: Colors.yellow,
// // //               ),
// // //             ),
// // //           ]
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// //
// // import 'package:educatioapi/Screens/Events_Screen.dart';
// // import 'package:educatioapi/Screens/Exam_notes_screen.dart';
// // import 'package:educatioapi/Screens/LoginScreen.dart';
// // import 'package:educatioapi/Screens/Student_Profile.dart';
// // import 'package:educatioapi/Screens/Teacher_Detail_screen.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // class HomeScreen extends StatefulWidget {
// //   HomeScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<HomeScreen> createState() => _HomeScreenState();
// // }
// //
// // class _HomeScreenState extends State<HomeScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('HomeScreen'),
// //         automaticallyImplyLeading: false,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Center(
// //           child: Column(
// //             children: [
// //               Text('Welcome'),
// //               SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () async {
// //                   SharedPreferences sp = await SharedPreferences.getInstance();
// //                   sp.clear();
// //                   Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
// //                 },
// //                 child: Text('Logoff'),
// //               ),
// //               GridView.count(
// //                 shrinkWrap: true,
// //                 crossAxisCount: 2,
// //                 crossAxisSpacing: 10,
// //                 mainAxisSpacing: 10,
// //                 padding: EdgeInsets.all(20),
// //                 children: [
// //                   InkWell(
// //                     onTap: () async {
// //                       SharedPreferences sp = await SharedPreferences.getInstance();
// //                       String id = sp.getString('student_id') ?? '';
// //                       sp.setString('student_id', id);
// //                       Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDataScreen()));
// //                     },
// //                     child: Container(
// //                       color: Colors.green,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.person, size: 50, color: Colors.white),
// //                           SizedBox(height: 10),
// //                           Text('Student Profile', style: TextStyle(color: Colors.white)),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       SharedPreferences sp = await SharedPreferences.getInstance();
// //                       String id_t = sp.getString('school_id') ?? '';
// //                       sp.setString('school_id', id_t);
// //                       Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherDetail()));
// //                     },
// //                     child: Container(
// //                       color: Colors.blue,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.school, size: 50, color: Colors.white),
// //                           SizedBox(height: 10),
// //                           Text('Teacher Details', style: TextStyle(color: Colors.white)),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       SharedPreferences sp = await SharedPreferences.getInstance();
// //                       String id_IS = sp.getString('school_id') ?? '';
// //                       String id_SI = sp.getString('standard_id') ?? '';
// //                       sp.setString('school_id', id_IS);
// //                       sp.setString('standard_id', id_SI);
// //                       Navigator.push(context, MaterialPageRoute(builder: (context) => ExamNotes()));
// //                     },
// //                     child: Container(
// //                       color: Colors.red,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.note, size: 50, color: Colors.white),
// //                           SizedBox(height: 10),
// //                           Text('Exam Notes', style: TextStyle(color: Colors.white)),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                   InkWell(
// //                     onTap: () async {
// //                       SharedPreferences sp = await SharedPreferences.getInstance();
// //                       String id_SE = sp.getString('school_id') ?? '';
// //                       sp.setString('school_id', id_SE);
// //                       Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
// //                     },
// //                     child: Container(
// //                       color: Colors.yellow,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: [
// //                           Icon(Icons.event, size: 50, color: Colors.white),
// //                           SizedBox(height: 10),
// //                           Text('Events', style: TextStyle(color: Colors.white)),
// //                         ],
// //                       ),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// import 'package:educatioapi/Screens/Events_Screen.dart';
// import 'package:educatioapi/Screens/Exam_notes_screen.dart';
// import 'package:educatioapi/Screens/LoginScreen.dart';
// import 'package:educatioapi/Screens/Student_Profile.dart';
// import 'package:educatioapi/Screens/Teacher_Detail_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomeScreen'),
//         automaticallyImplyLeading: false,
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               Row(
//                 children: [
//
//                   IconButton(
//                     onPressed: () async {
//                       SharedPreferences sp = await SharedPreferences.getInstance();
//                       sp.clear();
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
//                     },
//                     icon: Icon(Icons.logout),
//                   ),
//                 ],
//               ),
//               GridView.count(
//                 shrinkWrap: true,
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 10,
//                 mainAxisSpacing: 10,
//                 padding: EdgeInsets.all(20),
//                 children: [
//                   InkWell(
//                     onTap: () async {
//                       SharedPreferences sp = await SharedPreferences.getInstance();
//                       String id = sp.getString('student_id') ?? '';
//                       sp.setString('student_id', id);
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDataScreen()));
//                     },
//                     child: Container(
//                       color: Colors.green,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.person, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Student Profile', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       SharedPreferences sp = await SharedPreferences.getInstance();
//                       String id_t = sp.getString('school_id') ?? '';
//                       sp.setString('school_id', id_t);
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => TeacherDetail()));
//                     },
//                     child: Container(
//                       color: Colors.blue,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.school, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Teacher Details', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       SharedPreferences sp = await SharedPreferences.getInstance();
//                       String id_IS = sp.getString('school_id') ?? '';
//                       String id_SI = sp.getString('standard_id') ?? '';
//                       sp.setString('school_id', id_IS);
//                       sp.setString('standard_id', id_SI);
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => ExamNotes()));
//                     },
//                     child: Container(
//                       color: Colors.red,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.note, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Exam Notes', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       SharedPreferences sp = await SharedPreferences.getInstance();
//                       String id_SE = sp.getString('school_id') ?? '';
//                       sp.setString('school_id', id_SE);
//                       Navigator.push(context, MaterialPageRoute(builder: (context) => EventScreen()));
//                     },
//                     child: Container(
//                       color: Colors.yellow,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.event, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Events', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Custom Box 1
//                   InkWell(
//                     onTap: () {
//                       // Add your custom logic here
//                     },
//                     child: Container(
//                       color: Colors.purple,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.add_chart_sharp, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Custom Box 1', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Custom Box 2
//                   InkWell(
//                     onTap: () {
//                       // Add your custom logic here
//                     },
//                     child: Container(
//                       color: Colors.orange,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.collections_bookmark_sharp, size: 50, color: Colors.white),
//                           SizedBox(height: 10),
//                           Text('Custom Box 2', style: TextStyle(color: Colors.white)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//// upload image function

// class UploadImageScreen extends StatefulWidget {
//   const UploadImageScreen({Key? key}) : super(key: key);
//
//   @override
//   _UploadImageScreenState createState() => _UploadImageScreenState();
// }
//
// class _UploadImageScreenState extends State<UploadImageScreen> {
//
//   File? image ;
//   final _picker = ImagePicker();
//   bool showSpinner = false ;
//
//   Future getImage()async{
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery , imageQuality: 80);
//
//     if(pickedFile!= null ){
//       image = File(pickedFile.path);
//       setState(() {
//
//       });
//     }else {
//       print('no image selected');
//     }
//   }
//
//   Future<void> uploadImage ()async{
//
//     setState(() {
//       showSpinner = true ;
//     });
//
//     var stream  = new http.ByteStream(image!.openRead());
//     stream.cast();
//
//     var length = await image!.length();
//
//     var uri = Uri.parse('https://fakestoreapi.com/products');
//
//     var request = new http.MultipartRequest('POST', uri);
//
//     request.fields['title'] = "Static title" ;
//
//     var multiport = new http.MultipartFile(
//         'image',
//         stream,
//         length);
//
//     request.files.add(multiport);
//
//     var response = await request.send() ;
//
//     print(response.stream.toString());
//     if(response.statusCode == 200){
//       setState(() {
//         showSpinner = false ;
//       });
//       print('image uploaded');
//     }else {
//       print('failed');
//       setState(() {
//         showSpinner = false ;
//       });
//
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ModalProgressHUD(
//       inAsyncCall: showSpinner,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Upload Image'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: (){
//                 getImage();
//               },
//               child: Container(
//                 child: image == null ? Center(child: Text('Pick Image'),)
//                     :
//                 Container(
//                   child: Center(
//                     child: Image.file(
//                       File(image!.path).absolute,
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 150,),
//             GestureDetector(
//               onTap: (){
//                 uploadImage();
//               },
//               child: Container(
//                 height: 50,
//                 width: 200,
//                 color: Colors.green,
//                 child: Center(child: Text('Upload')),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// screen
// import 'package:educatioapi/Home_Screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class LoginScreen extends StatefulWidget {
//    LoginScreen({super.key});
//
//    final emailcontroller = TextEditingController();
//    final agecontroller = TextEditingController();
//    final passwordcontroller = TextEditingController();
//
//
//    @override
//   State<LoginScreen> createState() => _LoginScreenState();
//
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(
//         'LoginScreen'
//       ),
//       centerTitle: true,),
//       body: Column(
//         children: [
//           TextFormField(
//             controller:widget.emailcontroller,
//             decoration: InputDecoration(
//               hintText: 'Email'
//             ),
//           ),
//           SizedBox(height: 10,),
//           TextFormField(
//             controller: widget.passwordcontroller,
//             decoration: InputDecoration(
//                 hintText: 'Password'
//             ),
//           ),
//           SizedBox(height: 10,),
//           TextFormField(
//             controller: widget.agecontroller,
//             decoration: InputDecoration(
//                 hintText: 'Age'
//             ),
//           ),
//           SizedBox(height: 10,),
//           InkWell(
//             onTap: () async {
//               SharedPreferences sp = await  SharedPreferences.getInstance();
//               sp.setString('email',widget.emailcontroller.text.toString());
//               sp.setString('Age', widget.agecontroller.text.toString());
//               sp.setBool('isLoading', true);
//
//               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//             },
//             child: Container(
//               height: 50,
//               width: double.infinity,
//               color: Colors.green,
//               child: Text('Login'),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
// login screen
// import 'dart:convert';
// import 'package:educatioapi/Home_Screen.dart';
// import 'package:educatioapi/Constants/consturl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SignInScreen extends StatefulWidget {
//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }
//
// class _SignInScreenState extends State<SignInScreen> {
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _obscurePassword = true;
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     final String username = _usernameController.text.trim();
//     final String password = _passwordController.text.trim();
//
//     if (username.isEmpty || password.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter username and password')),
//       );
//       return;
//     }
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     final String url =ConstValue.LOGIN_URL;
//
//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: {'student_user_name': username, 'student_password': password},
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//
//         if (responseData.containsKey('data') && responseData['data'] != null) {
//           final data = responseData['data'];
//
//           // Store the user data in shared preferences
//           final prefs = await SharedPreferences.getInstance();
//           String standard_id  =  data['student_standard'].toString();
//           print(standard_id);
//           prefs.setString('standard_id', standard_id);
//           prefs.setBool('isUserLogin', true);
//           prefs.setString('student_name', data['student_name']);
//           prefs.setString('student_id', data['student_id']);
//           prefs.setString('school_id', data['school_id']);
//
//           prefs.setString('student_roll_no', data['student_roll_no']);
//           prefs.setString('student_birthdate', data['student_birthdate']);
//           prefs.setString('student_branch', data['student_branch']);
//           prefs.setString('student_division', data['student_division']);
//           prefs.setString('student_batch', data['student_batch']);
//
//           // Navigate to the next screen
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
//
//           // Show a success message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Login successfully')),
//           );
//         } else {
//           // Show an error message
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Wrong username or password')),
//           );
//         }
//       } else {
//         // Show an error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('An error occurred')),
//         );
//       }
//     } catch (error) {
//       // Handle the error
//       print('Error: $error');
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Login'),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _usernameController,
//               decoration: InputDecoration(
//                 labelText: 'Username',
//               ),
//             ),
//             SizedBox(height: 16.0),
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 suffixIcon: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                   child: Icon(
//                     _obscurePassword ? Icons.visibility : Icons.visibility_off,
//                   ),
//                 ),
//               ),
//               obscureText: _obscurePassword,
//             ),
//             SizedBox(height: 24.0),
//             ElevatedButton(
//               onPressed: _isLoading ? null : _login,
//               child: _isLoading
//                   ? SpinKitWave(
//                 color: Colors.blue,
//                 size: 32.0,
//               )
//                   : Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


