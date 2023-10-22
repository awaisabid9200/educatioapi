  import 'dart:convert';
  import 'package:educatioapi/Constants/Colors.dart';
  import 'package:educatioapi/Constants/consturl.dart';
  import 'package:educatioapi/Model_Classes/Model_Events.dart';
  import 'package:educatioapi/Screens/Holiday_Screen.dart';
  import 'package:educatioapi/Screens/Notification_Screen.dart';
  import 'package:educatioapi/Screens/Teacher_Detail_screen.dart';
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
  import 'package:shared_preferences/shared_preferences.dart';
  import 'package:http/http.dart' as http;

  class EventScreen extends StatefulWidget {
    const EventScreen({Key? key}) : super(key: key);

    @override
    State<EventScreen> createState() => _EventScreenState();
  }

  class _EventScreenState extends State<EventScreen>
      with TickerProviderStateMixin {
    List<EventModel> eventList = [];

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    final String url = ConstValue.EVENT_URL;

    Future<List<EventModel>> fetchData() async {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String school_id = sp.getString('school_id') ?? '';
      print(school_id);

      final response = await http.post(
        Uri.parse(url),
        body: {'school_id': school_id},
      );

      if (response.statusCode == 200) {
        final responsedata = json.decode(response.body);
        return List<EventModel>.from(
            responsedata['data'].map((x) => EventModel.fromJson(x)));
      } else {
        print('Error ${response.statusCode}');
        return [];
      }
    }

    @override
    Widget build(BuildContext context) {
      return SafeArea(
        child: Scaffold(
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
            title: Text('School Events', style: TextStyle(color: olive6)),
            actions: [
              PopupMenuButton<String>(
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'option1',
                      child: ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Notification'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'option2',
                      child: ListTile(
                        leading: Icon(CupertinoIcons.doc_append),
                        title: Text('Holidays'),
                      ),
                    ),
                    PopupMenuItem<String>(
                      value: 'option3',
                      child: ListTile(
                        leading: Icon(Icons.info),
                        title: Text('Option 3'),
                      ),
                    ),
                  ];
                },
                onSelected: (String value) async {
                  if (value == 'option1') {
                    SharedPreferences sp = await SharedPreferences.getInstance();
                    String schoolId = sp.getString('school_id') ?? '';
                    sp.setString('school_id', schoolId);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ),
                    );
                  } else if (value == 'option2') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HolidayScreen(),
                      ),
                    );
                  } else if (value == 'option3') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeacherDetail(),
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert, color: olive6),
                ),
              ),
            ],
          ),
          body: FutureBuilder<List<EventModel>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinKitThreeInOut(
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
                );
              } else if (snapshot.hasData) {
                eventList = snapshot.data!;
                return ListView.builder(
                  itemCount: eventList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                      child: Card(
                        color: olive2,
                        shadowColor: olive6,
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: olive3,
                              ),
                              child: Text(
                                snapshot.data![index].eventTitle,
                                style: TextStyle(
                                  color: olive0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Description',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Due Date',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Last Data',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${eventList[index].eventDescription}',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive7)
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(eventList[index].eventStart)),style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(DateFormat('dd-MM-yyyy').format(DateTime.parse(eventList[index].eventEnd)),style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive7)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return Center(
                  child: Text('No data available'),
                );
              }
            },
          ),
        ),
      );
    }
  }
