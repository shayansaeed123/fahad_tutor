import 'dart:convert';

import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:http/http.dart' as http;



class TutorRepository{

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<dynamic> _listResponse = [];
  List<dynamic> get listResponse => _listResponse;
  Future<List<dynamic>> fetchViewTuitions(int start,int limit,) async {
    _isLoading = true;
   try{
    _isLoading = false;
    String url =
          '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=31110&start=$start&end=${limit}';
     final response = await http.get(Uri.parse(url));
     print('url $url');

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);
      _listResponse = jsonResponse['tuition_listing'];
      print('List $_listResponse');
      print('llllll $_listResponse');

      return listResponse;
    } else {
      print('Error: ${response.statusCode}'); 
      return [];
    }
   }catch(e){
    print('Error : $e');
    throw Exception(e);
   }finally{
      _isLoading = false;
   }
  }


  
  
}