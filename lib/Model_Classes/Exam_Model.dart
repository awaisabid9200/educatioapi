class ExamModel {
  final String examId;
  final String schoolId;
  final String examTitle;
  final String examNote;
  final String examStatus;
  final String examStandard;
  final String examDate;
  final String onDate;

  ExamModel({
    required this.examId,
    required this.schoolId,
    required this.examTitle,
    required this.examNote,
    required this.examStatus,
    required this.examStandard,
    required this.examDate,
    required this.onDate,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      examId: json['exam_id'],
      schoolId: json['school_id'],
      examTitle: json['exam_title'],
      examNote: json['exam_note'],
      examStatus: json['exam_status'],
      examStandard: json['exam_standard'],
      examDate: json['exam_date'],
      onDate: json['on_date'],
    );
  }
}
