class Tuition {
  final String tuitionId;
  final String tuitionName;
  final String className;
  final String subject;
  final String location;
  final String onlineTermsText;

  Tuition({
    required this.tuitionId,
    required this.tuitionName,
    required this.className,
    required this.subject,
    required this.location,
    required this.onlineTermsText,
  });

  // Factory method to create Tuition from JSON
  factory Tuition.fromJson(Map<String, dynamic> json) {
    return Tuition(
      tuitionId: json['tuition_id'],
      tuitionName: json['tuition_name'],
      className: json['class_name'],
      subject: json['subject'],
      location: json['location'],
      onlineTermsText: json['Online_terms_check_text'],
    );
  }
}