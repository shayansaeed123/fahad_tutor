import 'dart:convert';

import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
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
  String _name = '';
  String get name => _name;

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
}
