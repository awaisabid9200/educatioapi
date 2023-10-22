import 'package:educatioapi/Constants/Colors.dart';
import 'package:educatioapi/SplachScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp
    (
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: olive4)),
    debugShowCheckedModeBanner: false,
    home: SplachScreen(),));
}
