class Tuition {
  final String shareDate;
  final String tuitionId;
  final String tuitionName;
  final String className;
  final String subject;
  final int totalApply;
  final String latitude;
  final String longitude;
  final int onlineTermsCheck;
  final String onlineTermsCheckText;
  final String onlineTermsCheckHeading;
  final String location;
  final String remarks;
  final String groupId;
  final String placement;
  final int already;
  final int jobClosed;
  final String limitStatement;

  Tuition({
    required this.shareDate,
    required this.tuitionId,
    required this.tuitionName,
    required this.className,
    required this.subject,
    required this.totalApply,
    required this.latitude,
    required this.longitude,
    required this.onlineTermsCheck,
    required this.onlineTermsCheckText,
    required this.onlineTermsCheckHeading,
    required this.location,
    required this.remarks,
    required this.groupId,
    required this.placement,
    required this.already,
    required this.jobClosed,
    required this.limitStatement,
  });

  factory Tuition.fromJson(Map<String, dynamic> json) {
    return Tuition(
      shareDate: json['share_date'],
      tuitionId: json['tuition_id'],
      tuitionName: json['tuition_name'],
      className: json['class_name'],
      subject: json['subject'],
      totalApply: json['total_apply'],
      latitude: json['lat'],
      longitude: json['log'],
      onlineTermsCheck: json['Online_terms_check'],
      onlineTermsCheckText: json['Online_terms_check_text'],
      onlineTermsCheckHeading: json['Online_terms_check_heading'],
      location: json['location'],
      remarks: json['remarks'],
      groupId: json['group_id'],
      placement: json['Placement'],
      already: json['already'],
      jobClosed: json['job_closed'],
      limitStatement: json['limit_statement'],
    );
  }
}