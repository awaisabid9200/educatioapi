import 'dart:async';

import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/Home_Screen.dart';
import 'package:educatioapi/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  @override
  void initState() {
    isLogin();
    // TODO: implement initState
  }

   isLogin() async {
   SharedPreferences sp = await SharedPreferences.getInstance() ;
   bool isLogin = sp.getBool('isUserLogin') ?? false;

   if(isLogin){
     Timer(Duration(seconds: 2),(){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
     });
   }
   else{
     Timer(Duration(seconds: 2),(){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>SignIn()));
     });
   }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: olive1,
      body: Center(
        child: Column(
          children: [
            Expanded(child: Image.asset('assets/images/SU.png',height: 120,width: 120,)),
            Container(
              height: 100,
              child: Column(
                children: [
                  Text('From',style: TextStyle(color: olive7,fontSize: 14,letterSpacing: 1)),
                  SizedBox(height: 10,),
                  Text('StepUp',style: TextStyle(color: olive6,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
