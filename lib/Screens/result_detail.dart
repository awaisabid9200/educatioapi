import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Model_Classes/result_detail_model.dart';

class ResultDetail extends StatefulWidget {
  final String examId;

  ResultDetail(this.examId);

  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail>
    with SingleTickerProviderStateMixin {
  Future<List<Detail_Result>>? _resultListDetail;
  late String storedExamId;
  final String url = ConstValue.RESULTS_REPORT_URL;
  late int obtainMarks = 0;
  late int totalMarks = 0;
  late double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    _resultListDetail = urlDetail();
    storedExamId = widget.examId;
  }

  Future<List<Detail_Result>> urlDetail() async {
    SharedPreferences pref_detail = await SharedPreferences.getInstance();
    String student_id = pref_detail.getString('student_id') ?? '';
    String exam_id = storedExamId;
    print(exam_id);
    print(student_id);

    final response = await http.post(Uri.parse(url),
        body: {'student_id': student_id, 'exam_id': exam_id});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      List<Detail_Result> results = List<Detail_Result>.from(responseData['data']
          .map((x) => Detail_Result.fromJson(x)));
      return results;
    } else {
      throw Exception('Failed to fetch results');
    }
  }

  int calculateObtainMarks(List<Detail_Result>? resultList) {
    obtainMarks = 0;
    if (resultList != null) {
      for (var result in resultList) {
        obtainMarks += int.parse(result.mark_obtain);
      }
    }
    return obtainMarks;
  }

  int calculateTotalMarks(List<Detail_Result>? resultList) {
    totalMarks = 0;
    if (resultList != null) {
      for (var result in resultList) {
        totalMarks += int.parse(result.total_mark);
      }
    }
    return totalMarks;
  }

  // Percentage
  double calculatePercentage(int obtainMarks, int totalMarks) {
    if (totalMarks == 0) {
      return 0.0;
    } else {
      return (obtainMarks / totalMarks) * 100;
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
          icon: Icon(Icons.arrow_back, color: olive6),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Result Detail', style: TextStyle(color: olive6)),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: olive3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    FutureBuilder<List<Detail_Result>>(
                      future: _resultListDetail,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              color: olive7,
                            ),
                          );
                        } else if (snapshot.hasData) {
                          List<Detail_Result>? resultList = snapshot.data;
                          obtainMarks = calculateObtainMarks(resultList);
                          totalMarks = calculateTotalMarks(resultList);
                          percentage =
                              calculatePercentage(obtainMarks, totalMarks);
                          return Row(
                            children: [
                              Text('$obtainMarks',
                                  style: TextStyle(
                                      color: olive7,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26)),
                              Text('/',
                                  style: TextStyle(
                                      color: olive4,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26)),
                              Text('$totalMarks',
                                  style: TextStyle(
                                      color: olive7,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 26)),
                            ],
                          );
                        } else {
                          return Text(
                            'N/A',
                            style: TextStyle(
                                color: olive7,
                                fontWeight: FontWeight.w500,
                                fontSize: 26),
                          );
                        }
                      },
                    ),
                  ],
                ),
                FutureBuilder<List<Detail_Result>>(
                  future: _resultListDetail,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return SizedBox(
                        width: 26,
                        height: 26,
                        child: CircularProgressIndicator(
                          color: olive7,
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List<Detail_Result>? resultList = snapshot.data;
                      obtainMarks = calculateObtainMarks(resultList);
                      totalMarks = calculateTotalMarks(resultList);
                      percentage =
                          calculatePercentage(obtainMarks, totalMarks);
                      return Text('${percentage.toStringAsFixed(2)}%',
                          style: TextStyle(
                              color: olive7,
                              fontWeight: FontWeight.w500,
                              fontSize: 26));
                    } else {
                      return Text(
                        'N/A',
                        style: TextStyle(
                            color: olive7,
                            fontWeight: FontWeight.w500,
                            fontSize: 26),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Container(
            height: 60,
            color: olive4,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subject',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Row(
                    children: [
                      Text(
                        'Obtain',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Detail_Result>>(
              future: _resultListDetail,
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
                  List<Detail_Result>? resultList = snapshot.data;
                  return ListView.builder(
                    itemCount: resultList!.length + 1,
                    itemBuilder: (context, index) {
                      if (index == resultList.length) {
                        // Last item in the list
                        return Container(
                          color: olive6,
                          child: ListTile(
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Marks',
                                  style: TextStyle(
                                    color: olive1,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '$obtainMarks',
                                      style: TextStyle(
                                        color: olive2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '$totalMarks',
                                      style: TextStyle(
                                        color: olive2,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          color: olive1,
                          child: ListTile(
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    resultList[index].subject,
                                    style: TextStyle(
                                      color: olive7,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${resultList[index].mark_obtain}',
                                      style: TextStyle(
                                        color: olive5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      '${resultList[index].total_mark}',
                                      style: TextStyle(
                                        color: olive5,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  return Center(
                    child: Text('No results found'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
