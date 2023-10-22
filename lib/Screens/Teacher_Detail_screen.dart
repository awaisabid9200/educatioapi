import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Model_Classes/Model_Teacher.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TeacherDetail extends StatefulWidget {
  const TeacherDetail({Key? key}) : super(key: key);

  @override
  State<TeacherDetail> createState() => _TeacherDetailState();
}

class _TeacherDetailState extends State<TeacherDetail>
    with SingleTickerProviderStateMixin {
  late Future<List<PostModel>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchData();
  }

  final String url = ConstValue.TEACHERS_URL;

  Future<List<PostModel>> fetchData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String school_id = sp.getString('school_id') ?? '';

    final response = await http.post(
      Uri.parse(url),
      body: {'school_id': school_id},
    );

    if (response.statusCode == 200) {
      final responsedata = json.decode(response.body);
      List<PostModel> posts = List<PostModel>.from(
          responsedata['data'].map((x) => PostModel.fromJson(x)));
      return posts;
    } else {
      throw Exception('Error: ${response.statusCode}');
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
        title: Text('Teacher Details', style: TextStyle(color: olive6)),
      ),
      body: FutureBuilder<List<PostModel>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Card(
                      color: olive2,
                      shadowColor: olive6,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: ListTile(
                          title: Container(
                              height: 40,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: olive3),
                              child: Text(snapshot.data![index].teacherName,
                                  style: TextStyle(
                                      color: olive0,
                                      fontWeight: FontWeight.w500))),
                          subtitle: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Education: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: olive5),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Gender: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: olive5),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Contact: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: olive5),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'Email: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: olive5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              '${snapshot.data![index].teacherEducation}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('${snapshot.data![index].gender}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              ' ${snapshot.data![index].teacherPhone}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              ' ${snapshot.data![index].teacherEmail}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ),
                    ));
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
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
          }
        },
      ),
    ));
  }
}
