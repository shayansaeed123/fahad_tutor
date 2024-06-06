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
import 'package:http/http.dart' as http;

class QualificationAndPreferences extends StatefulWidget {
  const QualificationAndPreferences({super.key});

  @override
  State<QualificationAndPreferences> createState() => _QualificationAndPreferencesState();
}

class _QualificationAndPreferencesState extends State<QualificationAndPreferences> {
  bool isLoading = false;
   
//   List<ListItem> items = [
//   ListItem(value: 'Item 1'),
//   ListItem(value: 'Item 2'),
//   ListItem(value: 'Item 3'),
// ];
// List<String> selectedValues = [];


// bool _isDialogOpen = false;
  search() {
    // setState(() {
    //   _isDialogOpen = true;
    // });
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      // title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
      content: 
      Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height *.5,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: newItems.length,
              itemBuilder: (context, index) {
                instituteNames = newItems[index]['names'];
                instituteIds = newItems[index]['id'];
                print('instituteNames  $instituteNames');
                print('instituteIds $instituteIds');
              return CupertinoListTile(
        title: Text(instituteNames),
        // Text(items[index].value),
        // trailing: items[index].selected ? Icon(Icons.check,color: colorController.blackColor,) : null,
        onTap: () {
                  // setState(() {
                  //   // Toggle the selected flag
                  //   items[index].selected = !items[index].selected;
      
                  //   // Add or remove the value from the selectedValues list
                  //   if (items[index].selected) {
                  //     selectedValues.add(items[index].value);
                  //   } else {
                  //     selectedValues.remove(items[index].value);
                  //   }
                  // });
      
                  // // Print the selected values
                  // print('Selected values: $selectedValues');
                },
      );
            },),
          ),
      
        ],
      ),
      // actions: [
      //   ElevatedButton(
      //     onPressed: () {
      //       btnontap();
      //       Navigator.pop(context);
      //     },
      //     child: Text(btntxt),
      //   ),
      // ],
    ),
  );
}
dynamic instituteIds;
dynamic instituteNames;
List<dynamic> newItems = [];
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
        setState(() {
              instituteNames = newItems[0]['names'];
              // countryId = countryList[0]['c_id'];
              print(instituteNames);
            });
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTuitions();
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
                           reusableBtn(context, 'button', (){search();}),
                            
                    ],
                  ),
                ),
      reusableloadingrow(context, isLoading)
    );
  }
}

