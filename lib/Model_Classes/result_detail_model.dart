

class Detail_Result{

  String subject;
  String mark_obtain;
  String total_mark;

  Detail_Result({
    required this.subject,
    required this.mark_obtain,
    required this.total_mark,

  });

  factory Detail_Result.fromJson(Map <String,dynamic> json){
  return Detail_Result(
  subject: json['subject'],
  mark_obtain: json['mark_obtain'],
  total_mark: json['total_mark'],
  );
  }
}