import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/banksmodel.dart';
import 'package:fahad_tutor/model/onlineportallistingmodel.dart';
import 'package:fahad_tutor/model/searchmodel.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';



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
  //         '${Utils.baseUrl}/tuitions.php?code=10&tutor_id=31110&start=$start&end=${limit}';
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
// Extension to group list items by a key
extension GroupBy<T> on Iterable<T> {
  Map<K, List<T>> groupby<K>(K Function(T) keyFn) {
    final Map<K, List<T>> map = {};
    for (var element in this) {
      final key = keyFn(element);
      map.putIfAbsent(key, () => []).add(element);
    }
    return map;
  }
}

class TutorRepository {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _showLoadMoreButton = true;
  bool get showLoadMoreButton => _showLoadMoreButton;
  List<dynamic> _listResponse = [];
  List<dynamic> get listResponse => _listResponse;

  List<dynamic> _allTuitionsList = [];
  List<dynamic> get allTuitionsList => _allTuitionsList;

  List<dynamic> _allNotificationList = [];
  List<dynamic> get allNotificationList => _allNotificationList;

  List<dynamic> _prefferedTuitionsList = [];
  List<dynamic> get prefferedTuitionsList => _prefferedTuitionsList;

  String _class_name = '';
  String get class_name => _class_name; 

  String _message = '';
  String get message => _message; 

  String? _cell_token = '';
  String? get cell_token => _cell_token; 

  // final ValueNotifier<String> _faqs_images = ValueNotifier<String>('');
  // ValueNotifier<String> get faqs_images => _faqs_images;

  // final ValueNotifier<String> _term_condition_image = ValueNotifier<String>('');
  // ValueNotifier<String> get term_condition_image => _term_condition_image;

  String _Registration_text = '';
  String get Registration_text => _Registration_text;

  String _registration_heading = '';
  String get registration_heading => _registration_heading;

  String _Registration_text_quran = '';
  String get Registration_text_quran => _Registration_text_quran;
  
  String _registration_heading_quran = '';
  String get registration_heading_quran => _registration_heading_quran;

  String _Registration_text_english = '';
  String get Registration_text_english => _Registration_text_english;

  String _registration_heading_english = '';
  String get registration_heading_english => _registration_heading_english;

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
  
  final ValueNotifier<String> _quran_payment_recipt = ValueNotifier<String>('');
  ValueNotifier<String> get quran_payment_recipt => _quran_payment_recipt;

  final ValueNotifier<String> _english_payment_recipt = ValueNotifier<String>('');
  ValueNotifier<String> get english_payment_recipt => _english_payment_recipt;

  final ValueNotifier<int> _payment_recipt_option = ValueNotifier<int>(0);
  ValueNotifier<int> get payment_recipt_option => _payment_recipt_option;

  final ValueNotifier<int> _payment_recipt_option_quran = ValueNotifier<int>(0);
  ValueNotifier<int> get payment_recipt_option_quran => _payment_recipt_option_quran;

  final ValueNotifier<int> _payment_recipt_option_english = ValueNotifier<int>(0);
  ValueNotifier<int> get payment_recipt_option_english => _payment_recipt_option_english;

  final ValueNotifier<String> _bank_details = ValueNotifier<String>('');
  ValueNotifier<String> get bank_details => _bank_details;

  final ValueNotifier<String> _is_term_accepted = ValueNotifier<String>('');
  ValueNotifier<String> get is_term_accepted => _is_term_accepted;

  final ValueNotifier<int> _is_term_home = ValueNotifier<int>(0);
  ValueNotifier<int> get is_term_home => _is_term_home;

  final ValueNotifier<String> _is_term_accepted_online = ValueNotifier<String>('');
  ValueNotifier<String> get is_term_accepted_online => _is_term_accepted_online;

  final ValueNotifier<int> _popup = ValueNotifier<int>(0);
  ValueNotifier<int> get popup => _popup;

  final ValueNotifier<int> _is_term_accepted_online_option = ValueNotifier<int>(0);
  ValueNotifier<int> get is_term_accepted_online_option => _is_term_accepted_online_option;

  final ValueNotifier<int> _traning_video = ValueNotifier<int>(0);
  ValueNotifier<int> get traning_video => _traning_video;

  final ValueNotifier<int> _attention_option = ValueNotifier<int>(0);
  ValueNotifier<int> get attention_option => _attention_option;

  final ValueNotifier<int> _delete_account = ValueNotifier<int>(0);
  ValueNotifier<int> get delete_account => _delete_account;

  final ValueNotifier<int> _preferred_popup = ValueNotifier<int>(0);
  ValueNotifier<int> get preferred_popup => _preferred_popup;

  final ValueNotifier<String> _preferred_popup_image = ValueNotifier<String>('');
  ValueNotifier<String> get preferred_popup_image => _preferred_popup_image;

  final ValueNotifier<String> _discount_popup = ValueNotifier<String>('');
  ValueNotifier<String> get discount_popup => _discount_popup;

  final ValueNotifier<String> _discount_popup_image = ValueNotifier<String>('');
  ValueNotifier<String> get discount_popup_image => _discount_popup_image;

  final ValueNotifier<String> _profile_image = ValueNotifier<String>('');
  ValueNotifier<String> get profile_image => _profile_image;

  final ValueNotifier<String> _cnic_b= ValueNotifier<String>('');
  ValueNotifier<String> get cnic_b => _cnic_b;

  final ValueNotifier<String> _charges_image = ValueNotifier<String>('');
  ValueNotifier<String> get charges_image => _charges_image;

  final ValueNotifier<String> _charges_image_quran = ValueNotifier<String>('');
  ValueNotifier<String> get charges_image_quran => _charges_image_quran;

  final ValueNotifier<String> _charges_image_english = ValueNotifier<String>('');
  ValueNotifier<String> get charges_image_english => _charges_image_english;

  final ValueNotifier<String> _cnic_f = ValueNotifier<String>('');
  ValueNotifier<String> get cnic_f => _cnic_f;

  final ValueNotifier<String> _last_document = ValueNotifier<String>('');
  ValueNotifier<String> get last_document => _last_document;

  final ValueNotifier<String> _other_1 = ValueNotifier<String>('');
  ValueNotifier<String> get other_1 => _other_1;

  final ValueNotifier<String> _other_2 = ValueNotifier<String>('');
  ValueNotifier<String> get other_2 => _other_2;

  final ValueNotifier<String> _other_3 = ValueNotifier<String>('');
  ValueNotifier<String> get other_3 => _other_3;

  final ValueNotifier<String> _other_4 = ValueNotifier<String>('');
  ValueNotifier<String> get other_4 => _other_4;

  final ValueNotifier<String> _other_5 = ValueNotifier<String>('');
  ValueNotifier<String> get other_5 => _other_5;

  final ValueNotifier<String> _other_6 = ValueNotifier<String>('');
  ValueNotifier<String> get other_6 => _other_6;

  final ValueNotifier<String> _doc_msg = ValueNotifier<String>('');
  ValueNotifier<String> get doc_msg => _doc_msg;

  final ValueNotifier<String> _is_term_accept = ValueNotifier<String>('');
  ValueNotifier<String> get is_term_accept => _is_term_accept;

  final ValueNotifier<int> _doc_error = ValueNotifier<int>(0);
  ValueNotifier<int> get doc_error => _doc_error;

  final ValueNotifier<int> _goto_play = ValueNotifier<int>(0);
  ValueNotifier<int> get goto_play => _goto_play;


  final ValueNotifier<String> _attention_popup_text = ValueNotifier<String>('');
  ValueNotifier<String> get attention_popup_text => _attention_popup_text;

  final ValueNotifier<String> _attention_popup_title = ValueNotifier<String>('');
  ValueNotifier<String> get attention_popup_title => _attention_popup_title;

  final ValueNotifier<int> _attention_popup = ValueNotifier<int>(0);
  ValueNotifier<int> get attention_popup => _attention_popup;

  final ValueNotifier<int> _account_check = ValueNotifier<int>(0);
  ValueNotifier<int> get account_check => _account_check;

  // String _preferred_popup_image = '';
  // String get preferred_popup_image => _preferred_popup_image;
  // Tutor-specific properties

  final ValueNotifier<String> _tuition_id = ValueNotifier<String>('');
  ValueNotifier<String> get tuition_id => _tuition_id;

  final ValueNotifier<String> _tuition_name = ValueNotifier<String>('');
  ValueNotifier<String> get tuition_name => _tuition_name;

  final ValueNotifier<String> _share_date = ValueNotifier<String>('');
  ValueNotifier<String> get share_date => _share_date;

  final ValueNotifier<String> _location = ValueNotifier<String>('');
  ValueNotifier<String> get location => _location;

  final ValueNotifier<String> _g_id = ValueNotifier<String>('');
  ValueNotifier<String> get g_id => _g_id;

  final ValueNotifier<String> _remark = ValueNotifier<String>('');
  ValueNotifier<String> get remark => _remark;

  final ValueNotifier<String> _placment = ValueNotifier<String>('');
  ValueNotifier<String> get placment => _placment;

  final ValueNotifier<String> _class_namee = ValueNotifier<String>('');
  ValueNotifier<String> get class_namee => _class_namee;

  final ValueNotifier<String> _subject_name = ValueNotifier<String>('');
  ValueNotifier<String> get subject_name => _subject_name;

  final ValueNotifier<String> _limit_statement = ValueNotifier<String>('');
  ValueNotifier<String> get limit_statement => _limit_statement;

  final ValueNotifier<int> _job_closed = ValueNotifier<int>(0);
  ValueNotifier<int> get job_closed => _job_closed;

  final ValueNotifier<int> _already = ValueNotifier<int>(0);
  ValueNotifier<int> get already => _already;

    final ValueNotifier<String> _msg = ValueNotifier<String>('');
  ValueNotifier<String> get msg => _msg;

  final ValueNotifier<String> _term_condition_heading = ValueNotifier<String>('');
  ValueNotifier<String> get term_condition_heading => _term_condition_heading;

  final ValueNotifier<String> _term_condition_heading_home = ValueNotifier<String>('');
  ValueNotifier<String> get term_condition_heading_home => _term_condition_heading_home;

  final ValueNotifier<int> _succes = ValueNotifier<int>(0);
  ValueNotifier<int> get succes => _succes;

  final ValueNotifier<int> _is_apply = ValueNotifier<int>(0);
  ValueNotifier<int> get is_apply => _is_apply;

  final ValueNotifier<String> _registration_slip = ValueNotifier<String>('');
  ValueNotifier<String> get registration_slip => _registration_slip;

  final ValueNotifier<String> _registration_slip_quran = ValueNotifier<String>('');
  ValueNotifier<String> get registration_slip_quran => _registration_slip_quran;

  final ValueNotifier<String> _registration_slip_english = ValueNotifier<String>('');
  ValueNotifier<String> get registration_slip_english => _registration_slip_english;
 
 String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  // Future<void> getBasepath() async {
  //   try{
  //     String url = "https://surveyors.com.pk/mobile_app/fta_application.php";
  //     final response = await http.get(Uri.parse(url));
  //     if(response.statusCode == 200){
  //       final data = response.body.toString();
  //       print(data);
  //       MySharedPrefrence().set_baseUrl(data);
  //       print(Utils.baseUrl);
  //     }
  //   }catch(e){
  //     print(e);
  //   }finally{
  //     print('final');
  //   }
  // }
  

    Future<void> getSingleTuitions(String reference) async {
    _isLoading = true;
    try {
      String url =
          '${Utils.baseUrl}single_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&tuition=$reference';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('refrence id $reference');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        var data = jsonResponse['tuition_listing'];
        if (data.isNotEmpty) {
            _tuition_id.value = data[0]['tuition_id'];
            _tuition_name.value = data[0]['tuition_name'];
            _share_date.value = data[0]['share_date'];
            _location.value = data[0]['location'];
            _g_id.value = data[0]['group_id'];
            _remark.value = data[0]['remarks'];
            _placment.value = data[0]['Placement'];
            _class_namee.value = data[0]['class_name'];
            _subject_name.value = data[0]['subject'];
            _limit_statement.value = data[0]['limit_statement'];
            _job_closed.value = data[0]['job_closed'];
            _already.value = data[0]['already'];
            _isLoading = false;
            print(g_id);
        } else {
          print('Error: Empty tuition_listing');
          _isLoading = false;
        }
      } else {
        print('Error: ${response.statusCode}');
        _isLoading = false;
      }
    } catch (e) {
      print('Error: $e');
      _isLoading = false;
    }
  }

  Future<void> applyTuitions(BuildContext context, Function updateCardState) async {
    _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}apply_tuition.php?code=10&group_id=$g_id&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('group id $g_id');
      print('tuition id $tuition_id');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        _msg.value = jsonResponse['message'];
        _succes.value = jsonResponse['success'];
        _is_apply.value = jsonResponse['is_applied '];
        print('apply message $msg');
        print('success $success');
        print('apply $is_apply');
        if(success == 0){
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/error_lottie.json', msg.value, (){});
          
        }else{
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/success_lottie.json', msg.value,(){});
          Utils.snakbarSuccess(context, msg.value);
          updateCardState();
        }
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

  Future<void> fetchTuitions(int start, int limit) async {
    _isLoading = true;
    _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}tuitions.php?code=10&tutor_id=0&start=$start&end=$limit';
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
          '${Utils.baseUrl}tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=$limit';
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
          '${Utils.baseUrl}preferred_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=$limit&cell_access_token=${MySharedPrefrence().get_cell_token().toString()}&version=107';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['tuition_listing'];
        _preferred_popup.value = jsonResponse['popup_status'][0]; 
        _discount_popup.value = jsonResponse['discount_popup_status'][0];
        _preferred_popup_image.value = jsonResponse['popup_img'][0];
        _discount_popup_image.value = jsonResponse['discount_img'][0];
        _attention_popup.value = jsonResponse['attention_popup'][0];
        _attention_popup_text.value = jsonResponse['attention_popup_text'][0];
        _attention_popup_title.value = jsonResponse['attention_popup_title'][0];
        _account_check.value = jsonResponse['account_check'][0];
        _goto_play.value = jsonResponse['enable_popup_status'][0];

        print('img $_preferred_popup_image');
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
          '${Utils.baseUrl}group_class.php?code=10&group_id=$g_id';
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
     print(reusabletextfieldcontroller.feedback.text);
    try {
      String url =
          '${Utils.baseUrl}feedback.php';
      final response = await http.post(Uri.parse(url),body: {
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
        'remakrs' : reusabletextfieldcontroller.feedback.text,
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

  Future<void> basicTutorInfo(String tutorId)async{
    // setState(() {
    //   isLoading = true;
    // });
    try{
      final response = await http.get(
      Uri.parse('${Utils.baseUrl}step_1.php?code=10&tutor_id=${tutorId}'),
    );
    if (response.statusCode == 200) {
              final Map<String, dynamic> responseData =
                  json.decode(response.body);
              MySharedPrefrence().set_info(responseData['info']);
              print('basic Info ${MySharedPrefrence().get_info()}');
              // setState(() {});
            } else {
              print('Error2: ' + response.statusCode.toString());
            }
    
    }catch(e){
      print('Data Not Load $e');
    }
  }


  Future<void> Check_popup()async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}check_popup.php?step_check=1&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
      MySharedPrefrence().set_faqs(jsonResponse['faqs_images']);
       MySharedPrefrence().set_term_condition(jsonResponse['term_condition_image']);
        _Registration_text = jsonResponse['Registration_text'];
        _registration_heading = jsonResponse['registration_heading'];
        _Registration_text_quran = jsonResponse['Registration_text_quran'];
        _registration_heading_quran = jsonResponse['registration_heading_quran'];
        _Registration_text_english = jsonResponse['Registration_text_english'];
        _registration_heading_english = jsonResponse['registration_heading_english'];
        _registration_slip.value = jsonResponse['registration_slip'];
        _registration_slip_quran.value = jsonResponse['registration_slip_quran']; 
        _registration_slip_english.value = jsonResponse['registration_slip_english']; 
        _basicInfo.value = jsonResponse['basic_info'];
        _qualification_pref.value = jsonResponse['qualification_pref'];
        _docs_att.value = jsonResponse['docs_att'];
        _additional_info.value = jsonResponse['additional_info'];
        _bank_details.value = jsonResponse['bank_details'];
        _is_term_accepted.value = jsonResponse['is_term_accepted'];
        _is_term_home.value = jsonResponse['is_term_home'];
        _payment_recipt.value = jsonResponse['payment_recipt'];
        _quran_payment_recipt.value = jsonResponse['quran_payment_recipt'];
        _english_payment_recipt.value = jsonResponse['payment_recipt_english'];
        _term_condition_heading.value = jsonResponse["term_condition_heading"];
        _term_condition_heading_home.value = jsonResponse['term_condition_heading_home'];
        _is_term_accepted_online_option.value = jsonResponse['term_condition_online_option'];
        _is_term_accepted_online.value = jsonResponse['term_condition_online'];
        _traning_video.value = jsonResponse['traning_video'];
        _attention_option.value = jsonResponse['attention_popup'];
        _payment_recipt_option.value = jsonResponse['option'];
        _payment_recipt_option_quran.value = jsonResponse['quran_option'];
        _payment_recipt_option_english.value = jsonResponse['english_option'];
         MySharedPrefrence().set_term_condition_image(jsonResponse['term_condition_image']);
         MySharedPrefrence().set_faqs_images(jsonResponse['faqs_images']);
        MySharedPrefrence().set_term_condition_image_online(jsonResponse['term_condition_image_ftalive_pfg']);
        MySharedPrefrence().set_attention_title(jsonResponse['attention_popup_title']);
        MySharedPrefrence().set_attention_text(jsonResponse['attention_popup_text']);
        MySharedPrefrence().set_city_id(jsonResponse['cities']);
        print(MySharedPrefrence().get_city_id());
        print('FAQ Image ${MySharedPrefrence().get_faqs()}');
        print('terms & conditions Image ${MySharedPrefrence().get_term_condition()}');
        print('registration $_Registration_text');
        print('online term ${_is_term_accepted_online.toString()}');
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

  Future<void> check_msg()async{
     _isLoading = true;
    try {
      String url =
          '${Utils.baseUrl}check_popup.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        _popup.value = (jsonResponse['popup']);
        MySharedPrefrence().set_popup_text(jsonResponse['message']);
        print('popup condition $_popup');
        print('popup msg ${MySharedPrefrence().get_popup_text()}');
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

  Future<void> check_delete_account()async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}check_popup.php?delete_check=1';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        _delete_account.value = (jsonResponse['show']);
        print('delete account condition $_delete_account');
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

  Future<void> get_Token() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    _cell_token = await messaging.getToken();
    print('token $_cell_token');
    MySharedPrefrence().set_cell_token(_cell_token);
  }

  Future<void> deleteAccount(BuildContext context)async{
     _isLoading = true;

    try {
      String url =
          '${Utils.baseUrl}deletemyaccount.php';
      final response = await http.post(Uri.parse(url),body: {
        'celltoken' : MySharedPrefrence().get_cell_token().toString(),
        'tutor_id' : MySharedPrefrence().get_user_ID().toString(),
      });

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        String msg = jsonResponse['message'];
        if(jsonResponse['success'] == 1){
          Utils.snakbarSuccess(context, msg);
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WillPopScope(
            onWillPop: () async => false,
            child: Login(),
          ),
        ),
      );
        }else{
          Utils.snakbarFailed(context, msg);
        }
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
          '${Utils.baseUrl}password_rest.php';
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

  Future<void> getNotification(int start) async {
    _isLoading = true;
    _showLoadMoreButton = false;

    try {
      String url =
          '${Utils.baseUrl}get_notification.php?tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        List<dynamic> newItems = jsonResponse['notification'];
        print('notification $newItems');
        if (start == 0) {
          _allNotificationList = newItems;
        } else {
          _allNotificationList.addAll(newItems);
        }
        print('Updated Notification list: $_allTuitionsList');
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

  Future<void> documentsAttach() async {

    // setState(() {
      _isLoading = true;
    // });

    try {
      String url =
          '${Utils.baseUrl}get_ducoments.php?code=10&tutors_ids=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
      // setState(() {
          _profile_image.value = jsonResponse['personal_image'];
          _cnic_f.value = jsonResponse['cnic_front'];
          _cnic_b.value = jsonResponse['cnic_back'];
          _last_document.value = jsonResponse['last_document'];
          _other_1.value = jsonResponse['other_1'];
          _other_2.value = jsonResponse['other_2'];
          _other_3.value = jsonResponse['other_3'];
          _other_4.value = jsonResponse['other_4'];
          _other_5.value = jsonResponse['other_5'];
          _other_6.value = jsonResponse['other_6'];
          _doc_error.value = jsonResponse['docs_error'];
          _doc_msg.value = jsonResponse['docs_msg'];
          _is_term_accept.value = jsonResponse['is_term_accepted'];
          _charges_image.value = jsonResponse['payment_recipt'];
          _charges_image_quran.value = jsonResponse['payment_recipt_quran'];
          _charges_image_english.value = jsonResponse['payment_recipt_english_l'];
          // MySharedPrefrence().set_profile_img(profile);
        // });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      // setState(() {
        _isLoading = false;
      // });
    }
  }


  // Function to fetch search results
  Future<List<Tuition>> searchTuitions(String searchText,String apiUrl) async {
    final response = await http.get(
      Uri.parse('$apiUrl?searchtext=$searchText&code=10&tutor_id=${MySharedPrefrence().get_user_ID()}'),
    );

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);

      // Check if there are tuition listings
      if (data['tuition_listing'] != null) {
        List<Tuition> tuitions = [];
        for (var item in data['tuition_listing']) {
          tuitions.add(Tuition.fromJson(item));
        }
        return tuitions;
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load tuitions');
    }
  }

  Future<bool> onWillPop() async {
    if (Platform.isAndroid) {
      // For Android, use moveTaskToBack to send the app to the background
      SystemChannels.platform.invokeMethod('SystemNavigator.pop'); // Correct method call
      return Future.value(false); // Prevent app from closing
    } else {
      return Future.value(false); // For iOS or other platforms, prevent app closure
    }
  }

  Future<List<Bank>> fetchBanks() async {
  final response = await http.get(Uri.parse("${Utils.baseUrl}all_in.php?banks=1"));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List banksJson = data['banks_listing'];
    return banksJson.map((json) => Bank.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load banks');
  }
}

Future<List<Wallet>> fetchWalletBanks() async {
  final response = await http.get(Uri.parse("${Utils.baseUrl}all_in.php?cash_wallet=1"));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final List banksJson = data['cash_wallet_listing'];
    return banksJson.map((json) => Wallet.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load banks');
  }
}

Future<void> fetchData(String type,String responseName, List<dynamic> newItems, List<Map<String, String>> selectedIds, Function updateSelectedNames,Function(bool) setLoading) async {
    // setState(() {
    //   isLoading = true;
    // });
    setLoading(true);
    try {
      String url = '${Utils.baseUrl}all_in.php?$type=1';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        Uint8List responseBytes = response.bodyBytes;
        String responseBody = utf8.decode(responseBytes, allowMalformed: true);
        responseBody = removeBom(responseBody);

        if (isJsonValid(responseBody)) {
          dynamic jsonResponse = jsonDecode(responseBody);
          // setState(() {
            newItems.clear();
            if (type == 'course') {
              // Flatten course listing map into a list with category info
              Map<String, dynamic> courseMap = jsonResponse['${responseName}_listing'];
              courseMap.forEach((category, courses) {
                for (var course in courses) {
                  course['category'] = category;
                  newItems.add(course);
                }
              });
            } else {
              // For group, just add the list
              newItems.addAll(jsonResponse['${responseName}_listing']);
            }
            // newItems.addAll(jsonResponse['${responseName}_listing']);
            updateSelectedNames();
          // });
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
      // setState(() {
      //   isLoading = false;
      // });
      setLoading(false);
    }
  }

  Future<void> fetchSegmentData(List<Map<String, dynamic>> segments)async{
    //  setLoading(true);
    try {
      String url = '${Utils.baseUrl}all_in.php?Segment_listing=1';
      final response = await http.get(Uri.parse(url));
      print('url $url');

      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        final List<dynamic> listing = data['Segment_listing'];
        segments = List<Map<String, dynamic>>.from(listing);
        print(segments);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error hello: $e');
    } finally {
      // setState(() {
      //   isLoading = false;
      // });
      // setLoading(false);
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

  void search(BuildContext context,List<dynamic> newItems, List<Map<String, String>> selectedIds, String name,Function toggleSelection) {
    TextEditingController searchController = TextEditingController();
    List<dynamic> filteredItems = List.from(newItems);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, StateSetter setState) {
          void filterSearchResults(String query) {
            if (query.isNotEmpty) {
              List<dynamic> tempList = [];
              newItems.forEach((item) {
                if (item[name].toString().toLowerCase().contains(query.toLowerCase())) {
                  tempList.add(item);
                }
              });
              setState(() {
                filteredItems.clear();
                filteredItems.addAll(tempList);
              });
            } else {
              setState(() {
                filteredItems.clear();
                filteredItems.addAll(newItems);
              });
            }
          }

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: 'Search',
                      hintStyle: TextStyle(fontSize: 11.5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 300, // fixed height for the dialog list
                    child: (name == 'course_name' && filteredItems.isNotEmpty && filteredItems[0].containsKey('category'))
                        ? // Grouped course list
                        ListView(
                            children: filteredItems
                                .groupby((item) => item['category'])
                                .entries
                                .map((entry) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    child: Text(
                                      entry.key,
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    ),
                                  ),
                                  ...entry.value.map((course) {
                                    String courseName = course['course_name'];
                                    String courseId = course['id'];
                                    bool isSelected = selectedIds.any((e) => e['id'] == courseId);
                                    return ListTile(
                                      dense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                      title: Text(courseName),
                                      trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                                      onTap: () {
                                        setState(() {});
                                        toggleSelection(courseId, courseName, name);
                                      },
                                    );
                                  }).toList()
                                ],
                              );
                            }).toList(),
                          )
                        : // Normal flat list (for groups)
                        ListView.builder(
                            itemCount: filteredItems.length,
                            itemBuilder: (context, index) {
                              String itemName = filteredItems[index][name];
                              String itemId = filteredItems[index]['id'].toString();
                              bool isSelected = selectedIds.any((element) => element['id'] == itemId);
                              return Column(
                                children: [
                                  ListTile(
                                    dense: true,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 8.0),
                                    title: Text(itemName),
                                    trailing: isSelected ? Icon(Icons.check, color: Colors.black) : null,
                                    onTap: () {
                                      setState(() {});
                                      toggleSelection(itemId, itemName, name);
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
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: reusableBtn(context, 'Add', () {
                        setState(() {});
                        Navigator.pop(context);
                      }),
                    ),
                    reusablaSizaBox(context, .03),
                    Expanded(
                      child: reusablewhite(context, 'Cancel', () {
                        Navigator.pop(context);
                      }),
                    ),
                  ],
                ),
              ),
              ],
            ),
          );
        },
      ),
    );
  }


  Future<List<Meeting>> fetchOnlinePortalListing() async {
  final url = Uri.parse("${Utils.baseUrl}online_portal_api.php?listing_meeting=1&user_id=${MySharedPrefrence().get_user_ID()}&app_user_type=2");
  final response = await http.get(url);
  print(MySharedPrefrence().get_user_ID());
  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => Meeting.fromJson(e)).toList();
  } else {
    throw Exception("Failed to load meetings");
  }
}


Future<void> updateMeetingInfo({
  required String id,
  required String zoomLink,
  required String meetingId,
  required String meetingPass,
  required String meetingHost,
}) async {
  final url = Uri.parse("${Utils.baseUrl}online_portal_api.php");

  final response = await http.post(url, body: {
    "meeting_info": '1',
    "id": id,
    "zoom_link": zoomLink,
    "meeting_id": meetingId,
    "meeting_password": meetingPass,
    "meeting_hostkey": meetingHost,
  });

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    print("Update Success: $res");
  } else {
    throw Exception("Failed to update meeting info");
  }
}


Future<void> updateProgressReport({
  required String date,
  required String tuition_id,
  required String topic_covered,
  required String topic_plan,
  required String teacher_re,
  required String t_name,
  required String tutor_id,
}) async {
  final url = Uri.parse("${Utils.baseUrl}online_portal_api.php");

  final response = await http.post(url, body: {
    "tuition_id": tuition_id,
    "daily": '1',
    "progress_report": '1',
    "datetime": date,
    "topics_covered": topic_covered,
    "topics_planed": topic_plan,
    "teacher_remarks": teacher_re,
    "tutor_Name": t_name,
    "tutor_id": tutor_id,
  });

  if (response.statusCode == 200) {
    final res = jsonDecode(response.body);
    print("Update Success: $res");
  } else {
    throw Exception("Failed to update meeting info");
  }
}

  

}
