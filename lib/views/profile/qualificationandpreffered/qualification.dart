import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
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
List<String> selectedValues = [];
bool select = false;

  search() {
  return showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context,StateSetter setState) {
        return Dialog(
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),),
          backgroundColor: colorController.whiteColor,
          surfaceTintColor: colorController.whiteColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Expanded(
                 child: 
                 Container(
                    width: MediaQuery.of(context).size.width * .9,
                    child: ListView.builder(
                      itemCount: newItems.length,
                      itemBuilder: (context, index) {
                        String instituteName = newItems[index]['names'];
                        String instituteId = newItems[index]['id'];
                        bool isSelected = selectedIds.any((element) => element['id'] == instituteId);
                        print('instituteNames  $instituteName');
                        print('instituteIds $instituteId');
                        print('Selected IDs: $selectedIds');
                        return Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .01,vertical:MediaQuery.of(context).size.width * .00000001  ),
                              child: ListTile(
                                title: Text(instituteName),
                                trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                                onTap: () {
                                  setState(() {
                                    if (isSelected) {
                                      selectedIds.removeWhere((element) => element['id'] == instituteId);
                                    } else {
                                      if (selectedIds.length < 2) {
                                        selectedIds.add({'id': instituteId});
                                      }else{
                                        Utils.snakbar(context, 'Select Last 2 Institute');
                                      }
                                    }
                                  });
                                  print('Updated Selected IDs: $selectedIds');
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
                    reusableBtn(context, 'Add', (){selectCountry();Navigator.pop(context);},width: .4),
                    reusablaSizaBox(context, .03),
                    Expanded(child: reusablewhite(context, 'Cancel', (){Navigator.pop(context);},width: .5)),
                  ],
                 ),
               )
            ],
          ),
        );
      }
    ),
  );
}

List<dynamic> newItems = [];
List<Map<String, String>> selectedIds = [];
Future<void> fetchTuitions() async {
  setState(() {
    isLoading = true;
  });
  try {
    String url = '${Utils.baseUrl}mobile_app/all_in.php?Institute=1';
    final response = await http.get(Uri.parse(url));
    print('url $url');

    if (response.statusCode == 200) {
      // Get the raw bytes of the response
      Uint8List responseBytes = response.bodyBytes;

      // Print the size of the response
      print('Response length: ${responseBytes.length}');

      // Print the beginning and end of the response
      print('Response start: ${responseBytes.sublist(0, 100)}');
      print('Response end: ${responseBytes.sublist(responseBytes.length - 100)}');

      // Decode the response and handle invalid UTF-8 bytes
      String responseBody = utf8.decode(responseBytes, allowMalformed: true);

      // Remove BOM if present
      responseBody = removeBom(responseBody);

      // Print the raw response body for debugging
      print('Response body: $responseBody');

      // Check if the response contains valid JSON
      if (isJsonValid(responseBody)) {
        dynamic jsonResponse = jsonDecode(responseBody);
        newItems = jsonResponse['Institute_listing'];

        print('Updated tuitions list: $newItems');
        print('Full JSON response: $jsonResponse');
        
      } else {
        print('Error: Invalid JSON format');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception(e);
  } finally {
    setState(() {
    isLoading = false;
  });
  }
}

String removeBom(String responseBody) {
  // Remove BOM if present
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

Future<void> selectCountry() async {
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
          selectedIds = jsonResponse['Institute_listing']
            .map<Map<String, String>>((item) => {'id': item['id'].toString()})
            .toList();
          print('object $selectedIds');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTuitions();
    selectCountry();
  }
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: 
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          reusableText("Qualification and \nPreferences",color: colorController.blackColor,fontsize: 25,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          reusablequlification(context, 'Institute', (){search();}),
                          Expanded(
                            flex: 1,
                            child: ListView.builder(
                              itemCount: selectedIds.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: colorController.redColor,
                                    ),
                                    child: reusableText(selectedIds[index].toString(),fontsize: 17,fontweight: FontWeight.bold,color: colorController.whiteColor),
                                );
                              },
                              ),
                          )
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }

  
}
