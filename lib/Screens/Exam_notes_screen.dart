import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Model_Classes/Exam_Model.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ExamNotes extends StatefulWidget {
  const ExamNotes({Key? key}) : super(key: key);

  @override
  State<ExamNotes> createState() => _ExamNotesState();
}

class _ExamNotesState extends State<ExamNotes> with TickerProviderStateMixin {


  Future<List<ExamModel>> fetchData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String school_id = sp.getString('school_id') ?? '';
    String standard_id = sp.getString('standard_id') ?? '';
    sp.setString('standard_id',standard_id);


    print(school_id);
    print(standard_id);

    final response = await http.post(
      Uri.parse(ConstValue.EXAMS_URL),
      body: {'school_id': school_id, 'standard_id': standard_id},
    );

    if (response.statusCode == 200) {
      final responsedata = json.decode(response.body);
      List<ExamModel> exams = List<ExamModel>.from(
          responsedata['data'].map((x) => ExamModel.fromJson(x)));
      return exams;
    } else {
      print('Error${response.statusCode}');
      throw Exception('Failed to fetch data');
    }
  }

// date formate
  String formatDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate =
        "${parsedDate.day.toString().padLeft(2, '0')}/${parsedDate.month.toString().padLeft(2, '0')}/${parsedDate.year.toString()}";
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          title: Text('Exam Details',style: TextStyle(color: olive6)),
        ),
        body: FutureBuilder<List<ExamModel>?>(
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
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Failed to fetch data'),
              );
            } else if (snapshot.hasData) {
              List<ExamModel> examList = snapshot.data!;
              // Use the null-aware operator (!) to safely assign the non-nullable value
              return ListView.builder(
                itemCount: examList.length,
                itemBuilder: (context, index) {
                  String formattedDueDate = formatDate(examList[index].examDate);
                  String formattedLastDate = formatDate(examList[index].onDate);
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
                              examList[index].examTitle,
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
                                        Text('Notes',style: TextStyle(
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
                                            '${examList[index].examNote}',style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: olive7)
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text( '$formattedDueDate',style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: olive7)),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text('$formattedLastDate',style: TextStyle(
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
                child: Text('No data available'),
              );
            }
          },
        ),
      ),
    );
  }

}
