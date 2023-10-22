class HolidayItem {
  String holidayId;
  String schoolId;
  String holidayTitle;
  String holidayDate;

  HolidayItem(
      {required this.holidayId,
      required this.schoolId,
      required this.holidayTitle,
      required this.holidayDate});

  factory HolidayItem.fromJson(Map<String, dynamic> json) {
    return HolidayItem(
      holidayId: json['holiday_id'].toString(),
      schoolId: json['school_id'].toString(),
      holidayTitle: json['holiday_title'].toString(),
      holidayDate: json['holiday_date'].toString(),
    );
  }
}
