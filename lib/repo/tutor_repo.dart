import 'dart:convert';
import 'dart:typed_data';

import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



// class TutorRepository{

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // bool _showLoadMoreButton = true;
  // bool get showLoadMoreButton => _showLoadMoreButton;
  // List<dynamic> _listResponse = [];
  // List<dynamic> get listResponse => _listResponse;
  // String _name = '';
  // String get name => _name;
  // Future<List<dynamic>> fetchViewTuitions(int start,int limit,) async {
  //   _isLoading = true;
  //   _showLoadMoreButton = false;
  //  try{
  //   _isLoading = false;
  //   String url =
  //         '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=31110&start=$start&end=${limit}';
  //    final response = await http.get(Uri.parse(url));
  //    print('url $url');

  //   if (response.statusCode == 200) {
  //     dynamic jsonResponse = jsonDecode(response.body);
  //     _listResponse = jsonResponse['tuition_listing'];
  //     print('without login view tuitions $_listResponse');
  //     if(name == 'relo'){
  //       _listResponse.addAll(_listResponse);
  //     }
  //     return listResponse;
  //   } else {
  //     print('Error: ${response.statusCode}'); 
  //     return [];
  //   }
  //  }catch(e){
  //   print('Error : $e');
  //   throw Exception(e);
  //  }finally{
  //     _isLoading = false;
  //  }
  // }
  
// }

class TutorRepository {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _showLoadMoreButton = true;
  bool get showLoadMoreButton => _showLoadMoreButton;
  List<dynamic> _listResponse = [];
  List<dynamic> get listResponse => _listResponse;

  List<dynamic> _allTuitionsList = [];
  List<dynamic> get allTuitionsList => _allTuitionsList;

  List<dynamic> _prefferedTuitionsList = [];
  List<dynamic> get prefferedTuitionsList => _prefferedTuitionsList;

  String _class_name = '';
  String get class_name => _class_name; 

  String _message = '';
  String get message => _message; 

  // final ValueNotifier<String> _faqs_images = ValueNotifier<String>('');
  // ValueNotifier<String> get faqs_images => _faqs_images;

  // final ValueNotifier<String> _term_condition_image = ValueNotifier<String>('');
  // ValueNotifier<String> get term_condition_image => _term_condition_image;

  String _Registration_text = '';
  String get Registration_text => _Registration_text;

  int _success = 0;
  int get success => _success;

  // int _basic_info = 0;
  // int get basic_info => _basic_info;
  final ValueNotifier<int> _basicInfo = ValueNotifier<int>(0);
  ValueNotifier<int> get basicInfo => _basicInfo;

  final ValueNotifier<String> _qualification_pref = ValueNotifier<String>('');
  ValueNotifier<String> get qualification_pref => _qualification_pref;

  final ValueNotifier<String> _additional_info = ValueNotifier<String>('');
  ValueNotifier<String> get additional_info => _additional_info;

  final ValueNotifier<String> _docs_att = ValueNotifier<String>('');
  ValueNotifier<String> get docs_att => _docs_att;

  final ValueNotifier<String> _payment_recipt = ValueNotifier<String>('');
  ValueNotifier<String> get payment_recipt => _payment_recipt;

  final ValueNotifier<String> _bank_details = ValueNotifier<String>('');
  ValueNotifier<String> get bank_details => _bank_details;

  final ValueNotifier<String> _is_term_accepted = ValueNotifier<String>('');
  ValueNotifier<String> get is_term_accepted => _is_term_accepted;

  Future<void> fetchTuitions(int start, int limit) async {
    _isLoading = true;
    _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=31110&start=$start&end=$limit';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['tuition_listing'];
        if (start == 0) {
          _listResponse = newItems;
        } else {
          _listResponse.addAll(newItems);
        }
        print('Updated tuitions list: $_listResponse');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
      _showLoadMoreButton = true;
    }
  }

  Future<void> allTuitions(int start, int limit) async {
    _isLoading = true;
    _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=$limit';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['tuition_listing'];
        
        if (start == 0) {
          _allTuitionsList = newItems;
        } else {
          _allTuitionsList.addAll(newItems);
        }
        print('Updated tuitions list: $_allTuitionsList');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
      _showLoadMoreButton = true;
    }
  }

  Future<void> prefferedTuitions(int start, int limit) async {
    _isLoading = true;
    _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/preferred_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=$limit';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['tuition_listing'];
        if (start == 0) {
          _prefferedTuitionsList = newItems;
        } else {
          _prefferedTuitionsList.addAll(newItems);
        }
        print('Updated tuitions list: $_prefferedTuitionsList');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
      _showLoadMoreButton = true;
    }
  }

  Future<void> group_id(String g_id) async {

    if (g_id == '') {
    print('Error: group_id is null');
    return;
  }
    _isLoading = true;
    // _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/group_class.php?code=10&group_id=$g_id';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['group_class_name'];
        _class_name = newItems[0]['class_name'];
        print('class_nameeeee $class_name');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
      _showLoadMoreButton = true;
    }
  }

  Future<void> feedback()async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/feedback.php';
      final response = await http.post(Uri.parse(url),body: {
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
        'remarks' : reusabletextfieldcontroller.feedback.toString(),
        'code':'10'.toString(),
      });

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        _message = jsonResponse['message'];
        // List<dynamic> newItems = jsonResponse['group_class_name'];
        
        print('message $_message');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> Check_popup()async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/check_popup.php?step_check=1&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
      MySharedPrefrence().set_faqs(jsonResponse['faqs_images']);
       MySharedPrefrence().set_term_condition(jsonResponse['term_condition_image']);
        _Registration_text = jsonResponse['Registration_text'];
        _basicInfo.value = jsonResponse['basic_info'];
        _qualification_pref.value = jsonResponse['qualification_pref'];
        _docs_att.value = jsonResponse['docs_att'];
        _additional_info.value = jsonResponse['additional_info'];
        _bank_details.value = jsonResponse['bank_details'];
        _is_term_accepted.value = jsonResponse['is_term_accepted'];
        _payment_recipt.value = jsonResponse['payment_recipt'];
         MySharedPrefrence().set_term_condition_image(jsonResponse['term_condition_image']);
         MySharedPrefrence().set_faqs_images(jsonResponse['faqs_images']);
        
        print('FAQ Image ${MySharedPrefrence().get_faqs()}');
        print('terms & conditions Image ${MySharedPrefrence().get_term_condition()}');
        print('registration $_Registration_text');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> deleteAccount()async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/deletemyaccount.php';
      final response = await http.post(Uri.parse(url),body: {
        'celltoken' : '1',
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
      });

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> resetPassword(context)async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}mobile_app/password_rest.php';
      final response = await http.post(Uri.parse(url),body: {
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
        'code':'10'.toString(),
        'old_pass' : reusabletextfieldcontroller.oldPass.text.toString(),
        'new_pass' : reusabletextfieldcontroller.newPass.text.toString(),
        'con_pass' : reusabletextfieldcontroller.conPass.text.toString()
      });

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        _message = jsonResponse['message'];
        // List<dynamic> newItems = jsonResponse['group_class_name'];
        if(jsonResponse['success'] == 1){
          Utils.snakbarSuccess(context, _message);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
        }else{
          Utils.snakbarFailed(context, _message);
        }
        
        print('message $_message');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      _isLoading = false;
    }
  }



  // Qualification Apis Functions

  // Institute start
  // List<dynamic> _instituteItems = [];
  // List<dynamic> get instituteItems => _instituteItems; 
  // List<Map<String, String>> _selectedIdsinstitute = [];
  // List<Map<String, String>> get selectedIdsinstitute => _selectedIdsinstitute; 
  // List<String> _selectedNamesinstitute = [];
  // List<String> get selectedNamesinstitute => _selectedNamesinstitute;
  // // Institute end

  // // Qualification start
  // List<dynamic> _qualificationItems = [];
  // List<dynamic> get qualificationItems => _qualificationItems; 
  // List<Map<String, String>> _selectedIdsqualification = [];
  // List<Map<String, String>> get selectedIdsqualification => _selectedIdsqualification; 
  // List<String> _selectedNamesqualification = [];
  // List<String> get selectedNamesqualification => _selectedNamesqualification;
  // // Qualification end


  // Future<void> fetchQualificationData(
  //   String urlPoint,String responseData,
  //   List<dynamic> items,
  //   List<Map<String, String>> itemsIds,
  //   List<String> itemsname) async {
  //   _isLoading = true;
  //   try {
  //     String url = '${Utils.baseUrl}mobile_app/all_in.php?${urlPoint}=1';
  //     final response = await http.get(Uri.parse(url));
  //     print('url $url');

  //     if (response.statusCode == 200) {
  //       // Get the raw bytes of the response
  //       Uint8List responseBytes = response.bodyBytes;

  //       // Decode the response and handle invalid UTF-8 bytes
  //       String responseBody = utf8.decode(responseBytes, allowMalformed: true);

  //       // Remove BOM if present
  //       responseBody = removeBom(responseBody);

  //       // Check if the response contains valid JSON
  //       if (isJsonValid(responseBody)) {
  //         dynamic jsonResponse = jsonDecode(responseBody);
  //         items = jsonResponse['${responseData}'];

  //         // Initialize selectedNames based on selectedIds
  //         updateSelectedNames(items,itemsIds,itemsname);

  //         print('Updated tuitions list: $_instituteItems');
  //         print('Full JSON response: $jsonResponse');
  //       } else {
  //         print('Error: Invalid JSON format');
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // String removeBom(String responseBody) {
  //   // Remove BOM if present
  //   if (responseBody.startsWith('\uFEFF')) {
  //     return responseBody.substring(1);
  //   }
  //   return responseBody;
  // }

  // bool isJsonValid(String jsonString) {
  //   try {
  //     jsonDecode(jsonString);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<void> saveQualificationData(String saveResponseData) async {
  //   _isLoading = true;

  //   try {
  //     final response = await http.get(
  //       Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'),
  //     );
  //     if (response.statusCode == 200) {
  //       if (response.body.isNotEmpty) {
  //         final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //         _selectedIdsinstitute = (jsonResponse['${saveResponseData}'] as List)
  //             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
  //             .toList();

  //         // Initialize selectedNames based on selectedIds
  //         // updateSelectedNames();

  //         print('Selected IDs: $_selectedIdsinstitute');
  //       } else {
  //         throw Exception('Empty response body');
  //       }
  //     } else {
  //       throw Exception('Failed to load country details');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // void updateSelectedNames(List<dynamic> items,List<Map<String, String>> itemsIds,List<String> itemsname) {
  //   itemsname = itemsIds.map((selected) {
  //     return (items.firstWhere(
  //       (item) => item['id'] == selected['id'],
  //       orElse: () => {'names': 'Unknown'},
  //     )['names'] as String);
  //   }).toList();
  // }


  // // Institute lists
  // List<dynamic> _instituteItems = [];
  // List<dynamic> get instituteItems => _instituteItems;
  // List<Map<String, String>> _selectedIdsInstitute = [];
  // List<Map<String, String>> get selectedIdsInstitute => _selectedIdsInstitute;
  // List<String> _selectedNamesInstitute = [];
  // List<String> get selectedNamesInstitute => _selectedNamesInstitute;

  // // Qualification lists
  // List<dynamic> _qualificationItems = [];
  // List<dynamic> get qualificationItems => _qualificationItems;
  // List<Map<String, String>> _selectedIdsQualification = [];
  // List<Map<String, String>> get selectedIdsQualification => _selectedIdsQualification;
  // List<String> _selectedNamesQualification = [];
  // List<String> get selectedNamesQualification => _selectedNamesQualification;


  // Future<void> fetchQualificationData(String urlPoint, String responseData, String target) async {
  //   _isLoading = true;
  //   try {
  //     String url = '${Utils.baseUrl}mobile_app/all_in.php?${urlPoint}=1';
  //     final response = await http.get(Uri.parse(url));
  //     print('url $url');

  //     if (response.statusCode == 200) {
  //       Uint8List responseBytes = response.bodyBytes;
  //       String responseBody = utf8.decode(responseBytes, allowMalformed: true);
  //       responseBody = removeBom(responseBody);

  //       if (isJsonValid(responseBody)) {
  //         dynamic jsonResponse = jsonDecode(responseBody);
  //         List<dynamic> items = jsonResponse['${responseData}'];

  //         if (target == 'institute') {
  //           _instituteItems = items;
  //           updateSelectedNames(target);
  //         } else if (target == 'qualification') {
  //           _qualificationItems = items;
  //           updateSelectedNames(target);
  //         }

  //         print('Updated items list: $items');
  //         print('Full JSON response: $jsonResponse');
  //       } else {
  //         print('Error: Invalid JSON format');
  //       }
  //     } else {
  //       print('Error: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //     throw Exception(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // Future<void> saveQualificationData(String saveResponseData, String target) async {
  //   _isLoading = true;
  //   try {
  //     final response = await http.get(Uri.parse('${Utils.baseUrl}mobile_app/step_2.php?code=10&tutor_id=31225'));
  //     if (response.statusCode == 200) {
  //       if (response.body.isNotEmpty) {
  //         final Map<String, dynamic> jsonResponse = json.decode(response.body);
  //         List<Map<String, String>> selectedIds = (jsonResponse['${saveResponseData}'] as List)
  //             .map<Map<String, String>>((item) => {'id': item['id'].toString()})
  //             .toList();

  //         if (target == 'institute') {
  //           _selectedIdsInstitute = selectedIds;
  //           updateSelectedNames(target);
  //         } else if (target == 'qualification') {
  //           _selectedIdsQualification = selectedIds;
  //           updateSelectedNames(target);
  //         }

  //         print('Selected IDs for $target: $selectedIds');
  //       } else {
  //         throw Exception('Empty response body');
  //       }
  //     } else {
  //       throw Exception('Failed to load details');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     _isLoading = false;
  //   }
  // }

  // void updateSelectedNames(String target) {
  //   if (target == 'institute') {
  //     _selectedNamesInstitute = _selectedIdsInstitute.map((selected) {
  //       return (_instituteItems.firstWhere(
  //         (item) => item['id'] == selected['id'],
  //         orElse: () => {'names': 'Unknown'},
  //       )['names'] as String);
  //     }).toList();
  //   } else if (target == 'qualification') {
  //     _selectedNamesQualification = _selectedIdsQualification.map((selected) {
  //       return (_qualificationItems.firstWhere(
  //         (item) => item['id'] == selected['id'],
  //         orElse: () => {'names': 'Unknown'},
  //       )['names'] as String);
  //     }).toList();
  //   }
  // }

  // String removeBom(String responseBody) {
  //   if (responseBody.startsWith('\uFEFF')) {
  //     return responseBody.substring(1);
  //   }
  //   return responseBody;
  // }

  // bool isJsonValid(String jsonString) {
  //   try {
  //     jsonDecode(jsonString);
  //     return true;
  //   } catch (e) {
  //     return false;
  //   }
  // }

}
