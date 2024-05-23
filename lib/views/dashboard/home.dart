

import 'dart:async';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusablecard.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  bool visible = true;
  final TextEditingController _searchCon = TextEditingController();
  Color _color = colorController.yellowColor; // Initial color
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _color = _color == colorController.yellowColor ? colorController.yellowColor2 : colorController.yellowColor; // New color
      });
    });
  }
  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: reusableappbar(context, _color),
    body: Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .032),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    reusableText('Preffered Tuitions',
                        fontsize: 25,
                        color: colorController.blackColor,
                        fontweight: FontWeight.bold),
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
                      prefixIcon: Icon(Icons.search, color: Colors.grey[270],),
                      hintStyle: TextStyle(color: Colors.grey[250]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none
                      ),
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                  ),
                ),
                  reusablaSizaBox(context, .009),
                      reusableVisiblity(context, 'Apply carefully to maintain your profile', (){
                        setState(() {});
                        visible = false;},visible),
                      Expanded(
                        child: 
                        // ListView.builder(
                        //   // itemCount: 10,
                        //   itemBuilder: (context, index) {
                        //   return 
                          Stack(
                          children: [
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.023,
                              left: MediaQuery.of(context).size.width * 0.001,
                                              right: MediaQuery.of(context).size.width * .001,
                              child: InkWell(
                                onTap: (){
                                  // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                                },
                                child: reusablecard(context)),
                              ),
                              Positioned(
                                              left: MediaQuery.of(context).size.width * 0.45,
                                              top: MediaQuery.of(context).size.height * 0.005,
                                              right: MediaQuery.of(context).size.width * .27,
                                              child: InkWell(
                                                onTap: (){
                                                  // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                                                  },
                                                child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))),
                                              Positioned(
                                              left: MediaQuery.of(context).size.width * 0.72,
                                              top: MediaQuery.of(context).size.height * 0.005,
                                              right: MediaQuery.of(context).size.width * .03,
                                              child: InkWell(
                                                onTap: (){
                                                  // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                                                  },
                                                child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor))),
                          ],
                                                  // );
                                                  // },
                                                  )
                      )
              ],
            ),
          ),
        ),
        if(isLoading == true)
          reusableloadingrow(context, isLoading),
      ],
    ),
  );
}

  }
// }