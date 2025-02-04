import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TermsAndConditions extends StatefulWidget {
  final String imageUrl;
  final String btn;
  final String title;
  final String term;
  const TermsAndConditions({super.key, required this.imageUrl, required this.btn,required this.title,required this.term});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  TutorRepository repository = TutorRepository();
  bool isLoading = false;
  bool _isLoading = false;
  late String _imageUrl;
  late String _btn; 
  late String _title;
  late String _term;
  void faq()async{
      isLoading = true;
    await repository.Check_popup();
    isLoading = false;
  }
  @override
  void initState() {
    super.initState();
    _imageUrl = widget.imageUrl;
    _btn = widget.btn;
    _title = widget.title;
    _term = widget.term;
    faq();
  }

  Future<void> isAccepted()async{
     _isLoading = true;
    try {
      String url =
          '${Utils.baseUrl}check_popup.php?$_term=1&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
      String apiMessage = jsonResponse['msg'];
              print('message $apiMessage');
              // Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
                        Utils.snakbarSuccess(context, apiMessage);
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
  @override
  Widget build(BuildContext context) {
    return 
    reusableprofileidget(context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("$_title",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                           CachedNetworkImage(
                            imageUrl: _imageUrl,
                            placeholder: (context, url) => Center(child: reusableloadingrow(context, isLoading==true)),
                            errorWidget: (context, url, error) => Container(),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                          ),
                          reusablaSizaBox(context, 0.030),
                          if(_btn == '0')
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .069),
                            child: reusableBtn(context, 'Accept', (){
                              isAccepted();
                            }),
                          ),  
                    ],
                  )
                 
                ),
            reusableloadingrow(context, _isLoading),
    );
  }
}