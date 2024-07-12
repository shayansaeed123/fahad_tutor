import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/classmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/views/profile/example.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class QualificationAndPreferences extends StatefulWidget {
  const QualificationAndPreferences({super.key});

  @override
  State<QualificationAndPreferences> createState() => _QualificationAndPreferencesState();
}

class _QualificationAndPreferencesState extends State<QualificationAndPreferences> {
  bool isLoading = false;
  bool visible = true;
  TutorRepository repository = TutorRepository();

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

List<dynamic> newItemsArea = [];
List<Map<String, String>> selectedIdsArea = [];
List<String> selectedNamesArea = [];


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

@override
  void initState() {
    super.initState();
    fetchData('Institute','Institute', newItemsinstitute, selectedIdsinstitute, updateSelectedNamesInstitute);
    fetchData('Qualification','Qualification', newItemsQualification, selectedIdsQualification, updateSelectedNamesQualification);
    fetchData('Board', 'Board', newItemsBoard, selectedIdsBoard, updateSelectedNamesBoard);
    fetchData('Group','Group', newItemsGroup, selectedIdsGroup, updateSelectedNamesGroup);
    fetchClassDataAndSubjectData('Class','Class', newItemsClass,);
    saveQualificationData();
    selectArea();
    repository.check_msg();
    // updateStatus();
  }

  Future<void> updateStatus() async {
  setState(() {
    isLoading = true;
  });
  try {
    List<Map<String, dynamic>> classList = selectedClasses.map((classItem) {
      return classItem.toJson();
    }).toList();

    String classListJson = jsonEncode(classList);

    // Debug prints to check the data
    print('Class List: $classList');
    print('Class List JSON: $classListJson');
    print('check tutor Id ${MySharedPrefrence().get_user_ID()}');
    print('check update Status ${MySharedPrefrence().get_update_status()}');

    final response = await http.post(
      Uri.parse('${Utils.baseUrl}mobile_app/step_2_update.php'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'code': '10',
        'update_status': MySharedPrefrence().get_update_status(),
        'tutor_id_edit': MySharedPrefrence().get_user_ID(),
        'preferred_areas': jsonEncode(selectedIdsArea),
        'preferred_board': jsonEncode(selectedIdsBoard),
        'preferred_group': jsonEncode(selectedIdsGroup),
        'class_listing': classListJson,
        'Institute': jsonEncode(selectedIdsinstitute),
        'Degree': jsonEncode(selectedIdsQualification),
      },
    );

    print(response.body.toString());

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('updateeeeeeeeeeeeeeeeeeeeeeeee $responseData');

      if (responseData['success'] == 1) {
        // Refetch data to update UI with the latest data
        // await saveQualificationData();
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

Future<void> saveQualificationData() async {
  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
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
          selectedIdsArea = (jsonResponse['preferred_area_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          selectedIdsBoard = (jsonResponse['preferred_board_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          selectedIdsGroup = (jsonResponse['preferred_group_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();

              selectedIdsSubject = (jsonResponse['class_listing'] as List)
              .map<Map<String, String>>((item) => {'id': item['id'].toString()})
              .toList();
          // selectedIdsSubject = jsonResponse['class_listing'];

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

          MySharedPrefrence().set_city_id(jsonResponse['city_id']);
          MySharedPrefrence().set_update_status(jsonResponse['update_status']);

          // Update the selected names
          updateSelectedNamesInstitute();
          updateSelectedNamesQualification();
          updateSelectedNamesBoard();
          updateSelectedNamesGroup();
          updateSelectedNamesArea();
          updateSelectedNamesSubject();
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
      String url = '${Utils.baseUrl}mobile_app/all_in.php?$type=1';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        Uint8List responseBytes = response.bodyBytes;
        String responseBody = utf8.decode(responseBytes, allowMalformed: true);
        responseBody = removeBom(responseBody);

        if (isJsonValid(responseBody)) {
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

  Future<void> fetchData(String type,String responseName, List<dynamic> newItems, List<Map<String, String>> selectedIds, Function updateSelectedNames) async {
    setState(() {
      isLoading = true;
    });
    try {
      String url = '${Utils.baseUrl}mobile_app/all_in.php?$type=1';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        Uint8List responseBytes = response.bodyBytes;
        String responseBody = utf8.decode(responseBytes, allowMalformed: true);
        responseBody = removeBom(responseBody);

        if (isJsonValid(responseBody)) {
          dynamic jsonResponse = jsonDecode(responseBody);
          setState(() {
            newItems.clear();
            newItems.addAll(jsonResponse['${responseName}_listing']);
            updateSelectedNames();
          });
          // print('Updated $responseName list: $newItems');
        } else {
          print('Error: Invalid JSON format');
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error hello: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String removeBom(String responseBody) {
    if (responseBody.startsWith('\uFEFF')) {
      return responseBody.substring(1);
    }
    return responseBody;
  }

  bool isJsonValid(String jsonString) {
    try {
      jsonDecode(jsonString);
      return true;
    } catch (e) {
      return false;
    }
  }


// Future<void> saveQualificationData() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     final response = await http.get(
//       Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
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
//     print(e);
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
      final response = await http.post(
          Uri.parse('${Utils.baseUrl}mobile_app/area.php'),
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

void updateSelectedNamesArea() {
  selectedNamesArea = selectedIdsArea.map((selected) {
    return (newItemsArea.firstWhere(
      (item) => item['id'] == selected['id'],
      orElse: () => {'area_name': 'Unknown'},
    )['area_name'] as String);
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
      case 'area_name':
        selectedIds = selectedIdsArea;
        selectedNames = selectedNamesArea;
        newItems = newItemsArea;
        updateSelectedNames = updateSelectedNamesArea;
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
          Utils.snakbar(context, 'Select only 2 items');
        }
      } else {
        // For other types, just add or remove without length constraint
        selectedIds.add({'id': id});
        selectedNames.add(name);
      }
    }

    updateSelectedNames();
  });
}


Future<void> selectSubject(Function parentSetState){
  return showDialog(
                        context: context,
                        builder: (context) {
                          return 
                          StatefulBuilder(
                            builder: (context, setState) {
                              return 
                              AlertDialog(
                                title: Text('Select Subject'),
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * .9,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: newItemsSubject.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            bool isSelected = tempSelectedIdsSubject.contains(newItemsSubject[index]['id'].toString());
                                            return ListTile(
                                              title: Text(newItemsSubject[index]['subject_name']),
                                              trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                                              onTap: () {
                                                setState(() {
                                                  print('object');
                                                  if (isSelected) {
                                                    tempSelectedIdsSubject.remove(newItemsSubject[index]['id']);
                                                    tempSelectedNamesSubject.remove(newItemsSubject[index]['subject_name']);
                                                  } else {
                                                    tempSelectedIdsSubject.add(newItemsSubject[index]['id']);
                                                    tempSelectedNamesSubject.add(newItemsSubject[index]['subject_name']);
                                                  }
                                                });
                                                parentSetState((){});
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          reusableBtn(context, 'Add', () {
                                            setState(() {
                                              Navigator.pop(context);
                                            });

                                          }, width: .4),
                                          reusablaSizaBox(context, .03),
                                          Expanded(child: reusablewhite(context, 'Cancel', () {
                                            setState(() {});
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

Future<void> classSelect() {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context,StateSetter setState) {
          return Dialog(
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
                        fontsize: 22,
                        fontweight: FontWeight.bold,
                      ),
                      reusablaSizaBox(context, .030),
                      reusableText('Add new class with Subject'),
                      reusablaSizaBox(context, .010),
                      reusablequlification(
                        context,
                        MySharedPrefrence().get_class_name_institute() == ''
                            ? 'Select Class'
                            : MySharedPrefrence().get_class_name_institute(),
                        () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Select Class'),
                                content: Container(
                                  width: double.minPositive,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: newItemsClass.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(newItemsClass[index]['class_name']),
                                        onTap: () {
                                          setState(() {
                                            tempSelectedIdsSubject.clear(); // Clear the list
                                            tempSelectedNamesSubject.clear(); // Clear the list
                                            MySharedPrefrence().set_class_id(newItemsClass[index]['id']);
                                            MySharedPrefrence().set_class_name_institute(newItemsClass[index]['class_name']);
                                            print(MySharedPrefrence().get_class_id());
                                            Navigator.pop(context);
                                            fetchClassDataAndSubjectData(
                                              'class_id=${MySharedPrefrence().get_class_id()}&Subject',
                                              'Subject',
                                              newItemsSubject,
                                            );
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
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
  shrinkWrap: true,
  itemCount: tempSelectedNamesSubject.length,
  itemBuilder: (BuildContext context, int index) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .006,
          horizontal: MediaQuery.of(context).size.width * .01),
          decoration: BoxDecoration(
            color: colorController.redColor,
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
                    print('Removing item at index $index');
                    tempSelectedIdsSubject.removeAt(index);
                    tempSelectedNamesSubject.removeAt(index);
                    print('tempSelectedNamesSubject after removal: $tempSelectedNamesSubject');
                  });
                },
                child: Icon(Icons.cancel, color: colorController.whiteColor, size: 20.0),
              ),
            ],
          ),
        ),
        reusablaSizaBox(context, .015)
      ],
    );
  },
),
                      reusablaSizaBox(context, .030),
                      Row(
                        children: [
                          reusableBtn(
                            context,
                            'Add',
                            () {
                              setState(() {
                                selectedClasses.add(
                                  MyClass(
                                    classId: MySharedPrefrence().get_class_id(),
                                    className: MySharedPrefrence().get_class_name_institute(),
                                    subjectIds: List.from(tempSelectedIdsSubject),
                                    subjectNames: List.from(tempSelectedNamesSubject),
                                  ),
                                );
                                print(selectedClasses);
                                tempSelectedIdsSubject.clear();
                                tempSelectedNamesSubject.clear();
                                // print('hello $selectedIdsClass');
                              });
                              Navigator.pop(context);
                            },
                            width: .34,
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
          );
        }
      );
    },
  );
}


// void classSelect() {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return StatefulBuilder(
//   builder: (context, setState) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       backgroundColor: Colors.white,
//       child: Padding(
//         padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             reusableText('Add New Class',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
//                     reusablaSizaBox(context, .030),
//                     reusableText('Add new class with Subject'),
//                     reusablaSizaBox(context, .010),
//             reusablequlification(context, MySharedPrefrence().get_class_name_institute() == ''? 'Select Class' : MySharedPrefrence().get_class_name_institute(), (){
//                       // subjectSearch(newItemsClass, selectedIdsClass, 'class_name');
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text('Select Class'),
//                             content: Container(
//                               width: double.minPositive,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: newItemsClass.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return ListTile(
//                                     title: Text(newItemsClass[index]['class_name']),
//                                     onTap: () {
//                                       setState(() {
//               tempSelectedIdsClass.clear();  // Clear the list
//               tempSelectedIdsClass.add({'id': newItemsClass[index]['id']});  // Add the selected item
//               MySharedPrefrence().set_class_id(newItemsClass[index]['id']);
//               MySharedPrefrence().set_class_name_institute(newItemsClass[index]['class_name']);
//               print(MySharedPrefrence().get_class_id());
//               print(tempSelectedIdsClass);
//               Navigator.pop(context);
//               fetchClassDataAndSubjectData('class_id=${MySharedPrefrence().get_class_id()}&Subject', 'Subject', newItemsSubject);
//             });
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//               });
//                     }),
//                     reusablaSizaBox(context, .030),
//                     reusablequlification(context, 'Select Subject', (){
//                       showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             title: Text('Select Subject'),
//                             content: Container(
//                               width: double.minPositive,
//                               child: ListView.builder(
//                                 shrinkWrap: true,
//                                 itemCount: newItemsSubject.length,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   return ListTile(
//                                     title: Text(newItemsSubject[index]['subject_name']),
//                                     onTap: () {
//                                        setState(() {
//                                         tempSelectedIdsSubject.add({
//                                           'subject_id': newItemsSubject[index]['subject_id'].toString()
//                                         });
//                                         tempSelectedNamesSubject.add(newItemsSubject[index]['subject_name']);
//                                         addToTempSelectedIdsClass(); // Add this function to automatically add subjects to class list
//                                       });
//                                       Navigator.pop(context); // Close the dialog
//                                       print(tempSelectedNamesSubject);
//                                       print(tempSelectedIdsSubject);
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                 },
//                   );
//                     }),
//             reusablaSizaBox(context, .030),
//             Wrap(
//               spacing: 8.0,
//               runSpacing: 4.0,
//               children: tempSelectedNamesSubject.asMap().entries.map((entry) {
//     final index = entry.key;
//     final name = entry.value;
//                 return Row(
//                   children: [
//                     Chip(
//                       backgroundColor: colorController.qualificationItemsColors,
//                   label: Text(name,style: TextStyle(color: colorController.whiteColor),),
//                   avatar: InkWell(
//                                 onTap: () {
//                                 setState(() {
//                                   tempSelectedIdsSubject.removeAt(index);
//                                   tempSelectedNamesSubject.removeAt(index);
//                                   addToTempSelectedIdsClass(); // Update the class list when removing a subject
//                                 });
//                                 },
//                                 child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
//                               ),
//                 ),
//                   ],
//                 );
//               }).toList(),
//             ),
//             reusablaSizaBox(context, .030),
//             Row(
//                       children: [
//                         reusableBtn(context, 'Add', (){
//                         setState(() {
//                             selectedIdsSubject.addAll(tempSelectedIdsSubject);
//                             selectedNamesSubject.addAll(tempSelectedNamesSubject);
//                             tempSelectedIdsSubject.clear();
//                             tempSelectedNamesSubject.clear();
//                           });
//                         Navigator.pop(context);
//                         },width: .34),
//                         Expanded(child: reusablewhite(context, 'Cancel', (){
//                         }, width: .5))
//                       ],
//                     )
//           ],
//         ),
//       ),
//     );
//   },
// );
//     },
//   );
// }


search(List<dynamic> newItems,List<Map<String, dynamic>> selectedIds,String name) {
    return showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter setState) {
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
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.builder(
                      itemCount: newItems.length,
                      itemBuilder: (context, index) {
                        String instituteName = newItems[index]['${name}'];
                        String instituteId = newItems[index]['id'];
                        //  instituteName = newItems[index]['${name}'];
                        //  instituteId = newItems[index]['id'];
                        bool isSelected = selectedIds.any((element) => element['id'] == instituteId);
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01, vertical: MediaQuery.of(context).size.width * .00000001),
                              child: ListTile(
                                title: Text(instituteName),
                                trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                                onTap: () {
                                  setState((){});
                                  toggleSelection(instituteId, instituteName,name); // Toggle selection on tap
                                  // setState(() {
                                  //   updateSelectedNames();
                                  // });
                                  print('Updated Selected IDs: ${selectedIds}');
                                },
                              ),
                            ),
                            if (index != newItems.length - 1) // Add Divider for all but the last item
                              Divider(
                                color: Colors.grey, // Customize the color if needed
                                thickness: 1.0, // Customize the thickness if needed
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      reusableBtn(context, 'Add', () {
                        setState((){});
                        Navigator.pop(context);
                      }, width: .4),
                      reusablaSizaBox(context, .03),
                      Expanded(child: reusablewhite(context, 'Cancel', () {
                        Navigator.pop(context);
                      }, width: .5)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }  

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
                    child: reusableText("Qualification and \nPreferences", color: colorController.blackColor, fontsize: 25, fontweight: FontWeight.bold)),
                  reusablaSizaBox(context, 0.020),
                  ValueListenableBuilder(valueListenable: repository.popup, builder: (context, value, child) {
              if(value == 1){
                return reusableVisiblityMesage(context, MySharedPrefrence().get_popup_text(), (){setState(() {visible=false;});}, visible);
                }else{return Container();}
            },),
                  reusablaSizaBox(context, 0.020),
                  reusablequlification(context, 'Institute', () {
                    search(newItemsinstitute, selectedIdsinstitute, 'names');
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
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
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
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'Qualification', () {
                    search(newItemsQualification, selectedIdsQualification, 'degree_title');
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
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
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
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
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
                    search(newItemsArea, selectedIdsArea, 'area_name');
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesArea.length),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesArea.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        childAspectRatio: 4.5, // Aspect ratio of each grid item
                      ),
                      itemBuilder: (context, index) {
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
                                  selectedNamesArea[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsArea.removeAt(index);
                                    selectedNamesArea.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Board', () {
                    search(newItemsBoard, selectedIdsBoard, 'board_name');
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesBoard.length),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesBoard.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        childAspectRatio: 4.5, // Aspect ratio of each grid item
                      ),
                      itemBuilder: (context, index) {
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
                                  selectedNamesBoard[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsBoard.removeAt(index);
                                    selectedNamesBoard.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .020),
                  reusablequlification(context, 'preferred Group', () {
                    search(newItemsGroup, selectedIdsGroup, 'group_name');
                  }),
                  reusablaSizaBox(context, .020),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * selectedNamesGroup.length),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedNamesGroup.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                        childAspectRatio: 4.5, // Aspect ratio of each grid item
                      ),
                      itemBuilder: (context, index) {
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
                                  selectedNamesGroup[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    // Remove the selected item from the list
                                    selectedIdsGroup.removeAt(index);
                                    selectedNamesGroup.removeAt(index);
                                    // updateSelectedNames(); // Update the names here
                                  });
                                },
                                child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  reusablaSizaBox(context, .020),
                  Container(
                    padding: EdgeInsets.all(MediaQuery.of(context).size.width * .04),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: colorController.yellowColor,
                      ),
                      child: InkWell(
                        onTap: ()async{
                          await classSelect();
                          setState(() {});
                          },
                        child: reusableText('Add More Classes',color: colorController.btnColor,fontweight: FontWeight.bold)),
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
      childAspectRatio: 8.2, // Aspect ratio of each grid item
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
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.whiteColor),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                                  selectedClasses.removeAt(index);
                                });
              },
              child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
            ),
          ],
        ),
      );
    },
  ),
),
                  reusablaSizaBox(context, .050),
                  reusableBtn(context, 'Update', (){
                    setState(() {
                      updateStatus();
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




        