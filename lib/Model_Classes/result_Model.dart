import 'package:flutter/material.dart';

class Result_model{
  String exam_id;
  String school_id;
  String exam_title;
  String exam_note;
  String exam_status;
  String exam_standard;
  String exam_date;
  String on_date;

  Result_model({
   required this.exam_id,
   required this.school_id,
   required this.exam_title,
    required this.exam_note,
    required this.exam_status,
    required this.exam_standard,
    required this.exam_date,
    required this.on_date,
});

  factory Result_model.fromJson(Map<String,dynamic> json){
    return Result_model(
        exam_id: json['exam_id'],
        school_id: json['school_id'],
        exam_title: json['exam_title'],
        exam_note: json['exam_note'],
        exam_status: json['exam_status'],
        exam_standard: json['exam_standard'],
        exam_date: json['exam_date'],
        on_date: json['on_date']
    );
  }
}
