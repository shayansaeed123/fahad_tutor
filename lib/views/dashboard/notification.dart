
import 'dart:convert';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<dynamic> tuitions = [];
  bool isLoading = false;
  bool isLoading2 = false;
  bool visible = true;
  int success = 0;
  int is_apply = 0;
  String msg = '';
  int start = 0;
  int limit = 10;
  String refrence = '';
  String tuition_id = '';
  String tuition_name = '';
  String class_name = '';
  String subject_name = '';
  String share_date = '';
  String location = '';
  String g_id = '';
  String remark = '';
  String placment = '';
  String limit_statement = '';
  int job_closed = 0;
  int already = 0;
  int onlineTermsCheck = 0;
  String onlineText = '';
  String onlineHeading = '';
  int error = 0;
  String error_msg = '';
  List<dynamic> tuitionData = [];
  TutorRepository repository = TutorRepository();

  @override
  void initState() {
    super.initState();
    fetchNotification();
  }

  String formatApply(String info) {
    return info.replaceAll(',', '\n');
  }

  Future<void> fetchNotification() async {
    setState(() {
      isLoading2 = true;
    });
    await repository.getNotification(start);
    setState(() {
      tuitions = repository.allNotificationList;
    });
    setState(() {
      isLoading2 = false;
    });
  }

  Future<void> loadMoreNotification() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.getNotification(start);
    setState(() {
      tuitions = repository.allNotificationList;
      isLoading = false;
    });
  }

  Future<void> getSingleTuitions(String reference) async {
    setState(() {
      isLoading2 = true;
    });

    try {
      String url =
          '${Utils.baseUrl}single_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&tuition=$reference';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('refrence id $reference');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        tuitionData = jsonResponse['tuition_listing'];
        if (tuitionData.isNotEmpty) {
          setState(() {
            tuition_id = tuitionData[0]['tuition_id'];
            tuition_name = tuitionData[0]['tuition_name'];
            share_date = tuitionData[0]['share_date'];
            location = tuitionData[0]['location'];
            g_id = tuitionData[0]['group_id'];
            remark = tuitionData[0]['remarks'];
            placment = tuitionData[0]['Placement'];
            class_name = tuitionData[0]['class_name'];
            subject_name = tuitionData[0]['subject'];
            limit_statement = tuitionData[0]['limit_statement'];
            job_closed = tuitionData[0]['job_closed'];
            already = tuitionData[0]['already'];
            onlineTermsCheck = tuitionData[0]['Online_terms_check'];
            onlineText = tuitionData[0]['Online_terms_check_text'];
            onlineHeading = tuitionData[0]['Online_terms_check_heading'];
            error = tuitionData[0]['error'];
            error_msg = tuitionData[0]['error_msg'];
            isLoading2 = false;
            print(g_id);
          });
        } else {
          print('Error: Empty tuition_listing');
          setState(() {
            isLoading2 = false;
          });
        }
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          isLoading2 = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading2 = false;
      });
    }
  }

  String convertToRelativeTime(String inputDate) {
  DateTime date = DateFormat('yyyy-MM-dd HH:mm:ss').parse(inputDate);
  DateTime now = DateTime.now();

  Duration difference = now.difference(date);

  if (difference.inDays >= 14) {
    return '${(difference.inDays / 7).floor()}w';
  } else if (difference.inDays >= 7) {
    return '1w';
  } else if (difference.inDays >= 2) {
    return '${difference.inDays}d';
  } else if (difference.inDays >= 1) {
    return '1d';
  } else {
    return 'Today';
  }
}

  Future<void> applyTuitions(Function updateCardState) async {
    setState(() {
      isLoading2 = true;
    });

    try {
      String url =
          '${Utils.baseUrl}apply_tuition.php?code=10&group_id=$g_id&tuition_id=$tuition_id&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('group id $g_id');
      print('tuition id $tuition_id');

      if (response.statusCode == 200) {
        setState(() {isLoading2= false;});
        dynamic jsonResponse = jsonDecode(response.body);
        msg = jsonResponse['message'];
        success = jsonResponse['success'];
        is_apply = jsonResponse['is_applied '];
        print('apply message $msg');
        print('success $success');
        print('apply $is_apply');
        if(success == 0){
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/error_lottie.json', formatApply(msg), refreshPage);
          
        }else{
          Navigator.pop(context);
          reusableloadingApply(context, 'assets/images/success_lottie.json', formatApply(msg),refreshPage);
          Utils.snakbarSuccess(context, msg);
          updateCardState();
        }
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e);
    } finally {
      setState(() {
        isLoading2 = false;
      });
    }
  }
  void refreshPage() {
  setState(() {
    fetchNotification();
  });
}

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/gradient_back.png',
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.02,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            reusableText('Notifications',
                color: colorController.blackColor, fontsize: 23, fontweight: FontWeight.bold),
            reusablaSizaBox(context, 0.030),
            Expanded(
              child: ListView.builder(
                itemCount: tuitions.length + 1,
                itemBuilder: (context, index) {
                  if (index < tuitions.length) {
                    var data = tuitions[index];
                    var remarks = data['remarks'];
                    var typee = data['type'];
                    var title = data['title'];
                    var datetime = data['datetime'];
                    var reference = data['reference'];
                    return Container(
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
                      decoration: BoxDecoration(
                        color: colorController.whiteColor,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: colorController.grayTextColor,
                            blurRadius: 4.0,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Image.asset(
                          'assets/images/not_img.png',
                          fit: BoxFit.contain,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText('$title',
                                color: colorController.blackColor, fontsize: 15),
                            reusablaSizaBox(context, 0.003),
                            reusableText('$remarks',
                                color: colorController.blackColor, fontsize: 13),
                            reusablaSizaBox(context, 0.007),
                          ],
                        ),
                        subtitle: reusableText(convertToRelativeTime(datetime),
                            color: colorController.blackColor, fontsize: 11),
                        trailing: SizedBox(width: MediaQuery.of(context).size.width * 0.1,
                        child: typee == '0'
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    refrence = reference;
                                  });
                                  print(tuitionData);
                                  getSingleTuitions(reference).then((value) {
                                    if(tuitionData.isEmpty){
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                        backgroundColor: colorController.whiteColor,
                                          content: Container(
                                                width: MediaQuery.of(context).size.width,
                                            height: MediaQuery.of(context).size.height * .2,
                                          child: Image.asset('assets/images/closed.png',fit: BoxFit.contain,)
                                              ),
                                              actions: [
                                                Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                InkWell(
                                                onTap: () {
                                                Navigator.pop(context);
                                                  },
                                                child: Image.asset(
                                                'assets/images/remove.png',
                                                  height: MediaQuery.of(context).size.height * .05,
                                                   width: MediaQuery.of(context).size.width * .1,
                                                ),
                                ),
          ],
        ),
        reusablaSizaBox(context, .01)
      ],
    ),
  );
                                    }else if(error == 1){
                                      reusableloadingApply(context, 'assets/images/error_lottie.json', error_msg, refreshPage);
                                    }
                                    
                                    else{
                                      print('online ${onlineTermsCheck}');
                                      reusabletutorDetails(
                                        context,
                                        formatInfo(remark),
                                        class_name,
                                        tuition_name,
                                        placment,
                                        job_closed,
                                        subject_name,
                                        share_date,
                                        location,
                                        limit_statement, () {
                                        if (g_id == '0') {
                                          if(onlineTermsCheck==1){
                                                      reusableMessagedialog(context, onlineHeading, formatInfo(onlineText), 'Agree', 'Disagree', (){
                                                        applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      }, (){Navigator.pop(context);});
                                                    }else{
                                                        // applyTuitions(() {
                                                        //   setState(() {
                                                        //     data['already'] = 1;
                                                        //   });
                                                        // });
                                                        if(MySharedPrefrence().get_gender() == 2){
                                                          reusableMessagedialog(context, 'Confirmation', "You will have to visit at Student's Place", 'Apply', 'Cancel', (){
                                                            applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      }, (){Navigator.pop(context);});
                                                        }else{
                                                          applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        }
                                                    }
                                      } else {
                                        reusableMessagedialog(
                                            context,
                                            'Classes',
                                            'Are you sure${repository.class_name}',
                                            'Confirm','Cancel', () {
                                          if(onlineTermsCheck==1){
                                                      reusableMessagedialog(context, onlineHeading, formatInfo(onlineText), 'Agree', 'Disagree', (){
                                                        applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      }, (){Navigator.pop(context);});
                                                    }else{
                                                        // applyTuitions(() {
                                                        //   setState(() {
                                                        //     data['already'] = 1;
                                                        //   });
                                                        // });
                                                        if(MySharedPrefrence().get_gender() == 2){
                                                          reusableMessagedialog(context, 'Confirmation', "You will have to visit at Student's Place", 'Apply', 'Cancel', (){
                                                            applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        Navigator.pop(context);
                                                      }, (){Navigator.pop(context);});
                                                        }else{
                                                          applyTuitions(() {
                                                          setState(() {
                                                            data['already'] = 1;
                                                          });
                                                        });
                                                        }
                                                    }
                                        }, () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    }, g_id, tuition_id, already,() {
                                                setState(() {
                                                  data['already'] = 1;
                                                });
                                              });
                                    }
                                    setState(() {});
                                  }
                                  );
                                },
                                child: Image.asset(
                                  'assets/images/view.png',
                                  fit: BoxFit.contain,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                ))
                            : Container(),
                        )
                      ),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .32,
                        vertical: MediaQuery.of(context).size.height * .03,
                      ),
                      child: isLoading
                          ? reusableloadingrow(context, isLoading)
                          : repository.showLoadMoreButton
                              ? reusableBtn(context, 'Load More', () {
                                  loadMoreNotification();
                                })
                              : Center(
                                  child: CircularProgressIndicator(
                                    color: colorController.btnColor,
                                  )),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
