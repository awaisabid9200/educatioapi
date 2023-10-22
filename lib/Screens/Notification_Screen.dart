import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:educatioapi/Model_Classes/Notification_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late Future<List<NoticeModel>>  notificationListFuture;

  @override
  void initState() {
    super.initState();
    notificationListFuture = fetchData();
  }

  final String url = ConstValue.NOTICEBOARD_URL;

  Future<List<NoticeModel>> fetchData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String school_id = sp.getString('school_id') ?? '';
    print(school_id);

    final response = await http.post(
      Uri.parse(url),
      body: {'school_id': school_id},
    );

    if (response.statusCode == 200) {
      final responsedata = json.decode(response.body);
      List<NoticeModel> notificationList = List<NoticeModel>.from(
          responsedata['data'].map((x) => NoticeModel.fromJson(x)));
      return notificationList;
    } else {
      print('Error ${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  }

  String formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
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
          title: Text('Notificaton', style: TextStyle(color: olive6)),
        ),
        body: FutureBuilder<List<NoticeModel>>(
          future: notificationListFuture,
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
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              List<NoticeModel>? notificationList = snapshot.data;
              if (notificationList != null && notificationList.isNotEmpty) {
                return ListView.builder(
                  itemCount: notificationList.length,
                  itemBuilder: (context, index) {
                    DateTime onDate = DateTime.parse(notificationList[index].onDate);
                    String formattedDate = DateFormat('dd-MM-yyyy').format(onDate);
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
                                snapshot.data![index].noticeDescription,
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
                                          Text('Notice Type:',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Notice Status',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Data',style: TextStyle(
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
                                              '${notificationList[index].noticeType}',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive7)
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('${notificationList[index].noticeStatus}',style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('$formattedDate',style: TextStyle(
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
              } else {
                return Center(
                  child: Text('No notifications found.'),
                );
              }
            } else {
              return Center(
                child: Text('No data available.'),
              );
            }
          },
        ),
      ),
    );
  }
}
