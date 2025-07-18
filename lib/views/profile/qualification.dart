import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/classmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusableselecteditem.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Extension to group list items by a key
extension GroupBy<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keyFn) {
    final Map<K, List<T>> map = {};
    for (var element in this) {
      final key = keyFn(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}

class QualificationAndPreferences extends StatefulWidget {
  const QualificationAndPreferences({super.key});

  @override
  State<QualificationAndPreferences> createState() => _QualificationAndPreferencesState();
}

class _QualificationAndPreferencesState extends State<QualificationAndPreferences> {
  bool isLoading = false;
  bool visible = true;
  TutorRepository repository = TutorRepository();

List<dynamic> newItemsTime = [];
List<Map<String, String>> selectedIdsTime = [];
List<String> selectedNamesTime = [];

List<dynamic> newItemsinstitute = [];
List<Map<String, String>> selectedIdsinstitute = [];
List<String> selectedNamesinstitute = [];

List<dynamic> newItemsQualification = [];
List<Map<String, String>> selectedIdsQualification = [];
List<String> selectedNamesQualification = [];

List<dynamic> newItemsBoard = [];
List<Map<String, String>> selectedIdsBoard = [];
List<String> selectedNamesBoard = [];

List<dynamic> newItemsPreferred = [];
List<Map<String, String>> selectedIdsPreferred = [];
List<String> selectedNamesPreferred = [];

List<dynamic> newItemsGroup = [];
List<Map<String, String>> selectedIdsGroup = [];
List<String> selectedNamesGroup = [];

List<dynamic> newItemsCourse = [];
List<Map<String, String>> selectedIdsCourse = [];
List<String> selectedNamesCourse = [];

List<dynamic> newItemsArea = [];
List<Map<String, String>> selectedIdsArea = [];
List<String> selectedNamesArea = [];

List<dynamic> newItemsExperience = [];
List<dynamic> newItemsExperiencePhysical = [];
// List<Map<String, String>> selectedIdsExperience = [];
// List<String> selectedNamesExperience = [];


List<dynamic> newItemsClass = [];
List<dynamic> selectedIdsClass = [];
List<String> selectedNamesClass = [];

List<dynamic> newItemsSubject = [];
List<Map<String, String>> selectedIdsSubject = [];
List<String> selectedNamesSubject = [];


List<MyClass> selectedClasses = [];


List<String> tempSelectedNamesSubject = [];
List<String> tempSelectedIdsSubject = [];

String instituteName = '';
String instituteId =  '';
String? selectedQuranExperiencePhysical;
String? _rawQuranExperience; // ← jo API se aaye
String? get selectedQuranExperience {
  final valid = newItemsExperience
      .map((e) => e['Experience_name'].toString())
      .toSet();

  return valid.contains(_rawQuranExperience) ? _rawQuranExperience : 'None';
}
String? client = '';
String? maslak = '';
String? Zoom = '';
String? laptop = '';

@override
  void initState() {
    super.initState();
    repository.Check_popup();
    repository.fetchData('Institute','Institute', newItemsinstitute, selectedIdsinstitute, updateSelectedNamesInstitute,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Qualification','Qualification', newItemsQualification, selectedIdsQualification, updateSelectedNamesQualification,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Board', 'Board', newItemsBoard, selectedIdsBoard, updateSelectedNamesBoard,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Group','Group', newItemsGroup, selectedIdsGroup, updateSelectedNamesGroup,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('course','course', newItemsCourse, selectedIdsCourse, updateSelectedNamesCourse,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Preferred_Time','Preferred_Time', newItemsTime, selectedIdsTime, updateSelectedNamesTime,(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsExperience, [], (){},(val)=> setState(() {isLoading = val;}));
    repository.fetchData('Experience_listing','Experience', newItemsExperiencePhysical, [], (){},(val)=> setState(() {isLoading = val;}));
    fetchClassDataAndSubjectData('Class','Class', newItemsClass,);
    saveQualificationData();
    selectArea();
    saveAreaData();
    repository.check_msg();
    allFunction();
  }
  void allFunction()async{
     repository.fetchData('Institute','Institute', newItemsinstitute, selectedIdsinstitute, updateSelectedNamesInstitute,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Qualification','Qualification', newItemsQualification, selectedIdsQualification, updateSelectedNamesQualification,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Board', 'Board', newItemsBoard, selectedIdsBoard, updateSelectedNamesBoard,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Group','Group', newItemsGroup, selectedIdsGroup, updateSelectedNamesGroup,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('course','course', newItemsCourse, selectedIdsCourse, updateSelectedNamesCourse,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Preferred_Time','Preferred_Time', newItemsTime, selectedIdsTime, updateSelectedNamesTime,(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Experience_listing','Experience', newItemsExperience, [], (){},(val)=> setState(() {isLoading = val;}));
     repository.fetchData('Experience_listing','Experience', newItemsExperiencePhysical, [], (){},(val)=> setState(() {isLoading = val;}));
     fetchClassDataAndSubjectData('Class','Class', newItemsClass,);
    await saveQualificationData();
    await selectArea();
    await saveAreaData();
    await repository.check_msg();
  }



  void _validateForm() {
     if (selectedNamesinstitute.isNotEmpty && selectedIdsQualification.isNotEmpty 
     && selectedIdsArea.isNotEmpty && selectedIdsBoard.isNotEmpty 
    //  && selectedIdsCourse.isNotEmpty 
     && selectedIdsGroup.isNotEmpty  && selectedClasses.isNotEmpty 
                        ) {
                  updateStatus();
                } else {
                  Utils.snakbar(
                    context,
                    selectedNamesinstitute.isEmpty
                        ? "Select Atleast 1 Institute"
                        : selectedIdsQualification.isEmpty
                            ? "Select Atleast 1 Qualification"
                            : selectedIdsArea.isEmpty
                            ? "Select Atleast 1 Area"
                            : selectedIdsBoard.isEmpty
                            ? "Select Atleast 1 Board"
                            : selectedIdsGroup.isEmpty
                            ? "Select Atleast 1 Group" 
                            // : selectedIdsCourse.isEmpty
                            // ? "Select Atleast 1 Course" 
                            : selectedClasses.isEmpty
                            ? "Select Atleast 1 Preffered Class with Subject": "Fill Correct Fields",
                  );
                }
  }
  
  Future<void> updateStatus() async {
    setState(() {
      isLoading = true;
    });

    try {
   List<Map<String, dynamic>> classList = selectedClasses.expand((classItem) {
      // return classItem.toJson();
    //   return {
    //   'class_id': classItem.classId,
    //   'subject_id': classItem.subjectIds.join('|'),
    // };
    return classItem.subjectIds.asMap().entries.map((e) => {
    'class_id': classItem.classId,
    'class_name': classItem.className,
    'subject_id': e.value,
    'subject_name': classItem.subjectNames[e.key],
  });
    }).toList();
String classListJson = jsonEncode(classList);

      // Create a new list with the key 'preferred_areas_id' instead of 'id'
      List<Map<String, dynamic>> preferredAreasList = selectedIdsArea.map((area) {
        return {'preferred_areas_id': area['id']};
      }).toList();
      String preferredAreasJson = jsonEncode(preferredAreasList);


      List<Map<String, dynamic>> qualificationId = selectedIdsQualification.map((qualif) {
        return {'Qualification_id': qualif['id']};
      }).toList();
      String qualificationjson = jsonEncode(qualificationId);


      List<Map<String, dynamic>> institude_id = selectedIdsinstitute.map((institute) {
        return {'Institute_id': institute['id']};
      }).toList();
      String institudejson = jsonEncode(institude_id);


      List<Map<String, dynamic>> preferred_borad = selectedIdsBoard.map((board) {
        return {'preferred_board_id': board['id']};
      }).toList();
      String preferredboardjson = jsonEncode(preferred_borad);


      List<Map<String, dynamic>> preferred_group = selectedIdsGroup.map((group) {
        return {'preferred_group_id': group['id']};
      }).toList();
      String preferredgroupjson = jsonEncode(preferred_group);

      List<Map<String, dynamic>> preferred_course = selectedIdsCourse.map((course) {
        return {'preferred_course_id': course['id']};
      }).toList();
      String preferredcoursejson = jsonEncode(preferred_course);

      List<Map<String, dynamic>> preferred_time_query = selectedIdsTime.map((time) {
        return {'Preferred_Time_id': time['id']};
      }).toList();
      String preferredTimejson = jsonEncode(preferred_time_query);

      print(preferredcoursejson);

      Map<String, String> body = {
        'code': '10',
        'update_status': MySharedPrefrence().get_update_status(),
        'tutor_id_edit': MySharedPrefrence().get_user_ID(),
        'preferred_areas': preferredAreasJson,
        'class_listing': classListJson,
        'Institute': institudejson,
        'Degree': qualificationjson,
        'preferred_board': preferredboardjson,
        'preferred_group': preferredgroupjson,
        'preferred_course': preferredcoursejson,
        'preferred_time_query': preferredTimejson,
        'Quran_Experience': selectedQuranExperience ?? '',
        'tutor_quran_teaching_ex': selectedQuranExperiencePhysical ?? '',
        'International_client': client.toString(),
        'Zoom_Proficiency': Zoom.toString(),
        'have_a_laptop': laptop.toString(),
        'Add_Maslak':maslak.toString(),
      };
      print('quran Ex $selectedQuranExperiencePhysical');
      final response = await http.post(
        Uri.parse('${MySharedPrefrence().get_baseUrl()}step_2_update.php'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print(response.body.toString());
      
      if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('updateeeeeeeeeeeeeeeeeeeeeeeee $responseData');
      if (responseData['success'] == 1) {
        // Refetch data to update UI with the latest data
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
        // Utils.snakbarSuccess(context, apiMessage);
      } else {
        print('Error in response data: ${responseData['message']}');
      }
    } else {
      print('Error2: ' + response.statusCode.toString());
    }
  } catch (e) {
    print('error $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
  }
  Future<void> saveAreaData() async {
  try {
    final response = await http.get(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
          selectedIdsArea = (jsonResponse['preferred_area_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          updateSelectedNamesArea();
          print('area selected $selectedIdsArea');
        // });
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to load country details');
    }
  } catch (e) {
    print('area error$e');
  }
}

Future<void> saveQualificationData() async {
  try {
    final response = await http.get(
      Uri.parse('${MySharedPrefrence().get_baseUrl()}step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

          selectedIdsinstitute = (jsonResponse['Institute_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          selectedIdsQualification = (jsonResponse['Institute_Qualification'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          // selectedIdsArea = (jsonResponse['preferred_area_listing'] as List)
          //     .map<Map<String, String>>((item) => {'id': item['id'].toString()})
          //     .toList();
          selectedIdsBoard = (jsonResponse['preferred_board_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          selectedIdsGroup = (jsonResponse['preferred_group_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          selectedIdsCourse = (jsonResponse['preferred_course_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();

          selectedIdsTime = (jsonResponse['preferred_time_query'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();

              // selectedIdsSubject = (jsonResponse['class_listing'] as List)
              // .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              // .toList();
        //   selectedIdsClass = jsonResponse['class_listing'];

        //   setState(() {
        //   selectedClasses = selectedIdsClass.map((item) {
        //     return MyClass(
        //       classId: item['class_id'],
        //       className: item['class_name'],
        //       subjectIds: List<String>.from(item['subject_id']),
        //       subjectNames: List<String>.from(item['subject_name']),
        //     );
        //   }).toList();
        // });

        selectedClasses = (jsonResponse['class_listing'] as List).map((item) {
            return MyClass(
              classId: item['class_id'].toString(),
              className: item['class_name'].toString(),
              subjectIds: List<String>.from(item['subject_id'].map((sid) => sid.toString())),
              subjectNames: List<String>.from(item['subject_name'].map((sname) => sname.toString())),
            );
          }).toList();
          _rawQuranExperience = jsonResponse['Quran_Experience']?.toString();
          selectedQuranExperiencePhysical = jsonResponse['tutor_quran_teaching_ex']?.toString() ?? 'None';
          print('fs,gfd,g $selectedQuranExperiencePhysical');
          client = jsonResponse['International_client'];
          maslak = jsonResponse['Add_Maslak'];
          Zoom = jsonResponse['Zoom_Proficiency'];
          laptop = jsonResponse['have_a_laptop'];
          updateSelectedNamesInstitute();
          updateSelectedNamesQualification();
          updateSelectedNamesBoard();
          updateSelectedNamesGroup();
          updateSelectedNamesCourse();
          updateSelectedNamesArea();
          updateSelectedNamesSubject();
          updateSelectedNamesTime();
        // });
      } else {
        throw Exception('Empty response body');
      }
    } else {
      throw Exception('Failed to load country details');
    }
  } catch (e) {
    print('gfksgdf$e');
  }
}


  Future<void> fetchClassDataAndSubjectData(String type,String responseName, List<dynamic> newItems) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = '${MySharedPrefrence().get_baseUrl()}all_in.php?$type=1';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        Uint8List responseBytes = response.bodyBytes;
        String responseBody = utf8.decode(responseBytes, allowMalformed: true);
        responseBody = repository.removeBom(responseBody);

        if (repository.isJsonValid(responseBody)) {
          dynamic jsonResponse = jsonDecode(responseBody);
          setState(() {
            newItems.clear();
            newItems.addAll(jsonResponse['${responseName}_listing']);
          });
          // print('Updated $responseName list: $newItems');
        } else {
          print('Error: Invalid JSON format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> fetchData(String type,String responseName, List<dynamic> newItems, List<Map<String, String>> selectedIds, Function updateSelectedNames) async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     String url = '${MySharedPrefrence().get_baseUrl()}all_in.php?$type=1';
  //     final response = await http.get(Uri.parse(url));
  //     print('url $url');

  //     if (response.statusCode == 200) {
  //       Uint8List responseBytes = response.bodyBytes;
  //       String responseBody = utf8.decode(responseBytes, allowMalformed: true);
  //       responseBody = repository.removeBom(responseBody);

  //       if (repository.isJsonValid(responseBody)) {
  //         dynamic jsonResponse = jsonDecode(responseBody);
  //         setState(() {
  //           newItems.clear();
  //           if (type == 'course') {
  //             // Flatten course listing map into a list with category info
  //             Map<String, dynamic> courseMap = jsonResponse['${responseName}_listing'];
  //             courseMap.forEach((category, courses) {
  //               for (var course in courses) {
  //                 course['category'] = category;
  //                 newItems.add(course);
  //               }
  //             });
  //           } else {
  //             // For group, just add the list
  //             newItems.addAll(jsonResponse['${responseName}_listing']);
  //           }
  //           // newItems.addAll(jsonResponse['${responseName}_listing']);
  //           updateSelectedNames();
  //         });
  //         // print('Updated $responseName list: $newItems');
  //       } else {
  //         print('Error: Invalid JSON format');
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error hello: $e');
  //   } finally {
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  


// Future<void> saveQualificationData() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     final response = await http.get(
//       Uri.parse('${MySharedPrefrence().get_baseUrl()}step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
//     );
//     print(MySharedPrefrence().get_user_ID());
//     if (response.statusCode == 200) {
//       if (response.body.isNotEmpty) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);

//         selectedIdsinstitute = (jsonResponse['Institute_listing'] as List)
//             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//             .toList();
//         selectedIdsQualification = (jsonResponse['Institute_Qualification'] as List)
//             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//             .toList();
//         selectedIdsArea = (jsonResponse['preferred_area_listing'] as List)
//             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//             .toList();
//         selectedIdsBoard = (jsonResponse['preferred_board_listing'] as List)
//             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//             .toList();
//         selectedIdsGroup = (jsonResponse['preferred_group_listing'] as List)
//             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//             .toList();
//         selectedIdsClass = jsonResponse['class_listing'];

//         setState(() {
//           selectedClasses = selectedIdsClass.map((item) {
//             return MyClass(
//               classId: item['class_id'],
//               className: item['class_name'],
//               subjectIds: List<String>.from(item['subject_id']),
//               subjectNames: List<String>.from(item['subject_name']),
//             );
//           }).toList();
//         });

//         MySharedPrefrence().set_city_id(jsonResponse['city_id']);
//         MySharedPrefrence().set_update_status(jsonResponse['update_status']);
//         print(MySharedPrefrence().get_update_status());


//         updateSelectedNamesInstitute();
//         updateSelectedNamesQualification();
//         updateSelectedNamesBoard();
//         updateSelectedNamesGroup();
//         updateSelectedNamesArea();
//         updateSelectedNamesSubject();
//       } else {
//         throw Exception('Empty response body');
//       }
//     } else {
//       throw Exception('Failed to load country details');
//     }
//   } catch (e) {
//     print('dsfdsf $e');
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }

Future<void> selectArea() async {
    setState(() {
      isLoading = true;
    });
    try {
      print('heell ${MySharedPrefrence().get_city_id()}');
      final response = await http.post(
          Uri.parse('${MySharedPrefrence().get_baseUrl()}area.php'),
          body: {
            'code': '10',
            'city_id': MySharedPrefrence().get_city_id(),
          });
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final Map<String, dynamic> jsonResponse = json.decode(response.body);
          newItemsArea = jsonResponse['area_listing'];
          // print('Areassss $newItemsArea');
        } else {
          throw Exception('Empty response body');
        }
        setState(() {
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load country details');
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void updateSelectedNamesInstitute() {
  selectedNamesinstitute = selectedIdsinstitute.map((selected) {
    return (newItemsinstitute.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'names': 'Unknown'},
    )['names'] as String);
  }).toList();
  }

void updateSelectedNamesQualification() {
  selectedNamesQualification = selectedIdsQualification.map((selected) {
    return (newItemsQualification.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'degree_title': 'Unknown'},
    )['degree_title'] as String);
  }).toList();
}

void updateSelectedNamesBoard() {
  selectedNamesBoard = selectedIdsBoard.map((selected) {
    return (newItemsBoard.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'board_name': 'Unknown'},
    )['board_name'] as String);
  }).toList();
  // print('Selected Board Names: $selectedNamesBoard');
}

void updateSelectedNamesGroup() {
  selectedNamesGroup = selectedIdsGroup.map((selected) {
    return (newItemsGroup.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'group_name': 'Unknown'},
    )['group_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

void updateSelectedNamesCourse() {
  selectedNamesCourse = selectedIdsCourse.map((selected) {
    return (newItemsCourse.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'course_name': 'Unknown'},
    )['course_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

void updateSelectedNamesArea() {
  selectedNamesArea = selectedIdsArea.map((selected) {
    return (newItemsArea.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'area_name': 'Unknown'},
    )['area_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

void updateSelectedNamesTime() {
  selectedNamesTime = selectedIdsTime.map((selected) {
    return (newItemsTime.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'name': 'Unknown'},
    )['name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

void updateSelectedNamesClass() {
  selectedNamesArea = selectedIdsArea.map((selected) {
    return (newItemsArea.firstWhere(
      (item) => item['class_id'] == selected['class_id'],
      orElse: () => {'class_name': 'Unknown'},
    )['class_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

void updateSelectedNamesSubject() {
  selectedNamesArea = selectedIdsArea.map((selected) {
    return (newItemsArea.firstWhere(
      (item) => item['subject_id'] == selected['subject_id'],
      orElse: () => {'subject_name': 'Unknown'},
    )['subject_name'] as String);
  }).toList();
  // print('Selected Group Names: $selectedNamesGroup');
}

// void updateSelectedNamesExperience() {
//   selectedNamesExperience = selectedIdsExperience.map((selected) {
//     return (newItemsExperience.firstWhere(
//       (item) => item['id'] == selected['id'],
//       orElse: () => {'Experience_name': 'Unknown'},
//     )['Experience_name'] as String);
//   }).toList();
//   // print('Selected Group Names: $selectedNamesGroup');
// }

void toggleSelection(String id, String name, String itemType) {
  setState(() {
    List<Map<String, String>> selectedIds;
    List<String> selectedNames;
    List<dynamic> newItems;
    Function updateSelectedNames;

    switch (itemType) {
      case 'names':
        selectedIds = selectedIdsinstitute;
        selectedNames = selectedNamesinstitute;
        newItems = newItemsinstitute;
        updateSelectedNames = updateSelectedNamesInstitute;
        break;
      case 'degree_title':
        selectedIds = selectedIdsQualification;
        selectedNames = selectedNamesQualification;
        newItems = newItemsQualification;
        updateSelectedNames = updateSelectedNamesQualification;
        break;
      case 'board_name':
        selectedIds = selectedIdsBoard;
        selectedNames = selectedNamesBoard;
        newItems = newItemsBoard;
        updateSelectedNames = updateSelectedNamesBoard;
        break;
      case 'group_name':
        selectedIds = selectedIdsGroup;
        selectedNames = selectedNamesGroup;
        newItems = newItemsGroup;
        updateSelectedNames = updateSelectedNamesGroup;
        break;
      case 'course_name':
        selectedIds = selectedIdsCourse;
        selectedNames = selectedNamesCourse;
        newItems = newItemsCourse;
        updateSelectedNames = updateSelectedNamesCourse;
        break;
      case 'area_name':
        selectedIds = selectedIdsArea;
        selectedNames = selectedNamesArea;
        newItems = newItemsArea;
        updateSelectedNames = updateSelectedNamesArea;
        break;
      case 'name':
        selectedIds = selectedIdsTime;
        selectedNames = selectedNamesTime;
        newItems = newItemsTime;
        updateSelectedNames = updateSelectedNamesTime;
        break;
      // case 'class_name':
      //   selectedIds = selectedIdsClass;
      //   selectedNames = selectedNamesClass;
      //   newItems = newItemsClass;
      //   updateSelectedNames = updateSelectedNamesClass;
      //   break;
      case 'subject_name':
        selectedIds = selectedIdsSubject;
        selectedNames = selectedNamesSubject;
        newItems = newItemsSubject;
        updateSelectedNames = updateSelectedNamesSubject;
        break;
      default:
        return;
    }

    if (selectedIds.any((element) => element['id'] == id)) {
      selectedIds.removeWhere((element) => element['id'] == id);
      selectedNames.remove(name);
    } else {
      // Check length constraint only for 'names' and 'degree_title'
      if (itemType == 'names' || itemType == 'degree_title') {
        if (selectedIds.length < 2) {
          selectedIds.add({'id': id});
          selectedNames.add(name);
        } else {
          Utils.snakbar(context, 'Select only 2');
        }
      } else if (itemType == 'course_name') {
        if (selectedIds.length < 6) {
          selectedIds.add({'id': id});
          selectedNames.add(name);
        } else {
          Utils.snakbar(context, 'Select only 6');
        }
      } else {
        selectedIds.add({'id': id});
        selectedNames.add(name);
      }
    }

    updateSelectedNames();
  });
}

Future<void> selectSubject(Function parentSetState) {
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredItemsSubject = List.from(newItemsSubject); // Initial list to display

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<dynamic> tempList = [];
      newItemsSubject.forEach((item) {
        if (item['subject_name'].toString().toLowerCase().contains(query.toLowerCase())) {
          tempList.add(item);
        }
      });
      parentSetState(() {
        filteredItemsSubject.clear();
        filteredItemsSubject.addAll(tempList);
      });
    } else {
      parentSetState(() {
        filteredItemsSubject.clear();
        filteredItemsSubject.addAll(newItemsSubject);
      });
    }
  }

  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: colorController.whiteColor,
          surfaceTintColor: colorController.whiteColor,
            // title: Text('Select Subject'),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 0.0),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 11.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      // filterSearchResults(value);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItemsSubject.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<dynamic> filteredItems = List.from(filteredItemsSubject);
                        bool isSelected = tempSelectedIdsSubject.contains(filteredItemsSubject[index]['id'].toString());
                        return Column(
                          children: [
                            ListTile(
                          // title: Text(filteredItemsSubject[index]['subject_name']),
                          dense: true,
                              contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                              title: reusableText(filteredItemsSubject[index]['subject_name'],fontsize: 12,color: colorController.lightblackColor),
                          trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                tempSelectedIdsSubject.remove(filteredItemsSubject[index]['id']);
                                tempSelectedNamesSubject.remove(filteredItemsSubject[index]['subject_name']);
                              } else {
                                tempSelectedIdsSubject.add(filteredItemsSubject[index]['id']);
                                tempSelectedNamesSubject.add(filteredItemsSubject[index]['subject_name']);
                              }
                            });
                            parentSetState(() {});
                          },
                        ),
                      if (index != filteredItems.length - 1)
                            Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                          ]
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: reusableBtn(context, 'Add', () {
                          Navigator.pop(context);
                        }, width: .4),
                      ),
                      reusablaSizaBox(context, .03),
                      Expanded(child: reusablewhite(context, 'Cancel', () {
                        tempSelectedIdsSubject.clear();
                        tempSelectedNamesSubject.clear();
                        Navigator.pop(context);
                      }, width: .5)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

// Future<void> selectSubject(Function parentSetState){
//   return showDialog(
//                         context: context,
//                         builder: (context) {
//                           return 
//                           StatefulBuilder(
//                             builder: (context, setState) {
//                               return 
//                               AlertDialog(
//                                 title: Text('Select Subject'),
//                                 content: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Expanded(
//                                       child: Container(
//                                         width: MediaQuery.of(context).size.width * .9,
//                                         child: ListView.builder(
//                                           shrinkWrap: true,
//                                           itemCount: newItemsSubject.length,
//                                           itemBuilder: (BuildContext context, int index) {
//                                             bool isSelected = tempSelectedIdsSubject.contains(newItemsSubject[index]['id'].toString());
//                                             return ListTile(
//                                               title: Text(newItemsSubject[index]['subject_name']),
//                                               trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                                               onTap: () {
//                                                 setState(() {
//                                                   print('object');
//                                                   if (isSelected) {
//                                                     tempSelectedIdsSubject.remove(newItemsSubject[index]['id']);
//                                                     tempSelectedNamesSubject.remove(newItemsSubject[index]['subject_name']);
//                                                   } else {
//                                                     tempSelectedIdsSubject.add(newItemsSubject[index]['id']);
//                                                     tempSelectedNamesSubject.add(newItemsSubject[index]['subject_name']);
//                                                   }
//                                                 });
//                                                 parentSetState((){});
//                                               },
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Row(
//                                         children: [
//                                           reusableBtn(context, 'Add', () {
//                                             setState(() {
//                                               Navigator.pop(context);
//                                             });

//                                           }, width: .4),
//                                           reusablaSizaBox(context, .03),
//                                           Expanded(child: reusablewhite(context, 'Cancel', () {
//                                             setState(() {});
//                                             tempSelectedIdsSubject.clear();
//                                             tempSelectedNamesSubject.clear();
//                                             Navigator.pop(context);
//                                           }, width: .5)),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
// }

void showCustomSnackbar(BuildContext context, String message) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          decoration: BoxDecoration(
            color: Color(0xFFbe0000),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );

  // Insert the OverlayEntry into the Overlay
  Overlay.of(context)?.insert(overlayEntry);

  // Remove the overlay after a delay
  Future.delayed(Duration(seconds: 2), () {
    overlayEntry.remove();
  });
}


Future<void> classSelect(Function parentSetState) {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> filteredItemsClass = List.from(newItemsClass);
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return 
          SingleChildScrollView(
            child: 
            Stack(
              children: [
                Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    reusableText(
                      'Add New Class',
                      color: colorController.blackColor,
                      fontsize: 20,
                      fontweight: FontWeight.bold,
                    ),
                    reusablaSizaBox(context, .030),
                    reusableText('Add new class with Subject',color: colorController.lightblackColor),
                    reusablaSizaBox(context, .010),
                    reusablequlification(
                      context,
                      MySharedPrefrence().get_class_name_institute() == ''
                          ? 'Select Class'
                          : MySharedPrefrence().get_class_name_institute(),
                      () {
            //             List<dynamic> filteredItemsClass = List.from(newItemsClass);
            //             void filterSearchResults(String query) {
            //     if (query.isNotEmpty) {
            //       List<dynamic> tempList = [];
            //       newItemsClass.forEach((item) {
            //         if (item['class_name'].toString().toLowerCase().contains(query.toLowerCase())) {
            // tempList.add(item);
            //         }
            //       });
            //       parentSetState(() {
            //         filteredItemsClass.clear();
            //         filteredItemsClass.addAll(tempList);
            //       });
            //     } else {
            //       parentSetState(() {
            //         filteredItemsClass.clear();
            //         filteredItemsClass.addAll(newItemsClass);
            //       });
            //     }
            //   }
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (BuildContext context,StateSetter innerSetState) {
                                void filterSearchResults(String query) {
                                List<dynamic> tempList = [];
                                if (query.isNotEmpty) {
                                  tempList = newItemsClass
                                      .where((item) => item['class_name']
                                          .toString()
                                          .toLowerCase()
                                          .contains(query.toLowerCase()))
                                      .toList();
                                } else {
                                  tempList = List.from(newItemsClass);
                                }

                                innerSetState(() {
                                  filteredItemsClass = tempList;
                                });
                              }
                                return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              backgroundColor: colorController.whiteColor,
                                              surfaceTintColor: colorController.whiteColor,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: TextField(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              hintText: 'Search',
                                              hintStyle: TextStyle(fontSize: 11.5),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10.0),
                                              ),
                                              prefixIcon: Icon(Icons.search),
                                            ),
                                            autofocus: true,
                                        onChanged: filterSearchResults,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                            width: MediaQuery.of(context).size.width * .9,
                                            child: filteredItemsClass.isEmpty
                                            ? Center(child: Text("No matching class found"))
                                            : ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: filteredItemsClass.length,
                                              itemBuilder: (BuildContext context, int index) {
                                                List<dynamic> filteredItems = List.from(filteredItemsClass);
                                                return Column(
                                                  children: [
                                                    ListTile(
                                                      dense: true,
                                                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                                                      title: reusableText(filteredItemsClass[index]['class_name'], fontsize: 12, color: colorController.lightblackColor),
                                                      onTap: () {
                                                        setState(() {
                                                          tempSelectedIdsSubject.clear(); // Clear the list
                                                          tempSelectedNamesSubject.clear(); // Clear the list
                                                          MySharedPrefrence().set_class_id(filteredItemsClass[index]['id']);
                                                          MySharedPrefrence().set_class_name_institute(filteredItemsClass[index]['class_name']);
                                                          fetchClassDataAndSubjectData(
                                'class_id=${MySharedPrefrence().get_class_id()}&Subject',
                                'Subject',
                                newItemsSubject,
                                                          ).then((_) {
                                setState(() {}); // Update the state after fetching data
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                    if (index != filteredItems.length - 1)
                                                      Divider(
                                                        color: Colors.grey,
                                                        thickness: 1.0,
                                                      ),
                                                  ],
                                                );
                                              },
                                            ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                              }
                            );
                          },
                        );
                      },
                    ),
                    reusablaSizaBox(context, .030),
                    reusablequlification(
                      context,
                      'Select Subject',
                      () async {
                        await selectSubject(setState);
                        setState(() {});
                      },
                    ),
                    reusablaSizaBox(context, .030),
                    ListView.builder(
                      // physics: NeverScrollableScrollPhysics(), // disables scroll inside scroll
                      shrinkWrap: true, // so it doesn't try to expand
                      itemCount: tempSelectedNamesSubject.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index < tempSelectedNamesSubject.length) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: MediaQuery.of(context).size.height * .006,
                                    horizontal: MediaQuery.of(context).size.width * .01),
                                decoration: BoxDecoration(
                                  color: colorController.qualificationItemsColors,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        tempSelectedNamesSubject[index],
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: colorController.whiteColor,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          tempSelectedIdsSubject.removeAt(index);
                                          tempSelectedNamesSubject.removeAt(index);
                                        });
                                      },
                                      child: Icon(Icons.cancel, color: colorController.whiteColor, size: 20.0),
                                    ),
                                  ],
                                ),
                              ),
                              reusablaSizaBox(context, .015),
                            ],
                          );
                        } else {
                          return Container(); 
                        }
                      },
                    ),
                    reusablaSizaBox(context, .030),
                    Row(
                      children: [
                        Expanded(
                          child: reusableBtn(
                            context,
                            'Add',
                            () {
                              // setState(() {
                              //   selectedClasses.add(
                              //     MyClass(
                              //       classId: MySharedPrefrence().get_class_id(),
                              //       className: MySharedPrefrence().get_class_name_institute(),
                              //       subjectIds: List.from(tempSelectedIdsSubject),
                              //       subjectNames: List.from(tempSelectedNamesSubject),
                              //     ),
                              //   );
                              //   tempSelectedIdsSubject.clear();
                              //   tempSelectedNamesSubject.clear();
                              // });
                              // Navigator.pop(context);
            
            // Check if both class and subject(s) are selected
            if (MySharedPrefrence().get_class_id() == null ||
                MySharedPrefrence().get_class_name_institute() == '' ||
                tempSelectedNamesSubject.isEmpty) {
              showCustomSnackbar(context, 'Please select both a class and at least one subject.');
            } else {
              // Check if the selected class is already added
              bool classAlreadyExists = selectedClasses.any((classItem) =>
                  classItem.classId == MySharedPrefrence().get_class_id());
            
              if (classAlreadyExists) {
                showCustomSnackbar(context, 'This class is already added.');
              } else {
                setState(() {
                  selectedClasses.add(
                    MyClass(
                      classId: MySharedPrefrence().get_class_id(),
                      className: MySharedPrefrence().get_class_name_institute(),
                      subjectIds: List.from(tempSelectedIdsSubject),
                      subjectNames: List.from(tempSelectedNamesSubject),
                    ),
                  );
                  tempSelectedIdsSubject.clear();
                  tempSelectedNamesSubject.clear();
                });
                Navigator.pop(context);
              }
            }
                    },
                            width: .34,
                          ),
                        ),
                        Expanded(
                          child: reusablewhite(
                            context,
                            'Cancel',
                            () {
                              Navigator.pop(context);
                            },
                            width: .5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // if(isLoading == true)
            //   reusableloadingrow(context, isLoading),
              ],
            ),
          );
        },
      );
    },
  );
}


// Future<void> classSelect() {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//         builder: (BuildContext context,StateSetter setState) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             backgroundColor: Colors.white,
//             child: Padding(
//                   padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       reusableText(
//                         'Add New Class',
//                         color: colorController.blackColor,
//                         fontsize: 22,
//                         fontweight: FontWeight.bold,
//                       ),
//                       reusablaSizaBox(context, .030),
//                       reusableText('Add new class with Subject'),
//                       reusablaSizaBox(context, .010),
//                       reusablequlification(
//                         context,
//                         MySharedPrefrence().get_class_name_institute() == ''
//                             ? 'Select Class'
//                             : MySharedPrefrence().get_class_name_institute(),
//                         () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 title: Text('Select Class'),
//                                 content: Container(
//                                   width: double.minPositive,
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     itemCount: newItemsClass.length,
//                                     itemBuilder: (BuildContext context, int index) {
//                                       return ListTile(
//                                         title: Text(newItemsClass[index]['class_name']),
//                                         onTap: () {
//                                           setState(() {
//                                             tempSelectedIdsSubject.clear(); // Clear the list
//                                             tempSelectedNamesSubject.clear(); // Clear the list
//                                             MySharedPrefrence().set_class_id(newItemsClass[index]['id']);
//                                             MySharedPrefrence().set_class_name_institute(newItemsClass[index]['class_name']);
//                                             print('class id ${MySharedPrefrence().get_class_id()}');
//                                             Navigator.pop(context);
//                                             fetchClassDataAndSubjectData(
//                                               'class_id=${MySharedPrefrence().get_class_id()}&Subject',
//                                               'Subject',
//                                               newItemsSubject,
//                                             );
//                                           });
//                                         },
//                                       );
//                                     },
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                       reusablaSizaBox(context, .030),
//                       reusablequlification(
//                         context,
//                         'Select Subject',
//                         () async {
//                           await selectSubject(setState);
//                           setState(() {});
//                         },
//                       ),
//                       reusablaSizaBox(context, .030),
//                       ListView.builder(
//   shrinkWrap: true,
//   itemCount: tempSelectedNamesSubject.length,
//   itemBuilder: (BuildContext context, int index) {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .006,
//           horizontal: MediaQuery.of(context).size.width * .01),
//           decoration: BoxDecoration(
//             color: colorController.qualificationItemsColors,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Expanded(
//                   child: Text(
//                     tempSelectedNamesSubject[index],
//                     softWrap: true,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: colorController.whiteColor,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     print('Removing item at index $index');
//                     tempSelectedIdsSubject.removeAt(index);
//                     tempSelectedNamesSubject.removeAt(index);
//                     print('tempSelectedNamesSubject after removal: $tempSelectedNamesSubject');
//                   });
//                 },
//                 child: Icon(Icons.cancel, color: colorController.whiteColor, size: 20.0),
//               ),
//             ],
//           ),
//         ),
//         reusablaSizaBox(context, .015)
//       ],
//     );
//   },
// ),
//                       reusablaSizaBox(context, .030),
//                       Row(
//                         children: [
//                           reusableBtn(
//                             context,
//                             'Add',
//                             () {
//                               setState(() {
//                                 selectedClasses.add(
//                                   MyClass(
//                                     classId: MySharedPrefrence().get_class_id(),
//                                     className: MySharedPrefrence().get_class_name_institute(),
//                                     subjectIds: List.from(tempSelectedIdsSubject),
//                                     subjectNames: List.from(tempSelectedNamesSubject),
//                                   ),
//                                 );
//                                 print(selectedClasses);
//                                 tempSelectedIdsSubject.clear();
//                                 tempSelectedNamesSubject.clear();
//                                 // print('hello $selectedIdsClass');
//                               });
//                               Navigator.pop(context);
//                             },
//                             width: .34,
//                           ),
//                           Expanded(
//                             child: reusablewhite(
//                               context,
//                               'Cancel',
//                               () {
//                                 Navigator.pop(context);
//                               },
//                               width: .5,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//           );
//         }
//       );
//     },
//   );
// }

// void search(List<dynamic> newItems, List<Map<String, String>> selectedIds, String name) {
//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, StateSetter setState) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           backgroundColor: colorController.whiteColor,
//           surfaceTintColor: colorController.whiteColor,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * .9,
//                   child: ListView.builder(
//                     itemCount: newItems.length,
//                     itemBuilder: (context, index) {
//                       String instituteName = newItems[index][name];
//                       String instituteId = newItems[index]['id'].toString();
//                       bool isSelected = selectedIds.any((element) => element['id'] == instituteId);
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01, vertical: MediaQuery.of(context).size.width * .00000001),
//                             child: ListTile(
//                               title: Text(instituteName),
//                               trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                               onTap: () {
//                                  setState((){});
//                                   toggleSelection(instituteId, instituteName,name); // Toggle selection on tap
//                                   // setState(() {
//                                   //   updateSelectedNames();
//                                   // });
//                                   print('Updated Selected IDs: ${selectedIds}');
//                               },
//                             ),
//                           ),
//                           if (index != newItems.length - 1)
//                             Divider(
//                               color: Colors.grey,
//                               thickness: 1.0,
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     reusableBtn(context, 'Add', () {
//                       setState(() {
//                       });
//                       Navigator.pop(context);
//                     }, width: .4),
//                     reusablaSizaBox(context, .03),
//                     Expanded(child: reusablewhite(context, 'Cancel', () {
//                       Navigator.pop(context);
//                     }, width: .5)),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }



// void search(List<dynamic> newItems, List<Map<String, String>> selectedIds, String name) {
//   TextEditingController searchController = TextEditingController();
//   List<dynamic> filteredItems = List.from(newItems); // Initial list to display
//   print(newItems);

//   showDialog(
//     context: context,
//     builder: (context) => StatefulBuilder(
//       builder: (context, StateSetter setState) {
//         void filterSearchResults(String query) {
//           if (query.isNotEmpty) {
//             List<dynamic> tempList = [];
//             newItems.forEach((item) {
//               if (item[name].toString().toLowerCase().contains(query.toLowerCase())) {
//                 tempList.add(item);
//               }
//             });
//             setState(() {
//               filteredItems.clear();
//               filteredItems.addAll(tempList);
//             });
//           } else {
//             setState(() {
//               filteredItems.clear();
//               filteredItems.addAll(newItems);
//             });
//           }
//         }

//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           backgroundColor: colorController.whiteColor,
//           surfaceTintColor: colorController.whiteColor,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextField(
//                   controller: searchController,
//                   decoration: InputDecoration(
//                     contentPadding: EdgeInsets.all(0),
//                     hintText: 'Search',
//                     hintStyle: TextStyle(fontSize: 11.5),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                   onChanged: (value) {
//                     filterSearchResults(value);
//                   },
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   width: MediaQuery.of(context).size.width * .9,
//                   child: ListView.builder(
//                     itemCount: filteredItems.length,
//                     itemBuilder: (context, index) {
//                       String instituteName = filteredItems[index][name];
//                       String instituteId = filteredItems[index]['id'].toString();
//                       bool isSelected = selectedIds.any((element) => element['id'] == instituteId);
//                       return Column(
//                         children: [
//                           // Padding(
//                           //   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .0001, vertical: MediaQuery.of(context).size.height * .00000001),
//                           //   child: 
//                             ListTile(
//                               dense: true,
//                               contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//                               visualDensity: VisualDensity(horizontal: 0, vertical: -4),
//                               title: reusableText(instituteName,fontsize: 12,color: colorController.lightblackColor),
//                               trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                               onTap: () {
//                                 setState(() {});
//                                 toggleSelection(instituteId, instituteName, name);
//                                 print('Updated Selected IDs: ${selectedIds}');
//                               },
//                             ),
//                           // ),
//                           if (index != filteredItems.length - 1)
//                             Divider(
//                               color: Colors.grey,
//                               thickness: 1.0,
//                             ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: reusableBtn(context, 'Add', () {
//                         setState(() {});
//                         Navigator.pop(context);
//                       }),
//                     ),
//                     reusablaSizaBox(context, .03),
//                     Expanded(
//                       child: reusablewhite(context, 'Cancel', () {
//                         Navigator.pop(context);
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }


// void search(List<dynamic> newItems, List<Map<String, String>> selectedIds, String name) {
//     TextEditingController searchController = TextEditingController();
//     List<dynamic> filteredItems = List.from(newItems);

//     showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, StateSetter setState) {
//           void filterSearchResults(String query) {
//             if (query.isNotEmpty) {
//               List<dynamic> tempList = [];
//               newItems.forEach((item) {
//                 if (item[name].toString().toLowerCase().contains(query.toLowerCase())) {
//                   tempList.add(item);
//                 }
//               });
//               setState(() {
//                 filteredItems.clear();
//                 filteredItems.addAll(tempList);
//               });
//             } else {
//               setState(() {
//                 filteredItems.clear();
//                 filteredItems.addAll(newItems);
//               });
//             }
//           }

//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             backgroundColor: Colors.white,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: TextField(
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(0),
//                       hintText: 'Search',
//                       hintStyle: TextStyle(fontSize: 11.5),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       prefixIcon: Icon(Icons.search),
//                     ),
//                     onChanged: (value) {
//                       filterSearchResults(value);
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * .9,
//                     height: 300, // fixed height for the dialog list
//                     child: (name == 'course_name' && filteredItems.isNotEmpty && filteredItems[0].containsKey('category'))
//                         ? // Grouped course list
//                         ListView(
//                             children: filteredItems
//                                 .groupBy((item) => item['category'])
//                                 .entries
//                                 .map((entry) {
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//                                     child: Text(
//                                       entry.key,
//                                       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                                     ),
//                                   ),
//                                   ...entry.value.map((course) {
//                                     String courseName = course['course_name'];
//                                     String courseId = course['id'];
//                                     bool isSelected = selectedIds.any((e) => e['id'] == courseId);
//                                     return ListTile(
//                                       dense: true,
//                                       contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//                                       title: Text(courseName),
//                                       trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                                       onTap: () {
//                                         setState(() {});
//                                         toggleSelection(courseId, courseName, name);
//                                       },
//                                     );
//                                   }).toList()
//                                 ],
//                               );
//                             }).toList(),
//                           )
//                         : // Normal flat list (for groups)
//                         ListView.builder(
//                             itemCount: filteredItems.length,
//                             itemBuilder: (context, index) {
//                               String itemName = filteredItems[index][name];
//                               String itemId = filteredItems[index]['id'].toString();
//                               bool isSelected = selectedIds.any((element) => element['id'] == itemId);
//                               return Column(
//                                 children: [
//                                   ListTile(
//                                     dense: true,
//                                     contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
//                                     title: Text(itemName),
//                                     trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                                     onTap: () {
//                                       setState(() {});
//                                       toggleSelection(itemId, itemName, name);
//                                     },
//                                   ),
//                                   if (index != filteredItems.length - 1)
//                                     Divider(
//                                       color: Colors.grey,
//                                       thickness: 1.0,
//                                     ),
//                                 ],
//                               );
//                             },
//                           ),
//                   ),
//                 ),
//                 Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: reusableBtn(context, 'Add', () {
//                         setState(() {});
//                         Navigator.pop(context);
//                       }),
//                     ),
//                     reusablaSizaBox(context, .03),
//                     Expanded(
//                       child: reusablewhite(context, 'Cancel', () {
//                         Navigator.pop(context);
//                       }),
//                     ),
//                   ],
//                 ),
//               ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

  bool isQuranClassSelected() {
    return selectedClasses.any((myClass) => myClass.className == 'Quran Subjects');
  }

  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
      child: InkWell(
        onTap: (){Navigator.pop(context);},
        child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
    ),),
  body: SafeArea(
    child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){},
                    child: Text("Qualification and \nPreferences",
      style: TextStyle(
        color: colorController.blackColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'tutorPhi'
        
      ),)),
      
                  reusablaSizaBox(context, 0.020),
                  ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
                  reusablaSizaBox(context, 0.020),
                  reusablequlification(context, 'Institute', () {
                    repository.search(context, newItemsinstitute, selectedIdsinstitute, 'names',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesinstitute.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesinstitute[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsinstitute.removeAt(index);
                                    selectedNamesinstitute.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                    print('idddddddddddddd $selectedIdsinstitute');
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Qualification', () {
                    repository.search(context, newItemsQualification, selectedIdsQualification, 'degree_title',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesQualification.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesQualification[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsQualification.removeAt(index);
                                    selectedNamesQualification.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .030),
                  reusableText("Tutor's Preferences", color: colorController.blackColor, fontsize: 21),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Area', () {
                    repository.search(context, newItemsArea, selectedIdsArea, 'area_name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  reusableSelectedItem(context, selectedNamesArea, (index){
                    setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsArea.removeAt(index);
                                    selectedNamesArea.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                  },),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesArea.length),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesArea.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns
                  //       crossAxisSpacing: 10.0, // Spacing between columns
                  //       mainAxisSpacing: 10.0, // Spacing between rows
                  //       childAspectRatio: 5.1, // Aspect ratio of each grid item
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesArea[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsArea.removeAt(index);
                  //                   selectedNamesArea.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Board', () {
                    repository.search(context, newItemsBoard, selectedIdsBoard, 'board_name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  reusableSelectedItem(context, selectedNamesBoard, (index){
                    setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsBoard.removeAt(index);
                                    selectedNamesBoard.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                  },),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesBoard.length),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesBoard.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns
                  //       crossAxisSpacing: 10.0, // Spacing between columns
                  //       mainAxisSpacing: 10.0, // Spacing between rows
                  //       childAspectRatio: 5.1, // Aspect ratio of each grid item
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesBoard[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsBoard.removeAt(index);
                  //                   selectedNamesBoard.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Group', () {
                    repository.search(context, newItemsGroup, selectedIdsGroup, 'group_name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  reusableSelectedItem(context, selectedNamesGroup, (index){
                    setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsGroup.removeAt(index);
                                    selectedNamesGroup.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                  },),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesGroup.length),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesGroup.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns
                  //       crossAxisSpacing: 10.0, // Spacing between columns
                  //       mainAxisSpacing: 10.0, // Spacing between rows
                  //       childAspectRatio: 5.1, // Aspect ratio of each grid item
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesGroup[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsGroup.removeAt(index);
                  //                   selectedNamesGroup.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),

                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Course', () {
                    repository.search(context, newItemsCourse, selectedIdsCourse, 'course_name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  reusableSelectedItem(context, selectedNamesCourse, (index){
                    setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsCourse.removeAt(index);
                                    selectedNamesCourse.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                  },),
                  // Container(
                  //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesCourse.length),
                  //   child: GridView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: selectedNamesCourse.length,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //       crossAxisCount: 2, // Number of columns
                  //       crossAxisSpacing: 10.0, // Spacing between columns
                  //       mainAxisSpacing: 10.0, // Spacing between rows
                  //       childAspectRatio: 5.1, // Aspect ratio of each grid item
                  //     ),
                  //     itemBuilder: (context, index) {
                  //       return Container(
                  //         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(15),
                  //           color: colorController.qualificationItemsColors,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Expanded(
                  //               child: Text(
                  //                 selectedNamesCourse[index],
                  //                 softWrap: true,
                  //                 overflow: TextOverflow.ellipsis,
                  //                 maxLines: 1,
                  //                 style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                  //               ),
                  //             ),
                  //             InkWell(
                  //               onTap: () {
                  //                 setState(() {
                  //                   // Remove the selected item from the list
                  //                   selectedIdsCourse.removeAt(index);
                  //                   selectedNamesCourse.removeAt(index);
                  //                   // updateSelectedNames(); // Update the names here
                  //                 });
                  //               },
                  //               child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     },
                  //   ),
                  // ),
                  reusablaSizaBox(context, .020),
                  Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorController.yellowColor,
                      ),
                      child: InkWell(
                        onTap: ()async{
                          await classSelect(setState);
                          setState(() {});
                          },
                        child: reusableText(selectedClasses.isEmpty ? 'Add Classes' : 'Add More Classes',color: colorController.btnColor,fontweight: FontWeight.bold)),
                  ),
                  reusablaSizaBox(context, .020),
                  Container(
  constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedClasses.length),
  child: GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    itemCount: selectedClasses.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1, // Number of columns
      crossAxisSpacing: 10.0, // Spacing between columns
      mainAxisSpacing: 10.0, // Spacing between rows
      childAspectRatio: 10.2, // Aspect ratio of each grid item
    ),
    itemBuilder: (context, index) {
      String subjects = selectedClasses[index].subjectNames.join(', ');
      return Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: colorController.qualificationItemsColors,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                '${selectedClasses[index].className}: ($subjects)',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 13, color: colorController.whiteColor),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                                  selectedClasses.removeAt(index);
                                });
              },
              child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
            ),
          ],
        ),
      );
    },
  ),
),
if (isQuranClassSelected())
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Preferred Time', () {
                    repository.search(context, newItemsTime, selectedIdsTime, 'name',toggleSelection);
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesTime.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
                          padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: colorController.qualificationItemsColors,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  selectedNamesTime[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 13, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedNamesTime.removeAt(index);
                                    selectedNamesTime.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                    print('idddddddddddddd $selectedNamesTime');
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor,size: MediaQuery.of(context).size.width*.050,),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .02),
                  // reusableText('Quran Online Teaching Experience',color: colorController.blackColor,fontsize: 17.0),
                  // reusablaSizaBox(context, .01),
                  // Flexible(child: 
                  reusableExperienceDropdown(selectedQuranExperience!, newItemsExperience, (value){
                    setState(() {});
                    _rawQuranExperience = value;
                  },'Quran Online Teaching Experience '),
                  reusablaSizaBox(context, .02),
                  reusableExperienceDropdown(selectedQuranExperiencePhysical!, newItemsExperiencePhysical, (value){
                    setState(() {});
                    selectedQuranExperiencePhysical = value;
                    print(selectedQuranExperiencePhysical);
                  },'Quran Physical Teaching Experience '),
                                  // ),
            //       Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Expanded(child: buildRadioButton('None', 'none',quranOnlineTeaching,(String? newValue) {setState(() {quranOnlineTeaching = newValue;});},)),
            //     Expanded(child: buildRadioButton('1-2 years', '1-2',quranOnlineTeaching,(String? newValue) {setState(() {quranOnlineTeaching = newValue;});},)),
            //     Expanded(child: buildRadioButton('3-4 years', '3-4',quranOnlineTeaching,(String? newValue) {setState(() {quranOnlineTeaching = newValue;});},)),
            //     Expanded(child: buildRadioButton('5+ years', '5+',quranOnlineTeaching,(String? newValue) {setState(() {quranOnlineTeaching = newValue;});},)),
            //   ],
            // ),
                  reusablaSizaBox(context, .02),
                  reusableText('Have you ever taught international client?',color: colorController.blackColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('Yes', 'yes',client,(String? newValue){setState(() {client = newValue;});},)),
                      Expanded(child: buildRadioButton('No','no',client,(String? newValue){setState((){client = newValue;});})),
                    ],
                  ),
                  reusablaSizaBox(context, .02),
                  reusableText('Add Maslak',color: colorController.blackColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Wrap(
                    spacing: 8.0, // Space between radio buttons
                    runSpacing: 4.0, // Space between lines
                    children: [
                    buildRadioButton('Ahle-Sunnat','Ahle-Sunnat',maslak,(String? newValue){setState((){maslak = newValue;});}),
                    buildRadioButton('Diobandi','Diobandi',maslak,(String? newValue){setState((){maslak = newValue;});}),
                    buildRadioButton('Bharelvi','Bharelvi',maslak,(String? newValue){setState((){maslak = newValue;});}),
                    buildRadioButton('Ahle-Hadees','Ahle-Hadees',maslak,(String? newValue){setState((){maslak = newValue;});}),
                    buildRadioButton('Shia','Shia',maslak,(String? newValue){setState((){maslak = newValue;});}),
                    ],
                  ),
                  reusablaSizaBox(context, .02),
                  reusableText('Zoom Proficiency',color: colorController.blackColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('Beginner', 'Beginner',Zoom,(String? newValue){setState(() {Zoom = newValue;});},)),
                      Expanded(child: buildRadioButton('Intermediate','Intermediate',Zoom,(String? newValue){setState((){Zoom = newValue;});})),
                      Expanded(child: buildRadioButton('Advance','Advance',Zoom,(String? newValue){setState((){Zoom = newValue;});})),
                    ],
                  ),
                  reusablaSizaBox(context, .02),
                  reusableText('Do you have a laptop',color: colorController.blackColor,fontsize: 17.0),
                  reusablaSizaBox(context, .01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: buildRadioButton('Yes', 'yes',laptop,(String? newValue){setState(() {laptop = newValue;});},)),
                      Expanded(child: buildRadioButton('No','no',laptop,(String? newValue){setState((){laptop = newValue;});})),
                    ],
                  ),
                ],
              ),
                  reusablaSizaBox(context, .050),
                  reusableBtn(context, 'Update', (){
                    setState(() {
                      // updateStatus();
                      _validateForm();
                    });
                  }),
                  reusablaSizaBox(context, .020),
                ],
              ),
            ),
          ),
        ),
        reusableloadingrow(context, isLoading),
      ],
    ),
  ),
);
}
}







        