import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:educatioapi/Model_Classes/result_Model.dart';
import 'package:educatioapi/Screens/result_detail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';


class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  Future<List<Result_model>>? _resultListFuture;

  @override
  void initState() {
    super.initState();
    _resultListFuture = urlData();
  }

  final String url = ConstValue.RESULTS_URL;

  Future<List<Result_model>> urlData() async {
    SharedPreferences pref_result = await SharedPreferences.getInstance();
    String school_id = pref_result.getString('school_id') ?? '';
    String standard_id = pref_result.getString('standard_id') ?? '';
    String student_id = pref_result.getString('student_id') ?? '';
    pref_result.setString('student_id', student_id);

    print(school_id);
    print(standard_id);
    print(student_id);


    final response = await http.post(
      Uri.parse(url),
      body: {'school_id': school_id, 'standard_id': standard_id},
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<Result_model> results = List<Result_model>.from(responseData['data']
          .map((x) => Result_model.fromJson(x)));
      return results;
    } else {
      throw Exception('Failed to fetch results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: olive0,
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
          icon: Icon(Icons.arrow_back,color: olive6),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Student Result',style: TextStyle(color: olive6)),
      ),
      body: FutureBuilder<List<Result_model>>(
        future: _resultListFuture,
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
            List<Result_model>? resultList = snapshot.data;
            return ListView.builder(
              itemCount: resultList!.length,
              itemBuilder: (context, index) {
                DateTime onDate = DateTime.parse(resultList[index].on_date);
                String formattedDate = DateFormat('dd-MM-yyyy').format(onDate);
                return GestureDetector(
                    onTap: () {
                      String examId = resultList[index].exam_id;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultDetail(examId),
                        ),
                      );
                    },
                    child: Padding(
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
                                resultList[index].exam_title,
                                style: TextStyle(
                                  color: olive0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                SizedBox(height: 10,),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text('Notes', style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('Date', style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: olive5),),

                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          Text(
                                              '${resultList[index].exam_note}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text('$formattedDate',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: olive7)),
                                          SizedBox(
                                            height: 5,
                                          ),
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
                    )
                );
              },
            );
          } else {
            return Center(
              child: Text('No results found'),
            );
          }
        },
      ),
    );
  }
}
