

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/check_connectivity.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
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
  Home({super.key,required this.isLoading2});
  bool isLoading2;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  bool visible = true;
  final TextEditingController _searchCon = TextEditingController();
  Connectivity connectivity = Connectivity();
  final ScrollController _scrollController = ScrollController();
  List<dynamic> tuitions = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: reusableappbar(context, colorController.yellowColor),
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
                        reusablaSizaBox(context, .025),
                        StreamBuilder(
                stream: connectivity.onConnectivityChanged,
                builder: (context, snapshot) {
                  return checkConnection(
                    snapshot,
                   widget.isLoading2
                ? Center(child: reusableloadingrow(context, widget.isLoading2)):
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: tuitions.length + 1,
                        itemBuilder: (context, index) {
                          if (index < tuitions.length) {
                            var data = tuitions[index];
                            MySharedPrefrence().setAllTuitions(data);
                          //   String remarks = data['remarks'];
                          //   String class_name = data['class_name'];
                          //   String tuition_name = data['tuition_name'];
                          //   String Placement = data['Placement'];
                          //   int job = data['job_closed'];
                          //   String subject = data['subject'];
                          //   String share_date = data['share_date'];
                          //   String location = data['location'];
                          //   String limit = data['limit_statement'];
                          //  MySharedPrefrence().set_share_date(data['share_date']);
                          //   MySharedPrefrence().set_tuition_name(data['tuition_name']);
                          //   MySharedPrefrence().set_class_name(data['class_name']);
                          //   MySharedPrefrence().set_subject(data['subject']);
                          //   MySharedPrefrence().set_Placement(data['Placement']);
                          //   MySharedPrefrence().set_location(data['location']);
                          //   MySharedPrefrence().set_limit(data['limit_statement']);
                          //   MySharedPrefrence().set_remarks(data['remarks']);
                          //   MySharedPrefrence().set_job(data['job_closed']);
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.19,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: MediaQuery.of(context).size.height * 0.023,
                                    left: MediaQuery.of(context).size.width * 0.001,
                                    right: MediaQuery.of(context).size.width * .001,
                                    child: InkWell(
                                        onTap: () {
                                          reusabletutorDetails(
                                              context,formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],
                                                  );
                                        },
                                        child: reusablecard(context,
                                        data['tuition_name'],
                                        data['class_name'],
                                        data['share_date'],
                                        data['location'],
                                        data['subject']
                                        )),
                                  ),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width * 0.45,
                                      top: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.width * .27,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                                context,formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],
                                                );
                                          },
                                          child: reusablecardbtn(
                                              context,
                                              '${data['Placement']}',
                                              colorController.btnColor,
                                              colorController.whiteColor))),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width * 0.72,
                                      top: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.width * .03,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                                context,formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],
                                                );
                                          },
                                          child: reusablecardbtn(context, data['job_closed'] == 0 ? 'Open' : 'Closed', data['job_closed'] == 0 ? colorController.yellowColor : colorController.redColor, data['job_closed'] == 0 ? colorController.blackColor : colorController.whiteColor))),
                                ],
                              ),
                            );
                          } else{
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery.of(context).size.width * .32,
                                vertical: MediaQuery.of(context).size.height * .03,
                              ),
                              child: isLoading ? 
                              Center(child: CircularProgressIndicator(color: colorController.btnColor,)) :
                               reusableBtn(context,  'Load More', () {
                                // fetchTuitions();
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
                      // Expanded(
                      //   child: 
                      //   // ListView.builder(
                      //   //   // itemCount: 10,
                      //   //   itemBuilder: (context, index) {
                      //   //   return 
                      //     Stack(
                      //     children: [
                      //       Positioned(
                      //         top: MediaQuery.of(context).size.height * 0.023,
                      //         left: MediaQuery.of(context).size.width * 0.001,
                      //                         right: MediaQuery.of(context).size.width * .001,
                      //         child: InkWell(
                      //           onTap: (){
                      //             // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                      //           },
                      //           // child: reusablecard(context)
                      //           ),
                      //         ),
                      //         Positioned(
                      //                         left: MediaQuery.of(context).size.width * 0.45,
                      //                         top: MediaQuery.of(context).size.height * 0.005,
                      //                         right: MediaQuery.of(context).size.width * .27,
                      //                         child: InkWell(
                      //                           onTap: (){
                      //                             // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                      //                             },
                      //                           child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))),
                      //                         Positioned(
                      //                         left: MediaQuery.of(context).size.width * 0.72,
                      //                         top: MediaQuery.of(context).size.height * 0.005,
                      //                         right: MediaQuery.of(context).size.width * .03,
                      //                         child: InkWell(
                      //                           onTap: (){
                      //                             // reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));
                      //                             },
                      //                           child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor))),
                      //     ],
                      //                             // );
                      //                             // },
                      //                             )
                      // )
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