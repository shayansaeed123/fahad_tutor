// import 'dart:convert';

// import 'package:fahad_tutor/controller/color_controller.dart';
// import 'package:fahad_tutor/database/my_shared.dart';
// import 'package:fahad_tutor/repo/utils.dart';
// import 'package:fahad_tutor/res/reusableText.dart';
// import 'package:fahad_tutor/res/reusablebtn.dart';
// import 'package:fahad_tutor/res/reusablesizebox.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class example extends StatefulWidget {
//   const example({super.key});

//   @override
//   State<example> createState() => _exampleState();
// }

// class _exampleState extends State<example> {
//   bool isLoading = false;
//   List<dynamic> newItemsClass = [];
// List<dynamic> selectedIdsClass = [];
// List<String> selectedNamesClass = [];

//   Future<void> saveQualificationData() async {
//   setState(() {
//     isLoading = true;
//   });

//   try {
//     final response = await http.get(
//       Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'),
//     );
//     if (response.statusCode == 200) {
//       if (response.body.isNotEmpty) {
//         final Map<String, dynamic> jsonResponse = json.decode(response.body);

//         selectedIdsClass = jsonResponse['class_listing'];
//         //  as List)
//         //     .map<Map<String, String>>((item) => {'class_id': item['class_id'].toString()})
//         //     .toList();
//         print('hellooo $selectedIdsClass');


//         MySharedPrefrence().set_update_status(jsonResponse['update_status']);
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

// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     saveQualificationData();
//   }

// //   void classSelect() {
// //   showDialog(
// //     context: context,
// //     builder: (context) {
// //       return StatefulBuilder(
// //   builder: (context, setState) {
// //     return Dialog(
// //       shape: RoundedRectangleBorder(
// //         borderRadius: BorderRadius.circular(10.0),
// //       ),
// //       backgroundColor: Colors.white,
// //       child: Padding(
// //         padding: EdgeInsets.all(MediaQuery.of(context).size.width * .08),
// //         child: Column(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             reusableText('Add New Class',color: Colors.black,fontsize: 22,fontweight: FontWeight.bold),
// //                     reusablaSizaBox(context, .030),
// //                     reusableText('Add new class with Subject'),
// //                     reusablaSizaBox(context, .010),
// //             reusablequlification(context, MySharedPrefrence().get_class_name_institute() == ''? 'Select Class' : MySharedPrefrence().get_class_name_institute(), (){
// //                       // subjectSearch(newItemsClass, selectedIdsClass, 'class_name');
// //                       showDialog(
// //                         context: context,
// //                         builder: (context) {
// //                           return AlertDialog(
// //                             title: Text('Select Class'),
// //                             content: Container(
// //                               width: double.minPositive,
// //                               child: ListView.builder(
// //                                 shrinkWrap: true,
// //                                 itemCount: newItemsClass.length,
// //                                 itemBuilder: (BuildContext context, int index) {
// //                                   return ListTile(
// //                                     title: Text(newItemsClass[index]['class_name']),
// //                                     onTap: () {
// //                                       setState(() {
// //                                         classIds.clear();
// //                                         classIds.add({'id': newItemsClass[index]['class_id']});
// //                                         MySharedPrefrence().set_class_id(newItemsClass[index]['class_id']);
// //                                         MySharedPrefrence().set_class_name_institute(newItemsClass[index]['class_name']);
// //                                         Navigator.pop(context);
// //                                         fetchData('class_id=${MySharedPrefrence().get_class_id()}&Subject', 'Subject', newItemsSubject, selectedIdsSubject, updateSelectedNamesSubject);
// //                                       });
// //                                     },
// //                                   );
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //               });
// //                     }),
// //                     reusablaSizaBox(context, .030),
// //                     reusablequlification(context, 'Select Subject', (){
// //                       showDialog(
// //                         context: context,
// //                         builder: (context) {
// //                           return AlertDialog(
// //                             title: Text('Select Subject'),
// //                             content: Container(
// //                               width: double.minPositive,
// //                               child: ListView.builder(
// //                                 shrinkWrap: true,
// //                                 itemCount: newItemsSubject.length,
// //                                 itemBuilder: (BuildContext context, int index) {
// //                                   return ListTile(
// //                                     title: Text(newItemsSubject[index]['subject_name']),
// //                                     onTap: () {
// //                                       setState(() {
// //                                         if (!subjectIds.any((element) => element['id'] == newItemsSubject[index]['id'])) {
// //                                           subjectIds.add({'id': newItemsSubject[index]['subject_id']});
// //                                           selectedIdsSubject.add({'id': newItemsSubject[index]['subject_id']});
// //                                         }
// //                                         Navigator.pop(context); // Close the dialog
// //                                       });
// //                                     },
// //                                   );
// //                                 },
// //                               ),
// //                             ),
// //                           );
// //                 },
// //                   );
// //                     }),
// //             reusablaSizaBox(context, .030),
// //             Wrap(
// //               spacing: 8.0,
// //               runSpacing: 4.0,
// //               children: selectedNamesSubject.asMap().entries.map((entry) {
// //     final index = entry.key;
// //     final name = entry.value;
// //                 return Row(
// //                   children: [
// //                     Chip(
// //                       backgroundColor: colorController.qualificationItemsColors,
// //                   label: Text(name,style: TextStyle(color: colorController.whiteColor),),
// //                   avatar: InkWell(
// //                                 onTap: () {
// //                                   setState(() {
// //                                     selectedIdsSubject.removeAt(index);
// //                                     selectedNamesSubject.removeAt(index);
// //                                   });
// //                                 },
// //                                 child: Icon(Icons.cancel_outlined, color: colorController.whiteColor),
// //                               ),
// //                 ),
// //                   ],
// //                 );
// //               }).toList(),
// //             ),
// //             reusablaSizaBox(context, .030),
// //             Row(
// //                       children: [
// //                         reusableBtn(context, 'Add', (){},width: .34),
// //                         Expanded(child: reusablewhite(context, 'Cancel', (){
// //                         }, width: .5))
// //                       ],
// //                     )
// //           ],
// //         ),
// //       ),
// //     );
// //   },
// // );
// //     },
// //   );
// // }
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: selectedIdsClass.length,
//       itemBuilder: (context, index) {
//         print(selectedIdsClass[index]['class_name']);
//         return Text('');
//       },
//     );
//   }
// }
import 'dart:typed_data';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;

  List<dynamic> newItemsinstitute = [];
List<Map<String, String>> selectedIdsinstitute = [];
List<String> selectedNamesinstitute = [];

List<dynamic> newItemsQualification = [];
List<dynamic> selectedIdsQualification = [];
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveQualificationData();
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

  void toggleSelection(String id, String name, String itemType) {
  setState(() {
    List<dynamic> selectedIds;
    List<String> selectedNames;
    List<dynamic> newItems;

    switch (itemType) {
      case 'names':
        selectedIds = selectedIdsinstitute;
        selectedNames = selectedNamesinstitute;
        newItems = newItemsinstitute;
        // updateSelectedNames = updateSelectedNamesInstitute;
        break;
      case 'degree_title':
        selectedIds = selectedIdsQualification;
        selectedNames = selectedNamesQualification;
        newItems = newItemsQualification;
        // updateSelectedNames = updateSelectedNamesQualification;
        break;
      case 'board_name':
        selectedIds = selectedIdsBoard;
        selectedNames = selectedNamesBoard;
        newItems = newItemsBoard;
        break;
      case 'group_name':
        selectedIds = selectedIdsGroup;
        selectedNames = selectedNamesGroup;
        newItems = newItemsGroup;
        break;
      case 'area_name':
        selectedIds = selectedIdsArea;
        selectedNames = selectedNamesArea;
        newItems = newItemsArea;
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
  });
}
Future<void> saveQualificationData() async {
  setState(() {
    isLoading = true;
  });

  try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );
    print(MySharedPrefrence().get_user_ID());
    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);

        
        selectedIdsQualification = jsonResponse['Institute_Qualification'];
        print('hrrrtgsdfgsfdhn $selectedIdsQualification');


        MySharedPrefrence().set_city_id(jsonResponse['city_id']);
        MySharedPrefrence().set_update_status(jsonResponse['update_status']);
        print(MySharedPrefrence().get_update_status());


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

  search(List<dynamic> newItems,List<dynamic> selectedIds,String name) {
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
      appBar: AppBar(
        title: Text('Class and Subject Selector'),
      ),
      body: Column(children: [
        InkWell(
          onTap: (){
            search(newItemsQualification, selectedIdsQualification, 'degree_title');
          },
          child: Text('hello')),
          reusablaSizaBox(context, .020),
          Text('sdfgdkg'),
                  Container(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.3),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: selectedIdsQualification.length,
                      itemBuilder: (context, index) {
                        print(selectedIdsQualification);
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
                                  selectedIdsQualification[index],
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: colorController.blackColor),
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
      ],)
    );
  }
}
