


class Meeting {
  final String id;
  final String tutorId;
  final String meetingId;
  final String fullCode;
  final String clientId;
  final String clientName;
  final String zoomLink;
  final String meetingPassword;
  final String meetingHostkey;
  final String datetime;
  final String cityId;
  final String teacherName;
  final String areaName;
  final String unreadCount;
  final String className;
  final String subjects;

  Meeting({
    required this.id,
    required this.tutorId,
    required this.meetingId,
    required this.fullCode,
    required this.clientId,
    required this.clientName,
    required this.zoomLink,
    required this.meetingPassword,
    required this.meetingHostkey,
    required this.datetime,
    required this.cityId,
    required this.teacherName,
    required this.areaName,
    required this.unreadCount,
    required this.className,
    required this.subjects,
  });

  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ?? '',
      tutorId: json['tutor_id'] ?? '',
      meetingId: json['meeting_id'] ?? '',
      fullCode: json['full_code'] ?? '',
      clientId: json['client_id'] ?? '',
      clientName: json['client_name'] ?? '',
      zoomLink: json['zoom_link'] ?? '',
      meetingPassword: json['meeting_password'] ?? '',
      meetingHostkey: json['meeting_hostkey'] ?? '',
      datetime: json['datetime'] ?? '',
      cityId: json['city_id'] ?? '',
      teacherName: json['teacher_name'] ?? '',
      areaName: json['area_name'] ?? '',
      unreadCount: json['unread_count'] ?? '',
      className: json['class'] ?? '',
      subjects:  json['subjects'] ?? '',
    );
  }
}
