class NoticeModel {
  final String noticeId;
  final String schoolId;
  final String noticeDescription;
  final String noticeType;
  final String noticeStatus;
  final String onDate;

  NoticeModel({
    required this.noticeId,
    required this.schoolId,
    required this.noticeDescription,
    required this.noticeType,
    required this.noticeStatus,
    required this.onDate,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      noticeId: json['notice_id'],
      schoolId: json['school_id'],
      noticeDescription: json['notice_description'],
      noticeType: json['notice_type'],
      noticeStatus: json['notice_status'],
      onDate: json['on_date'],
    );
  }
}
