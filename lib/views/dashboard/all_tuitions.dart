


import 'dart:async';
import 'dart:convert';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/MySharedPrefrence.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusablecard.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class AllTuitions extends StatefulWidget {
  const AllTuitions({super.key});

  @override
  State<AllTuitions> createState() => _AllTuitionsState();
}

class _AllTuitionsState extends State<AllTuitions> {
  final TextEditingController _searchCon = TextEditingController();
  bool isLoading = false;
  Future<Map<String, dynamic>>? _futureTuitions;
  Color _color = colorController.yellowColor; // Initial color
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _futureTuitions = allTuitions();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _color = _color == colorController.yellowColor ? colorController.yellowColor2 : colorController.yellowColor;
        // colorController.yellowColor2; // New color
      });
    });
  }


  Future<Map<String, dynamic>> allTuitions()async{
    setState(() {
      isLoading = true;
    });
    try {
    final response = await http.get(
      Uri.parse('${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=0&end=10'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('All Tuitions $responseData');
      return responseData;
    } else {
      print('Error2: ' + response.statusCode.toString());
      return {};
    }
  } catch (e) {
    print('No Data Found $e');
    throw Exception('No Data Found $e');
  } finally {
    setState(() {
      isLoading = false;
    });
  }
  }

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: reusableappbar(context,_color),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .032),
          child: Column(children: [
            // reusablaSizaBox(context, .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                reusableText('All Tuitions',fontsize: 25,color: colorController.blackColor, fontweight: FontWeight.bold),
                reusableyoutubeIcon(context),
              ],
            ),
            reusablaSizaBox(context, .007),
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * .065,
              child: TextField(
                    controller: _searchCon,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[350],
                      hintText: 'Search Tuitions',
                      prefixIcon: Icon(Icons.search,color: Colors.grey[270],),
                      // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
                      hintStyle: TextStyle(color: Colors.grey[250]),
                      border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
                  ),
                      enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // borderSide: BorderSide(
              //     color: colorController.textfieldBorderColorBefore, width: 1.5)
                  ),
                      focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none
              // borderSide: BorderSide(
              //     color: colorController.grayTextColor, width: 1.5)
                  ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      // contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
                    ),
                  ),
            ),
            reusablaSizaBox(context, .009),
            reusableVisiblity(context, 'Apply carefully to maintain your profile', (){}),
            reusablaSizaBox(context, .025),
            // ElevatedButton(onPressed: (){
            //   allTuitions();
            // }, child: Text('data')),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
        future: _futureTuitions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var tuitions = snapshot.data!['tuition_listing'];
            if (tuitions.isEmpty) {
              return Center(
                child: Text('No Tuitions Found'),
              );
            }
            return ListView.builder(
              itemCount: tuitions.length,
              itemBuilder: (context, index) {
                var data = tuitions[index];
                MySharedPrefrence().set_share_date(data['share_date']);
                MySharedPrefrence().set_tuition_name(data['tuition_name']);
                MySharedPrefrence().set_class_name(data['class_name']);
                MySharedPrefrence().set_subject(data['subject']);
                MySharedPrefrence().set_Placement(data['Placement']);
                MySharedPrefrence().set_location(data['location']);
                MySharedPrefrence().set_limit(data['limit_statement']);
                MySharedPrefrence().set_remarks(data['remarks']);
                return Container(
                  height: MediaQuery.of(context).size.height * 0.19,
                  child: Stack(
                            children: [
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.023,
                                left: MediaQuery.of(context).size.width * 0.001,
                                                right: MediaQuery.of(context).size.width * .001,
                                child: InkWell(
                                  onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
                                  child: reusablecard(context)),
                                ),
                                Positioned(
                                                left: MediaQuery.of(context).size.width * 0.45,
                                                top: MediaQuery.of(context).size.height * 0.005,
                                                right: MediaQuery.of(context).size.width * .27,
                                                child: InkWell(
                                                  onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
                                                  child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))),
                                                Positioned(
                                                left: MediaQuery.of(context).size.width * 0.72,
                                                top: MediaQuery.of(context).size.height * 0.005,
                                                right: MediaQuery.of(context).size.width * .03,
                                                child: InkWell(
                                                  onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
                                                  child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor))),
                            ],
                                                    // );
                                                    // },
                                                    ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No Tuitions Found'),
            );
          }
        },
      ),
            ),
            // reusablecard(context),
          ],),
        ),
      ),
    );
  }
}