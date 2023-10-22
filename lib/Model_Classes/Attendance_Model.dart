class AttendanceItem {
  final String attendanceId;
  final String schoolId;
  final String standardId;
  final String studentId;
  final String attendanceDate;
  final String attended;
  final String attendanceReason;
  final String onDate;

  AttendanceItem({
    required this.attendanceId,
    required this.schoolId,
    required this.standardId,
    required this.studentId,
    required this.attendanceDate,
    required this.attended,
    required this.attendanceReason,
    required this.onDate,
  });

  factory AttendanceItem.fromJson(Map<String, dynamic> json) {
    return AttendanceItem(
      attendanceId: json['attendence_id'],
      schoolId: json['school_id'],
      standardId: json['standard_id'],
      studentId: json['student_id'],
      attendanceDate: json['attendence_date'],
      attended: json['attended'],
      attendanceReason: json['attendence_reason'],
      onDate: json['on_date'],
    );
  }
}