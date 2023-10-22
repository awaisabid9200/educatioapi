class EventModel {
  final String eventId;
  final String schoolId;
  final String eventTitle;
  final String eventDescription;
  final String eventImage;
  final String eventStart;
  final String eventEnd;
  final String eventStatus;
  final String onDate;

  EventModel({
    required this.eventId,
    required this.schoolId,
    required this.eventTitle,
    required this.eventDescription,
    required this.eventImage,
    required this.eventStart,
    required this.eventEnd,
    required this.eventStatus,
    required this.onDate,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventId: json['event_id'],
      schoolId: json['school_id'],
      eventTitle: json['event_title'],
      eventDescription: json['event_description'],
      eventImage: json['event_image'],
      eventStart: json['event_start'],
      eventEnd: json['event_end'],
      eventStatus: json['event_status'],
      onDate: json['on_date'],
    );
  }
}
