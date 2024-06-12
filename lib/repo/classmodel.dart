

class ApiResponse {
  List<ClassListing> classListing;

  ApiResponse({
    required this.classListing,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      classListing: List<ClassListing>.from(json['class_listing'].map((x) => ClassListing.fromJson(x))),
    );
  }
}

class ClassListing {
  String classId;
  String className;
  List<String> subjectId;
  List<String> subjectName;

  ClassListing({
    required this.classId,
    required this.className,
    required this.subjectId,
    required this.subjectName,
  });

  factory ClassListing.fromJson(Map<String, dynamic> json) {
    return ClassListing(
      classId: json['class_id'],
      className: json['class_name'],
      subjectId: List<String>.from(json['subject_id']),
      subjectName: List<String>.from(json['subject_name']),
    );
  }
}