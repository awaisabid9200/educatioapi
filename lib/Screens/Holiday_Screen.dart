import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Model_Classes/Holiday_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HolidayScreen extends StatefulWidget {
  @override
  _HolidayScreenState createState() => _HolidayScreenState();
}

class _HolidayScreenState extends State<HolidayScreen> with TickerProviderStateMixin{
  List<HolidayItem> holidayItems = [];
  String schoolId = '';
  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  List<DateTime> calendarDays = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    retrieveSchoolId();
    calendarDays = generateCalendar(selectedYear, selectedMonth);
  }

  Future<void> retrieveSchoolId() async {
    final preferences = await SharedPreferences.getInstance();

    // Retrieve the school_id from shared preferences
    final storedSchoolId = preferences.getString('school_id');

    setState(() {
      schoolId = storedSchoolId ??
          ''; // If school_id is not stored, set it as an empty string
      fetchHolidayData(schoolId, selectedYear, selectedMonth);
    });
  }

  Future<void> fetchHolidayData(String schoolId, int year, int month) async {
    final preferences = await SharedPreferences.getInstance();

    // Save the school_id to shared preferences
    preferences.setString('school_id', schoolId);

    final url = Uri.parse(
        'http://schoolportal.mtemporary.hol.es/index.php/api/get_holidays?school_id=$schoolId&year=$year&month=$month');

    try {
      setState(() {
        isLoading = true; // Set isLoading to true when fetching data
      });
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Successful API call
        final responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'];

        setState(() {
          holidayItems =
              data.map((item) => HolidayItem.fromJson(item)).toList();
          isLoading = false;
        });
      } else {
        // Handle API error
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading = false; // Set isLoading to false on error
        });
      }
    } catch (e) {
      // Handle network or other errors
      print('Error: $e');
      setState(() {
        isLoading = false; // Set isLoading to false on error
      });
    }
  }

  List<DateTime> generateCalendar(int year, int month) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final lastDayOfMonth = DateTime(year, month + 1, 0);
    final List<DateTime> days = [];

    // Fill the days list with DateTime objects for each day of the month
    for (var i = 0; i < lastDayOfMonth.day; i++) {
      final day = firstDayOfMonth.add(Duration(days: i));
      days.add(day);
    }

    return days;
  }

  List<String> generateWeekdayNames(int year, int month) {
    final firstDayOfMonth = DateTime(year, month, 1);
    final List<String> weekdayNames = [];

    // Fill the weekdayNames list with the names of the weekdays
    for (var i = 0; i < 7; i++) {
      final day = firstDayOfMonth.add(Duration(days: i));
      final weekdayName = _getWeekdayName(day.weekday);
      weekdayNames.add(weekdayName);
    }

    return weekdayNames;
  }

  String _getWeekdayName(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tue';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thu';
      case DateTime.friday:
        return 'Fri';
      case DateTime.saturday:
        return 'Sat';
      case DateTime.sunday:
        return 'Sun';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final weekdayNames = generateWeekdayNames(selectedYear, selectedMonth);

    return Scaffold(
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
        title: Text('Holidays', style: TextStyle(color: olive6)),
      ),
      body: Column(
        children: [
          Container(
            color: olive,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<int>(
                  value: selectedMonth,
                  dropdownColor: olive0,
                  // Set the background color of the dropdown
                  style: TextStyle(
                    color: olive7, // Set the text color of the selected value
                  ),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedMonth = newValue!;
                      calendarDays =
                          generateCalendar(selectedYear, selectedMonth);
                      fetchHolidayData(schoolId, selectedYear, selectedMonth);
                    });
                  },
                  items: List<int>.generate(12, (index) => index + 1)
                      .map((month) => DropdownMenuItem<int>(
                            value: month,
                            child: MouseRegion(
                              // Wrap the item with a MouseRegion to add hover effects
                              cursor: SystemMouseCursors.click,
                              child: Text(
                                DateFormat.MMMM()
                                    .format(DateTime(selectedYear, month)),
                                style: TextStyle(
                                  color: olive7,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
                DropdownButton<int>(
                  value: selectedYear,
                  onChanged: (newValue) {
                    setState(() {
                      selectedYear = newValue!;
                      calendarDays =
                          generateCalendar(selectedYear, selectedMonth);
                      fetchHolidayData(schoolId, selectedYear, selectedMonth);
                    });
                  },
                  items: List<int>.generate(
                          10, (index) => DateTime.now().year - 5 + index)
                      .map((year) => DropdownMenuItem<int>(
                            value: year,
                            child: Text(year.toString()),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final boxSize = constraints.maxWidth / 7;
                  return isLoading
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemCount: calendarDays.length + 7,
                          itemBuilder: (context, index) {
                            if (index < 7) {
                              // Render weekday names row
                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: olive2),
                                  color: olive5,
                                ),
                                child: Center(
                                  child: Text(
                                    weekdayNames[index],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } else {
                              final day = calendarDays[index - 7];
                              final isHoliday = holidayItems.any((item) =>
                                  DateTime.parse(item.holidayDate).day ==
                                      day.day &&
                                  DateTime.parse(item.holidayDate).month ==
                                      day.month &&
                                  DateTime.parse(item.holidayDate).year ==
                                      day.year);
                              final isSunday = day.weekday == DateTime.sunday;
                              final holidayItem = holidayItems.firstWhere(
                                (item) =>
                                    DateTime.parse(item.holidayDate).day ==
                                        day.day &&
                                    DateTime.parse(item.holidayDate).month ==
                                        day.month &&
                                    DateTime.parse(item.holidayDate).year ==
                                        day.year,
                                orElse: () => HolidayItem(
                                  holidayId: '',
                                  schoolId: '',
                                  holidayDate: '',
                                  holidayTitle: '',
                                ),
                              );

                              return Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: olive2),
                                  color: isHoliday
                                      ? olive1
                                      : (isSunday ? olive3 : olive0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      day.day.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: boxSize * 0.2),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      holidayItem.holidayTitle,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: boxSize * 0.1),
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
