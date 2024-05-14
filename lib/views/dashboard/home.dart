

import 'dart:async';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
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
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     backgroundColor: colorController.whiteColor,
  //     appBar: reusableappbar(context,_color),
  //     body: SafeArea(
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(
  //           horizontal: MediaQuery.of(context).size.width * .032),
  //         child: Column(children: [
  //           // reusablaSizaBox(context, .01),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               reusableText('Preffered Tuitions',fontsize: 25,color: colorController.blackColor, fontweight: FontWeight.bold),
  //               reusableyoutubeIcon(context),
  //             ],
  //           ),
  //           reusablaSizaBox(context, .007),
  //           Container(
  //             width: MediaQuery.of(context).size.width * 1,
  //             height: MediaQuery.of(context).size.height * .065,
  //             child: TextField(
  //                   controller: _searchCon,
  //                   keyboardType: TextInputType.text,
  //                   decoration: InputDecoration(
  //                     filled: true,
  //                     fillColor: Colors.grey[350],
  //                     hintText: 'Search Tuitions',
  //                     prefixIcon: Icon(Icons.search,color: Colors.grey[270],),
  //                     // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
  //                     hintStyle: TextStyle(color: Colors.grey[250]),
  //                     border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             borderSide: BorderSide.none
  //                 ),
  //                     enabledBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             borderSide: BorderSide.none
  //             // borderSide: BorderSide(
  //             //     color: colorController.textfieldBorderColorBefore, width: 1.5)
  //                 ),
  //                     focusedBorder: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(15),
  //             borderSide: BorderSide.none
  //             // borderSide: BorderSide(
  //             //     color: colorController.grayTextColor, width: 1.5)
  //                 ),
  //                     errorBorder: InputBorder.none,
  //                     disabledBorder: InputBorder.none,
  //                     // contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
  //                   ),
  //                 ),
  //           ),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               reusablaSizaBox(context, .009),
  //           reusableVisiblity(context, 'Apply carefully to maintain your profile', (){}),
  //           Stack(
  //           children: [
              // Positioned(
                
              //   top: MediaQuery.of(context).size.height * 0.001,
              //   // left: MediaQuery.of(context).size.height * 0.025,
              //   // right: MediaQuery.of(context).size.height * 0.025,
              //   child: reusablecard(context),
              //   ),
              //   Positioned(
              //     left: MediaQuery.of(context).size.width * 0.45,
              //     top: MediaQuery.of(context).size.height * 0.001,
              //     right: MediaQuery.of(context).size.width * .27,
              //     child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))
  //           ],
  //                       ),
  //             ]
  //           ),
  //         ],),
  //       ),
  //     ),
  //   );

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
                      reusableVisiblity(context, 'Apply carefully to maintain your profile', (){}),
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
                                onTap: (){reusabletutorDetails(context);},
                                child: reusablecard(context)),
                              ),
                              Positioned(
                                              left: MediaQuery.of(context).size.width * 0.45,
                                              top: MediaQuery.of(context).size.height * 0.005,
                                              right: MediaQuery.of(context).size.width * .27,
                                              child: InkWell(
                                                onTap: (){reusabletutorDetails(context);},
                                                child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))),
                                              Positioned(
                                              left: MediaQuery.of(context).size.width * 0.72,
                                              top: MediaQuery.of(context).size.height * 0.005,
                                              right: MediaQuery.of(context).size.width * .03,
                                              child: InkWell(
                                                onTap: (){reusabletutorDetails(context);},
                                                child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor))),
                          ],
                                                  // );
                                                  // },
                                                  )
                      )
                // Expanded(
                //   child: 
                //   Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                      // reusablaSizaBox(context, .009),
                      // reusableVisiblity(context, 'Apply carefully to maintain your profile', (){}),
                //       // Container(
                //       //   height: MediaQuery.of(context).size.height * 0.5, // Set a height for the Stack
                //       //   child: 
                //         Expanded(
                //           child: ListView.builder(
                //             itemCount: 10,
                //             itemBuilder: (context, index) {
                            
                //             return Stack(
                //             children: [
                //               Positioned(
                                          
                //                           // top: MediaQuery.of(context).size.height * 0.023,
                //                           // left: MediaQuery.of(context).size.height * 0.00,
                //                           // right: MediaQuery.of(context).size.width * 0.00,
                //                           child: reusablecard(context),
                //                           ),
                                          // Positioned(
                                          //   left: MediaQuery.of(context).size.width * 0.45,
                                          //   top: MediaQuery.of(context).size.height * 0.005,
                                          //   right: MediaQuery.of(context).size.width * .27,
                                          //   child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor)),
                                          //   Positioned(
                                          //   left: MediaQuery.of(context).size.width * 0.72,
                                          //   top: MediaQuery.of(context).size.height * 0.005,
                                          //   right: MediaQuery.of(context).size.width * .03,
                                          //   child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor)),
                //             ],
                //           );
                //           },),
                //         )
                //       // ),
                      
                //     ],
                //   ),
                // ),
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