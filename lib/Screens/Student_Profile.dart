import 'dart:convert';
import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Constants/consturl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PersonDataScreen extends StatefulWidget {
  @override
  _PersonDataScreenState createState() => _PersonDataScreenState();
}

class _PersonDataScreenState extends State<PersonDataScreen>
    with TickerProviderStateMixin {
  String profileUserName = '';
  String profileDate = '';
  String profileRollNo = '';
  String profileAddress = '';
  String profileCity = '';
  String profileSemester = '';
  String profilePhone = '';
  String profileParent = '';
  String profileEmail = '';
  String profilrBranch = '';
  String profileBatch= '';
  String profileDivision = '';

  final String url = ConstValue.STUDENT_PROFILE_URL;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String studentId = preferences.getString('student_id') ?? '';

    final response = await http.post(
      Uri.parse(url),
      body: {'student_id': studentId},
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);

      setState(() {
        profileUserName = responseData['data']['student_name'];
        profileDate = responseData['data']['student_birthdate'];
        profileRollNo = responseData['data']['student_roll_no'];
        profileAddress = responseData['data']['student_address'];
        profilrBranch = responseData['data']['student_branch'];
        profileBatch = responseData['data']['student_batch'] ;
        profileDivision = responseData['data']['student_division'];
        profileCity = responseData['data']['student_city'];
        profileSemester = responseData['data']['student_semester'];
        profilePhone = responseData['data']['student_phone'];
        profileParent = responseData['data']['student_parent_phone'];
        profileEmail = responseData['data']['student_email'];
      });
    } else {
      // Handle error
      print('Error: ${response.statusCode}');
    }

    // Simulate a 3-second delay
    await Future.delayed(Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });
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
        title: Text('Student Profile',style: TextStyle(color: olive6)),
      ),
      body: isLoading
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
            ) // Show a loading indicator if data is being fetched
          : ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) {
                switch (index) {
                  case 1:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        color: olive1,
                        child: Image.asset('assets/images/profile_illus.png'),
                      ),
                    );
                  case 2 :
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        width: double.infinity,
                        color: olive5,
                        child: Text('Contact Details',style: TextStyle(color: olive0,fontWeight: FontWeight.bold,fontSize: 16)),
                      ),
                    );
                  case 3:
                    return itemDesign(
                        'Name', profileUserName, CupertinoIcons.person_alt);
                  case 4:
                    return itemDesign('Roll No', profileRollNo,
                        CupertinoIcons.number_square_fill);
                  case 5:
                    return itemDesign(
                        'Semester', profileSemester, Icons.class_);
                  case 6:
                    return itemDesign('Birthday', profileDate,
                        Icons.cake);
                  case 7:
                    return itemDesign('Branch', profilrBranch+'Null',
                        CupertinoIcons.house_alt) ;
                  case 8:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 10),
                        height: 50,
                        width: double.infinity,
                        color: olive5,
                        child: Text('Contact Details',style: TextStyle(color: olive0,fontWeight: FontWeight.bold,fontSize: 16)),
                      ),
                    );
                  case 9:
                    return itemDesign('Address', profileAddress,
                        CupertinoIcons.home);
                  case 10:
                    return itemDesign(
                        'City', profileCity, Icons.maps_home_work_rounded);
                  case 11:
                    return itemDesign('Phone', profilePhone,
                        CupertinoIcons.phone_circle_fill);
                  case 12:
                    return itemDesign(
                        'Email', profileEmail, Icons.email_rounded);
                  case 13:
                    return itemDesign('Parent Phone', profileParent,
                        CupertinoIcons.phone_down_circle_fill);
                  default:
                    return SizedBox.shrink();
                }
              },
            ),
    );
  }


  Widget itemDesign(String title, String subtitle, IconData iconData,) =>
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(iconData, size: 18, color: olive5),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: olive7,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          letterSpacing: .2,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: olive4,
                      fontSize: 14,
                      letterSpacing: .5,
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      );
}
