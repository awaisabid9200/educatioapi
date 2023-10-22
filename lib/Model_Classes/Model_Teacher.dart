class PostModel {
  String teacherName;
  String teacherEducation;
  String gender;
  String teacherEmail;
  String teacherPhone;

  PostModel({
    required this.teacherName,
    required this.teacherEducation,
    required this.gender,
    required this.teacherPhone,
    required this.teacherEmail,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      teacherName: json['teacher_name'],
      teacherEducation: json['teacher_education'],
      gender: json['gender'],
      teacherPhone: json['teacher_phone'].toString(),
      teacherEmail: json['teacher_email'],
    );
  }
}