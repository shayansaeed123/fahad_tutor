
import 'dart:convert';

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

class Biography extends StatefulWidget {
  const Biography({super.key});

  @override
  State<Biography> createState() => _BiographyState();
}

class _BiographyState extends State<Biography> {
  bool isLoading = false;
  String Biography = '';
   TutorRepository repository = TutorRepository();
   final TextEditingController _biography = TextEditingController();
   int _count =0; 
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _biography.addListener(_updateCharCount);
    getValue();
  }

  void getValue()async{
    await getBiography();
    setState(() {
       _biography.text = Biography;
    });}

   void _updateCharCount() {
    setState(() {
      _count = _biography.text.length;
    });
  }
   void _validateForm() {
  // bool isBiographyValid = !checkbox2 || (_biography.text.length >= 500 && _biography.text.length <= 800);
  bool isBiographyValid = _biography.text.length >= 500 && _biography.text.length <= 800;

  if (isBiographyValid) {
    // print('object');
    updateBiography();
  } else {
    Utils.snakbar(
      context,
       !isBiographyValid ? (_biography.text.length < 500
                                    ? 'Biography must be at least 500 characters'
                                    : 'Biography must not exceed 800 characters')
                                : "Fill all required fields",
    );
  }}

  Future<void> updateBiography() async {
  setState(() {
    isLoading = true;
  });
  try {
    final bio = _biography.text.toString();
    final response = await http.post(
      Uri.parse('${Utils.baseUrl}check_popup.php'),
      body: {
        'tutor_id': MySharedPrefrence().get_user_ID().toString(),
        'Biography_update': bio.toString(),
      }
    );
    print(bio);
    print('Request body: ${response.request}');
    if (response.statusCode == 200) {
      print('Response status: ${response.statusCode}');
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('Response body: $responseData');
      String apiMessage = responseData['message'];
      print('Message: $apiMessage');
      if (responseData['success'] == 1) {
        setState(() {});
        print('Success message: $apiMessage');
        // Navigator.pop(context);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile(),));
        Utils.snakbarSuccess(context, apiMessage);
      } else {
        Utils.snakbarFailed(context, apiMessage);
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    Utils.snakbar(context, 'Check your Internet Connection');
    print('Update API Error: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

Future<void> getBiography() async {
  setState(() {
    isLoading = true;
  });
  try {
    final userId = MySharedPrefrence().get_user_ID().toString();
    print('Fetching data for user ID: $userId');
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}check_popup.php?Biography=1&tutor_id=$userId')
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      Biography = responseData['Biography'] ?? '';
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Get API Error: $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
}

void _updateTitle() {
    if (mounted) {
      setState(() {
         Biography = _biography.text;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _biography.removeListener(_updateTitle);
    _biography.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return 
    reusableprofileidget( context,
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .032),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // reusableText("FAQ's",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          Text(
                            "Biography",
                            style: TextStyle(
        color: colorController.blackColor,
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'tutorPhi'
        
      ),
                          ),
                          reusablaSizaBox(context, 0.020),
                         TextField(
                  controller: _biography,
                  maxLines: 10, // Set the maximum number of lines
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    label: reusableText('Biography'),
                    labelStyle: TextStyle(color: colorController.grayTextColor),
                    border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: 
                _count > 800 ? colorController.redColor : 
                colorController.textfieldBorderColorAfter, 
                width: 1.5)),
                  ),
            ),
            Row(mainAxisAlignment:MainAxisAlignment.end,children: [reusableText('$_count/800',color: _count > 800 ? colorController.redColor : colorController.blackColor)],),
                        reusablaSizaBox(context, 0.040),
            reusableBtn(context, 'Submit',(){
              _validateForm();
            })
                        ],
                      ),
                      
                    ],
                  ),
                ),
                Center(child: reusableloadingrow(context, isLoading))
    );
  }
}