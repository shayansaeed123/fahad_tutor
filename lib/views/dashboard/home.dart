import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/check_connectivity.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
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
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({super.key,required this.isLoading2});
  bool isLoading2;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = false;
  bool isLoading2 = false;
  bool visible = true;
  int start = 0;
  int limit = 10;
  int success = 0;
  int is_apply = 0;
  String g_id = '';
  String tuition_id = '';
  String msg= '';
  final TextEditingController _searchCon = TextEditingController();
  Connectivity connectivity = Connectivity();
  final ScrollController _scrollController = ScrollController();
  TutorRepository repository = TutorRepository();
  List<dynamic> tuitions = [];

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
  void initState() {
    super.initState();
    fetchInitialTuitions();
  }

  Future<void> fetchInitialTuitions() async {
    setState(() {
      isLoading2 = true;
    });
    await repository.prefferedTuitions(start, limit);
    setState(() {
      tuitions = repository.prefferedTuitionsList;
    });
    setState(() {
      isLoading2 = false;
    });
  }

  Future<void> loadMoreTuitions() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.prefferedTuitions(start, limit);
    setState(() {
      tuitions = repository.prefferedTuitionsList;
      isLoading = false;
    });
  }

  Future<void> applyTuitions() async {
    // setState(() {
    //   isLoading2 = true;
    // });

    try {
      String url =
          '${Utils.baseUrl}mobile_app/apply_tuition.php?code=10&group_id=$g_id&tuition_id=$tuition_id&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('group id $g_id');
      print('tuition id $tuition_id');

      if (response.statusCode == 200) {
        // setState(() {isLoading2= false;});
        dynamic jsonResponse = jsonDecode(response.body);
        msg = jsonResponse['message'];
        success = jsonResponse['success'];
        is_apply = jsonResponse['is_applied '];
        print('apply message $msg');
        print('success $success');
        print('apply $is_apply');
        if(success == 0){
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/error_lottie.json', msg, refreshPage);
          
        }else{
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/success_lottie.json', msg,refreshPage);
          Utils.snakbarSuccess(context, msg);
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      setState(() {
        // isLoading2 = false;
      });
    }
  }
  void refreshPage() {
  setState(() {
    fetchInitialTuitions();
  });
}

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: reusableappbar(context, colorController.yellowColor,(){Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));}),
    body: 
    // Stack(
    //   children: [
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
                   widget.isLoading2 || isLoading2
                ? Center(child: reusableloadingrow(context, widget.isLoading2||isLoading2)):
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: tuitions.length + 1,
                        itemBuilder: (context, index) {
                          if (index < tuitions.length) {
                            var data = tuitions[index];
                            MySharedPrefrence().setAllTuitions(data);
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
                                          g_id = data['group_id'];
                                          tuition_id = data['tuition_id'];
                                          print('Preferred tuition id: ${data['tuition_id']}');
                                          reusabletutorDetails(
                                              context,formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],(){
                                                if(data['group_id'] == '0'){
                                                  applyTuitions();
                                                }else{
                                                  reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm', (){
                                                    applyTuitions();
                                                  }, (){Navigator.pop(context);});
                                                }
                                              },
                                              data['group_id'],
                                              data['tuition_id'],
                                              data['already']
                                                  );
                                                  setState(() {});
                                                print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                                repository.group_id(data['group_id']);
                                        },
                                        child: reusablecard(context,
                                        data['tuition_name'],
                                        data['class_name'],
                                        data['share_date'],
                                        data['location'],
                                        data['subject'],
                                        data['already'],
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
                                              data['limit_statement'],(){
                                                if(data['group_id'] == '0'){
                                                  applyTuitions();
                                                }else{
                                                  reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm', (){
                                                    applyTuitions();
                                                  }, (){Navigator.pop(context);});
                                                }
                                              },
                                              data['group_id'],
                                              data['tuition_id'],
                                              data['already']
                                                );
                                                setState(() {});
                                                print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                                repository.group_id(data['group_id']);
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
                                              data['limit_statement'],(){
                                                if(data['group_id'] == '0'){
                                                  applyTuitions();
                                                }else{
                                                  reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm', (){
                                                    applyTuitions();
                                                  }, (){Navigator.pop(context);});
                                                }
                                              },
                                              data['group_id'],
                                              data['tuition_id'],
                                              data['already']
                                                );
                                                setState(() {});
                                                print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                                repository.group_id(data['group_id']);
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
                              child: isLoading
                                  ? reusableloadingrow(context, isLoading)
                                  : repository.showLoadMoreButton
                                      ? reusableBtn(
                                          context, 'Load More', () {
                                          loadMoreTuitions();
                                        })
                                      : Center(
                                      child: CircularProgressIndicator(
                                      color: colorController.btnColor,
                                    )),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              ],
            ),
          ),
        ),
    //     if(isLoading == true)
    //       reusableloadingrow(context, isLoading),
    //   ],
    // ),
  );
}

  }
// }