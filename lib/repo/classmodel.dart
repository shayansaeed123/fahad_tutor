import 'dart:convert';

class MyClass {
  String classId;
  String className;
  List<String> subjectIds;
  List<String> subjectNames;

  MyClass({
    required this.classId,
    required this.className,
    required this.subjectIds,
    required this.subjectNames,
  });

  Map<String, dynamic> toJson() {
    return {
      'class_id': classId,
      'class_name': className,
      'subject_id': subjectIds,
      'subject_name': subjectNames,
    };
  }

  @override
  String toString() {
    return jsonEncode(toJson());
  }
}