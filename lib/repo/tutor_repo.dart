import 'dart:convert';

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

  String _faqs_images = '';
  String get faqs_images => _faqs_images;

  String _term_condition_image = '';
  String get term_condition_image => _term_condition_image;

  int _success = 0;
  int get success => _success;

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
        // _faqs_images = jsonResponse['faqs_images'];
         MySharedPrefrence().set_term_condition_image(jsonResponse['term_condition_image']);
         MySharedPrefrence().set_faqs_images(jsonResponse['faqs_images']);
        
        print('FAQ Image ${MySharedPrefrence().get_feedback_msg()}');
        print('terms & conditions Image ${MySharedPrefrence().get_term_condition_image()}');
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
}
