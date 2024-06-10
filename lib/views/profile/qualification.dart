import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
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

//    List<dynamic> newItemsinstitute = [];
//   List<Map<String, String>> selectedIdsinstitute = [];
//   List<String> selectedNamesinstitute = [];

//   List<dynamic> newItemsQualification = [];
//   List<Map<String, String>> selectedIdsQualification = [];
//   List<String> selectedNamesQualification = [];

//   List<dynamic> newItemsBoard = [];
//   List<Map<String, String>> selectedIdsBoard = [];
//   List<String> selectedNamesBoard = [];

//   List<dynamic> newItemsPreferred = [];
//   List<Map<String, String>> selectedIdsPreferred = [];
//   List<String> selectedNamesPreferred = [];

//   List<dynamic> newItemsGroup = [];
//   List<Map<String, String>> selectedIdsGroup = [];
//   List<String> selectedNamesGroup= [];
//   // bool isLoading = false;

// @override
//   void initState() {
//     super.initState();
//     fetchInstituteData();
//     fetchQualificationData();
//     fetchBoardData();
//     saveQualificationData();
//     fetchGroupData();
//   }

// Future<void> fetchInstituteData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String url = '${Utils.baseUrl}mobile_app/all_in.php?Institute=1';
//       final response = await http.get(Uri.parse(url));
//       print('url $url');

//       if (response.statusCode == 200) {
//         // Get the raw bytes of the response
//         Uint8List responseBytes = response.bodyBytes;

//         // Decode the response and handle invalid UTF-8 bytes
//         String responseBody = utf8.decode(responseBytes, allowMalformed: true);

//         // Remove BOM if present
//         responseBody = removeBom(responseBody);

//         // Check if the response contains valid JSON
//         if (isJsonValid(responseBody)) {
//           dynamic jsonResponse = jsonDecode(responseBody);
//           newItemsinstitute = jsonResponse['Institute_listing'];

//           // Initialize selectedNames based on selectedIds
//           updateSelectedNamesInstitute();

//           print('Updated Institute list: $newItemsinstitute');
//           // print('Full JSON response: $jsonResponse');
//         } else {
//           print('Error: Invalid JSON format');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   Future<void> fetchQualificationData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String url = '${Utils.baseUrl}mobile_app/all_in.php?Qualification=1';
//       final response = await http.get(Uri.parse(url));
//       print('url $url');

//       if (response.statusCode == 200) {
//         // Get the raw bytes of the response
//         Uint8List responseBytes = response.bodyBytes;

//         // Decode the response and handle invalid UTF-8 bytes
//         String responseBody = utf8.decode(responseBytes, allowMalformed: true);

//         // Remove BOM if present
//         responseBody = removeBom(responseBody);

//         // Check if the response contains valid JSON
//         if (isJsonValid(responseBody)) {
//           dynamic jsonResponse = jsonDecode(responseBody);
//           newItemsQualification = jsonResponse['Qualification_listing'];

//           // Initialize selectedNames based on selectedIds
//           updateSelectedNamesQualification();

//           print('Updated Qualification list: $newItemsQualification');
//           // print('Full JSON response: $jsonResponse');
//         } else {
//           print('Error: Invalid JSON format');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   // Future<void> fetchQualificationData() async {
//   //   setState(() {
//   //     isLoading = true;
//   //   });
//   //   try {
//   //     String url = '${Utils.baseUrl}mobile_app/all_in.php?Qualification=1';
//   //     final response = await http.get(Uri.parse(url));
//   //     print('url $url');

//   //     if (response.statusCode == 200) {
//   //       // Get the raw bytes of the response
//   //       Uint8List responseBytes = response.bodyBytes;

//   //       // Decode the response and handle invalid UTF-8 bytes
//   //       String responseBody = utf8.decode(responseBytes, allowMalformed: true);

//   //       // Remove BOM if present
//   //       responseBody = removeBom(responseBody);

//   //       // Check if the response contains valid JSON
//   //       if (isJsonValid(responseBody)) {
//   //         dynamic jsonResponse = jsonDecode(responseBody);
//   //         newItemsQualification = jsonResponse['Qualification_listing'];

//   //         // Initialize selectedNames based on selectedIds
//   //         updateSelectedNamesQualification();

//   //         print('Updated tuitions list: $newItemsQualification');
//   //         print('Full JSON response: $jsonResponse');
//   //       } else {
//   //         print('Error: Invalid JSON format');
//   //       }
//   //     } else {
//   //       print('Error: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Error: $e');
//   //     throw Exception(e);
//   //   } finally {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
//   Future<void> fetchBoardData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String url = '${Utils.baseUrl}mobile_app/all_in.php?Board=1';
//       final response = await http.get(Uri.parse(url));
//       print('url $url');

//       if (response.statusCode == 200) {
//         // Get the raw bytes of the response
//         Uint8List responseBytes = response.bodyBytes;

//         // Decode the response and handle invalid UTF-8 bytes
//         String responseBody = utf8.decode(responseBytes, allowMalformed: true);

//         // Remove BOM if present
//         responseBody = removeBom(responseBody);

//         // Check if the response contains valid JSON
//         if (isJsonValid(responseBody)) {
//           dynamic jsonResponse = jsonDecode(responseBody);
//           newItemsBoard = jsonResponse['Board_listing'];

//           // Initialize selectedNames based on selectedIds
//           updateSelectedNamesBoard();

//           print('Updated Board list: $newItemsBoard');
//           // print('Full JSON response: $jsonResponse');
//         } else {
//           print('Error: Invalid JSON format');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> fetchGroupData() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String url = '${Utils.baseUrl}mobile_app/all_in.php?Group=1';
//       final response = await http.get(Uri.parse(url));
//       print('url $url');

//       if (response.statusCode == 200) {
//         // Get the raw bytes of the response
//         Uint8List responseBytes = response.bodyBytes;

//         // Decode the response and handle invalid UTF-8 bytes
//         String responseBody = utf8.decode(responseBytes, allowMalformed: true);

//         // Remove BOM if present
//         responseBody = removeBom(responseBody);

//         // Check if the response contains valid JSON
//         if (isJsonValid(responseBody)) {
//           dynamic jsonResponse = jsonDecode(responseBody);
//           newItemsBoard = jsonResponse['Group_listing'];

//           // Initialize selectedNames based on selectedIds
//           updateSelectedNamesGroup();

//           print('Updated tuitions list: $newItemsGroup');
//           print('Full JSON response: $jsonResponse');
//         } else {
//           print('Error: Invalid JSON format');
//         }
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String removeBom(String responseBody) {
//     // Remove BOM if present
//     if (responseBody.startsWith('\uFEFF')) {
//       return responseBody.substring(1);
//     }
//     return responseBody;
//   }

//   bool isJsonValid(String jsonString) {
//     try {
//       jsonDecode(jsonString);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> saveQualificationData() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http.get(
//         Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'),
//       );
//       if (response.statusCode == 200) {
//         if (response.body.isNotEmpty) {
//           final Map<String, dynamic> jsonResponse = json.decode(response.body);
//           selectedIdsinstitute = (jsonResponse['Institute_listing'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList();

//               // final Map<String, dynamic> jsonResponse = json.decode(response.body);
//           selectedIdsQualification = (jsonResponse['Institute_Qualification'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList();

//               // final Map<String, dynamic> jsonResponse3 = json.decode(response.body);
//           selectedIdsBoard = (jsonResponse['preferred_board_listing'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList();

//               selectedIdsBoard = (jsonResponse['preferred_group_listing'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList();

//           // Initialize selectedNames based on selectedIds
//            updateSelectedNamesInstitute();
//           updateSelectedNamesQualification();
//           updateSelectedNamesBoard();
//           updateSelectedNamesGroup();

//           print('Selected IDs: $selectedIdsinstitute');
//           print('Selected IDs: $selectedIdsQualification');
//           print('Selected IDs: $selectedIdsBoard');
//           print('Selected IDs: $selectedIdsGroup');
//         } else {
//           throw Exception('Empty response body');
//         }
//       } else {
//         throw Exception('Failed to load country details');
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }


//   void updateSelectedNamesInstitute() {
//     selectedNamesinstitute = selectedIdsinstitute.map((selected) {
//       return (newItemsinstitute.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'names': 'Unknown'},
//       )['names'] as String);
//     }).toList();
//   }

//   void updateSelectedNamesQualification() {
//     selectedNamesQualification = selectedIdsQualification.map((selected) {
//       return (newItemsQualification.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'degree_title': 'Unknown'},
//       )['degree_title'] as String);
//     }).toList();
//   }

//   void updateSelectedNamesBoard() {
//     selectedNamesBoard = selectedIdsBoard.map((selected) {
//       return (newItemsBoard.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'board_name': 'Unknown'},
//       )['board_name'] as String);
//     }).toList();
//     print('shayan    $selectedNamesBoard');
//   }

//   void updateSelectedNamesGroup() {
//     selectedNamesGroup = selectedIdsGroup.map((selected) {
//       return (newItemsGroup.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'group_name': 'Unknown'},
//       )['group_name'] as String);
//     }).toList();
//     print(' hrllll $selectedNamesGroup');
//   }

// void toggleSelection(String instituteId, String instituteName,String name) {
//   setState(() {
//     if(name == 'names'){
//       if (selectedIdsinstitute.any((element) => element['id'] == instituteId)) {
//       selectedIdsinstitute.removeWhere((element) => element['id'] == instituteId);
//       selectedNamesinstitute.remove(instituteName);
//     } else {
//       if (selectedIdsinstitute.length < 2) {
//         selectedIdsinstitute.add({'id': instituteId});
//         selectedNamesinstitute.add(instituteName);
//       } else {
//         Utils.snakbar(context, 'Select Last 2 Institute');
//       }
//     }
//     }
//     else if(name == 'degree_title'){
//       if (selectedIdsQualification.any((element) => element['id'] == instituteId)) {
//       selectedIdsQualification.removeWhere((element) => element['id'] == instituteId);
//       selectedNamesQualification.remove(instituteName);
//     } else {
//       if (selectedIdsQualification.length < 2) {
//         selectedIdsQualification.add({'id': instituteId});
//         selectedNamesQualification.add(instituteName);
//       } else {
//         Utils.snakbar(context, 'Select Last 2 Institute');
//       }
//     }
//     }else if(name == 'board_name'){
//       if (selectedIdsBoard.any((element) => element['id'] == instituteId)) {
//       selectedIdsBoard.removeWhere((element) => element['id'] == instituteId);
//       selectedNamesBoard.remove(instituteName);
//     } else {
//       if (selectedIdsBoard.length < 2) {
//         selectedIdsBoard.add({'id': instituteId});
//         selectedNamesBoard.add(instituteName);
//       } else {
//         Utils.snakbar(context, 'Select Last 2 Institute');
//       }
//     }
//     }else if(name == 'group_name'){
//       if (selectedIdsGroup.any((element) => element['id'] == instituteId)) {
//       selectedIdsGroup.removeWhere((element) => element['id'] == instituteId);
//       selectedNamesGroup.remove(instituteName);
//     } else {
//       if (selectedIdsGroup.length < 2) {
//         selectedIdsGroup.add({'id': instituteId});
//         selectedNamesGroup.add(instituteName);
//       } else {
//         Utils.snakbar(context, 'Select Last 2 Institute');
//       }
//     }
//     }
    
//   });
//   // updateSelectedNames(); // Update the names after selection/deselection

// updateSelectedNamesInstitute();
// updateSelectedNamesQualification();
// updateSelectedNamesBoard();
// updateSelectedNamesGroup();
// }


// search(List<dynamic> newItems,List<Map<String, dynamic>> selectedIds,String name) {
//     return showDialog(
//       context: context,
//       builder: (context) => StatefulBuilder(
//         builder: (context, StateSetter setState) {
//           return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             backgroundColor: colorController.whiteColor,
//             surfaceTintColor: colorController.whiteColor,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * .9,
//                     child: ListView.builder(
//                       itemCount: newItems.length,
//                       itemBuilder: (context, index) {
//                         String instituteName = newItems[index]['${name}'];
//                         String instituteId = newItems[index]['id'];
//                         bool isSelected = selectedIds.any((element) => element['id'] == instituteId);
//                         return Column(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01, vertical: MediaQuery.of(context).size.width * .00000001),
//                               child: ListTile(
//                                 title: Text(instituteName),
//                                 trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                                 onTap: () {
//                                   setState((){});
//                                   toggleSelection(instituteId, instituteName,name); // Toggle selection on tap
//                                   // setState(() {
//                                   //   updateSelectedNames();
//                                   // });
//                                   print('Updated Selected IDs: ${selectedIds}');
//                                 },
//                               ),
//                             ),
//                             if (index != newItems.length - 1) // Add Divider for all but the last item
//                               Divider(
//                                 color: Colors.grey, // Customize the color if needed
//                                 thickness: 1.0, // Customize the thickness if needed
//                               ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       reusableBtn(context, 'Add', () {
//                         // selectCountry();
//                         setState((){});
//                         // updateSelectedNames();
//                         // setState((){});
//                         Navigator.pop(context);
//                       }, width: .4),
//                       reusablaSizaBox(context, .03),
//                       Expanded(child: reusablewhite(context, 'Cancel', () {
//                         Navigator.pop(context);
//                       }, width: .5)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }  


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

List<dynamic> AreaList = [];
// String city_id = ''; 

@override
  void initState() {
    super.initState();
    fetchData('Institute', newItemsinstitute, selectedIdsinstitute, updateSelectedNamesInstitute);
    fetchData('Qualification', newItemsQualification, selectedIdsQualification, updateSelectedNamesQualification);
    fetchData('Board', newItemsBoard, selectedIdsBoard, updateSelectedNamesBoard);
    fetchData('Group', newItemsGroup, selectedIdsGroup, updateSelectedNamesGroup);
    saveQualificationData();
    selectArea();
  }

  Future<void> fetchData(String type, List<dynamic> newItems, List<Map<String, String>> selectedIds, Function updateSelectedNames) async {
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
            newItems.addAll(jsonResponse['${type}_listing']);
            updateSelectedNames();
          });
          print('Updated $type list: $newItems');
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

Future<void> saveQualificationData() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'),
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

        MySharedPrefrence().set_city_id(jsonResponse['city_id']);
        MySharedPrefrence().set_update_status(jsonResponse['update_status']);

        print('Cityyyyyy ${MySharedPrefrence().get_city_id()}');

        updateSelectedNamesInstitute();
        updateSelectedNamesQualification();
        updateSelectedNamesBoard();
        updateSelectedNamesGroup();
        updateSelectedNamesArea();

        // print('Selected IDs: $selectedIdsinstitute');
        // print('Selected IDs: $selectedIdsQualification');
        // print('Selected IDs: $selectedIdsBoard');
        // print('Selected IDs: $selectedIdsGroup');
        print('Selected Area IDs: $selectedIdsArea');
      } else {
        throw Exception('Empty response body');
      }
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
          print('Areassss $newItemsArea');
          // if (areaList.isNotEmpty) {
            // setState(() {
            //   areaName = areaList[0]['area_name'];
            //   // countryId = countryList[0]['c_id'];
            //   print(areaName);
            //   print(areaList);
            // });
          // } else {
          //   throw Exception('Area list is empty');
          // }
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

// Future<void> signUpApi() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       print('check tutor Id ${MySharedPrefrence().get_user_ID()}');
//       final response = await http.post(
//           Uri.parse('${Utils.baseUrl}mobile_app/sign_up.php'),
//           body: {
//             'contact_number':reusabletextfieldcontroller.contactCon.text.toString(),
//             'cnic': reusabletextfieldcontroller.cnicCon.text.toString(),
//             'alternate_number':reusabletextfieldcontroller.alterContactCon.text.toString(),
//             'teacher_name': reusabletextfieldcontroller.teacherCon.text.toString(),
//             'father_name':reusabletextfieldcontroller.fatherCon.text.toString(),
//             'married_status': _selectedStatus.toString(),
//             'tutreligion':reusabletextfieldcontroller.religionCon.text.toString(),
//             'email': MySharedPrefrence().get_user_email().toString(),
//             'gender': _selectedGender.toString(),
//             'password': reusabletextfieldcontroller.registerPassCon.text.toString(),
//             'city_id': cityId.toString(),
//             'area_id': areaId.toString(),
//             'home_address':reusabletextfieldcontroller.addressCon.text.toString(),
//             'date_of_birth': selectedTime.toString(),
//             'DigitalPad':_selectedValue1.toString(),
//             'onlineTeaching_experience': _selectedValue2.toString(),
//             'online_Skill':'',
//             'Biography': _biography.text.toString(),
//             'tutor_placement': jsonEncode(selectedPlacements),
//           });
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         String apiMessage = responseData['message'];
//         // String number = responseData['number'];
//         if (responseData['success'] == 1) {
//           print('response:' + response.body);
//           Navigator.pop(context);
//           Navigator.push(
//               context, MaterialPageRoute(builder: ((context) => NavBar())));
//           Utils.snakbarSuccess(context, apiMessage);
//         } else {
//           InkWell(
//             onTap: (){
//               Utils.launchWhatsApp(context);
//             },
//             child: Utils.snakbarFailed(context, apiMessage),
//           );
//           Navigator.push(
//               context, MaterialPageRoute(builder: ((context) => Rigister())));
//           //   },
//           // );
//         }
//       } else {
//         print('Error2: ' + response.statusCode.toString());
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

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
      default:
        return;
    }

    if (selectedIds.any((element) => element['id'] == id)) {
      selectedIds.removeWhere((element) => element['id'] == id);
      selectedNames.remove(name);
    } else {
      if (selectedIds.length < 2) {
        selectedIds.add({'id': id});
        selectedNames.add(name);
      } else {
        Utils.snakbar(context, 'Select only 2 items');
      }
    }

    updateSelectedNames();
  });
}

classSelect(){
  return showDialog(context: context, builder: (context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: colorController.whiteColor,
            surfaceTintColor: colorController.whiteColor,
            child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
                child: Container(
                         height: MediaQuery.of(context).size.height * .35,
                  child: Column(children: [
                    reusableText('Add New Class',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
                    reusablaSizaBox(context, .030),
                    reusableText('Add new class with Subject'),
                    reusablaSizaBox(context, .010),
                    reusablequlification(context, 'Select Class', (){
                    }),
                    reusablaSizaBox(context, .020),
                    reusablequlification(context, 'Select Subject', (){}),
                    reusablaSizaBox(context, .020),
                    Row(
                      children: [
                        reusableBtn(context, 'Add', (){},width: .34),
                        Expanded(child: reusablewhite(context, 'Cancel', (){}, width: .5))
                      ],
                    )
                  ],),
                ),
              ),
      );
    },);
  },);
}

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
                        // selectCountry();
                        setState((){});
                        // updateSelectedNames();
                        // setState((){});
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
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
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
                  reusableText("Qualification and \nPreferences", color: colorController.blackColor, fontsize: 25, fontweight: FontWeight.bold),
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
                  reusablaSizaBox(context, .050),
                  reusableBtn(context, 'Update', (){}),
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




  // List<dynamic> newItemsInstitute = [];
  // List<Map<String, String>> selectedIdsInstitute = [];
  // List<String> selectedNamesInstitute = [];

  // List<dynamic> newItemsQualification = [];
  // List<Map<String, String>> selectedIdsQualification = [];
  // List<String> selectedNamesQualification = [];

  // // bool isLoading = false;

  // @override
  // void initState() {
  //   super.initState();
  //   fetchTuitions('Institute', 'Institute_listing', newItemsInstitute, selectedNamesInstitute, selectedIdsInstitute);
  //   fetchTuitions('Qualification', 'Qualification_listing', newItemsQualification, selectedNamesQualification, selectedIdsQualification);
  //   selectCountry(selectedIdsInstitute, 'Institute_listing', selectedNamesInstitute, newItemsInstitute);
  //   selectCountry(selectedIdsQualification, 'Institute_Qualification', selectedNamesQualification, newItemsQualification);
  // }

//   Future<void> fetchTuitions(String urlPoint, String responsevalue, List<dynamic> newItems, List<String> selectedNames, List<Map<String, String>> selectedIds) async {
//   setState(() {
//     isLoading = true;
//   });
//   try {
//     String url = '${Utils.baseUrl}mobile_app/all_in.php?$urlPoint=1';
//     final response = await http.get(Uri.parse(url));
//     print('url $url');

//     if (response.statusCode == 200) {
//       Uint8List responseBytes = response.bodyBytes;
//       String responseBody = utf8.decode(responseBytes, allowMalformed: true);
//       responseBody = removeBom(responseBody);

//       if (responseBody != null && responseBody.isNotEmpty && isJsonValid(responseBody)) {
//         dynamic jsonResponse = jsonDecode(responseBody);
//         newItems.clear(); // Clear the list before adding new items
//         newItems.addAll(jsonResponse[responsevalue]);
//         updateSelectedIntituteNames(selectedNamesInstitute, selectedIdsInstitute, newItemsInstitute);
//         updateSelectedQualificationNames(selectedNamesQualification, selectedIdsQualification, newItemsQualification);
//         print('Updated tuitions list: $newItems');
//         print('Full JSON response: $jsonResponse');
//       } else {
//         print('Error: Invalid JSON format or empty response');
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error: $e');
//     throw Exception(e);
//   } finally {
//     setState(() {
//       isLoading = false;
//     });
//   }
// }


//   String removeBom(String responseBody) {
//     if (responseBody.startsWith('\uFEFF')) {
//       return responseBody.substring(1);
//     }
//     return responseBody;
//   }

//   bool isJsonValid(String jsonString) {
//     try {
//       jsonDecode(jsonString);
//       return true;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<void> selectCountry(List<Map<String, String>> ids, String responsevalue, List<String> names, List<dynamic> items) async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       final response = await http.get(Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'));
//       if (response.statusCode == 200) {
//         if (response.body.isNotEmpty) {
//           final Map<String, dynamic> jsonResponse = json.decode(response.body);
//           ids.clear(); // Clear the list before adding new items
//           ids.addAll((jsonResponse['$responsevalue'] as List)
//               .map<Map<String, String>>((item) => {'id': item['id'].toString()})
//               .toList());
//           updateSelectedIntituteNames(names, ids, items);
//           updateSelectedQualificationNames(names, ids, items);
//           print('Selected IDs: $ids');
//         } else {
//           throw Exception('Empty response body');
//         }
//       } else {
//         throw Exception('Failed to load country details');
//       }
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }



// void updateSelectedIntituteNames(List<String> selectedNames, List<Map<String, String>> selectedIds, List<dynamic> newItems) {
//   selectedNames.clear();
//   selectedNames.addAll(
//     selectedIds.map((selected) {
//       final item = newItems.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'names': 'Unknown'},
//       );
//       return item['names'] as String? ?? 'Unknown';
//     }).toList(),
//   );
// }

// void updateSelectedQualificationNames(List<String> selectedNames, List<Map<String, String>> selectedIds, List<dynamic> newItems) {
//   selectedNames.clear();
//   selectedNames.addAll(
//     selectedIds.map((selected) {
//       final item = newItems.firstWhere(
//         (item) => item['id'] == selected['id'],
//         orElse: () => {'degree_title': 'Unknown'},
//       );
//       return item['degree_title'] as String? ?? 'Unknown';
//     }).toList(),
//   );
// }


// search(List<dynamic> list, List<Map<String, String>> ids, List<String> selectedNames, String name) {
//   return showDialog(
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
//                     itemCount: list.length,
//                     itemBuilder: (context, index) {
//                       String itemName = list[index][name] ?? 'Unknown';
//                       String itemId = list[index]['id'] ?? '';
//                       bool isSelected = ids.any((element) => element['id'] == itemId);
//                       return Column(
//                         children: [
//                           Padding(
//                             padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01, vertical: MediaQuery.of(context).size.width * .00000001),
//                             child: ListTile(
//                               title: Text(itemName),
//                               trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
//                               onTap: () {
//                                 setState(() {
//                                   if (isSelected) {
//                                     ids.removeWhere((element) => element['id'] == itemId);
//                                   } else {
//                                     if (ids.length < 2) {
//                                       ids.add({'id': itemId});
//                                     } else {
//                                       Utils.snakbar(context, 'Select Last 2 items');
//                                     }
//                                   }
//                                   updateSelectedIntituteNames(selectedNames, ids, list);
//                                   updateSelectedQualificationNames(selectedNames, ids, list);
//                                 });
//                                 print('Updated Selected IDs: ${ids}');
//                               },
//                             ),
//                           ),
//                           if (index != list.length - 1)
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
//                       setState(() {});
//                       Navigator.pop(context);
//                     }, width: .4),
//                     reusablaSizaBox(context, .03),
//                     Expanded(child: reusablewhite(context, 'Cancel', () {
//                       Navigator.pop(context);
//                     }, width: .5)),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         );
//       },
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return reusableprofileidget(
//       Padding(
//         padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
//         child: ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               reusableText("Qualification and \nPreferences", color: colorController.blackColor, fontsize: 25, fontweight: FontWeight.bold),
//               reusablaSizaBox(context, 0.020),
//               reusablequlification(context, 'Institute', () {
//                 search(newItemsInstitute, selectedIdsInstitute, selectedNamesInstitute,'names');
//               }),
//               reusablaSizaBox(context, .020),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: selectedIdsInstitute.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
//                     padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: colorController.redColor,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         selectedNamesInstitute.isNotEmpty && index < selectedNamesInstitute.length
//                             ? reusableText(selectedNamesInstitute[index], fontsize: 17, fontweight: FontWeight.bold, color: colorController.whiteColor)
//                             : Container(),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               selectedIdsInstitute.removeAt(index);
//                               selectedNamesInstitute.removeAt(index);
//                             });
//                           },
//                           child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//               reusablaSizaBox(context, .020),
//               reusablequlification(context, 'Qualification', () {
//                 search(newItemsQualification, selectedIdsQualification, selectedNamesQualification,'degree_title');
//               }),
//               reusablaSizaBox(context, .020),
//               ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: selectedIdsQualification.length,
//                 itemBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .012),
//                     padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05, vertical: MediaQuery.of(context).size.height * .01),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(15),
//                       color: colorController.redColor,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         selectedNamesQualification.isNotEmpty && index < selectedNamesQualification.length
//                             ? reusableText(selectedNamesQualification[index], fontsize: 17, fontweight: FontWeight.bold, color: colorController.whiteColor)
//                             : Container(),
//                         InkWell(
//                           onTap: () {
//                             setState(() {
//                               selectedIdsQualification.removeAt(index);
//                               selectedNamesQualification.removeAt(index);
//                             });
//                           },
//                           child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       reusableloadingrow(context, isLoading),
//     );
//   }
}




        