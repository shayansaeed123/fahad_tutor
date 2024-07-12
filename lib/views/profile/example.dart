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

