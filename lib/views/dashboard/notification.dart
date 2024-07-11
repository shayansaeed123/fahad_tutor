// import 'dart:convert';

// import 'package:fahad_tutor/controller/color_controller.dart';
// import 'package:fahad_tutor/database/my_shared.dart';
// import 'package:fahad_tutor/repo/tutor_repo.dart';
// import 'package:fahad_tutor/repo/utils.dart';
// import 'package:fahad_tutor/res/reusableText.dart';
// import 'package:fahad_tutor/res/reusablebtn.dart';
// import 'package:fahad_tutor/res/reusableloading.dart';
// import 'package:fahad_tutor/res/reusablesizebox.dart';
// import 'package:fahad_tutor/res/reusabletutordetails.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;

// class Notifications extends StatefulWidget {
//   const Notifications({super.key});

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {

//   List<dynamic> tuitions = [];
//   bool isLoading = false;
//   bool isLoading2 = false;
//   bool visible = true;
//   int success = 0;
//   int is_apply = 0;
//   String msg = '';
//   int start = 0;
//   int limit = 10;
//   String refrence = '';
//   String tuition_id = '';
//   String tuition_name ='';
//   String class_name = '';
//   String subject_name = '';
//   String share_date = '';
//   String location = '';
//   String g_id = '';
//   String remark = '';
//   String placment = '';
//   String limit_statement = '';
//   int job_closed = 0;
//   int already = 0;
//   TutorRepository repository = TutorRepository();
//   @override
//   void initState() {
//     super.initState();
//     fetchNotification();
//   }  

//   Future<void> fetchNotification() async {
//     setState(() {
//       isLoading2 = true;
//     });
//     await repository.getNotification(start);
//     setState(() {
//       tuitions = repository.allNotificationList;
//     });
//     setState(() {
//       isLoading2 = false;
//     });
//   }

//   Future<void> loadMoreNotification() async {
//     setState(() {
//       isLoading = true;
//     });
//     start += limit;
//     await repository.getNotification(start);
//     setState(() {
//       tuitions = repository.allNotificationList;
//       isLoading = false;
//     });
//   }
//     Future<void> getSingleTuitions(String reference) async {
//     setState(() {
//       isLoading2 = true;
//     });

//     try {
//       String url =
//           '${Utils.baseUrl}mobile_app/single_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&tuition=$reference';
//       final response = await http.get(Uri.parse(url));
//       print('url $url');
//       print('refrence id $reference');

//       if (response.statusCode == 200) {
//         setState(() {isLoading2= false;});
//         dynamic jsonResponse = jsonDecode(response.body);
//         setState(() {});
//         var data = jsonResponse['tuition_listing'];
//         tuition_id = data[0]['tuition_id'];
//         tuition_name = data[0]['tuition_name'];
//         share_date = data[0]['share_date'];
//         location = data[0]['location'];
//         g_id = data[0]['group_id'];
//         remark = data[0]['remarks'];
//         placment = data[0]['Placement'];
//         class_name = data[0]['class_name'];
//         subject_name = data[0]['subject'];
//         limit_statement = data[0]['limit_statement'];
//         job_closed = data[0]['job_closed'];
//         already = data[0]['already'];
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception(e);
//     } finally {
//       setState(() {
//         isLoading2 = false;
//       });
//     }
//   }

//   String formatInfo(String info) {
//     return info.replaceAll(';', '\n');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//     backgroundColor: colorController.whiteColor,
//     appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
//     leading:  Padding(
//       padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
//       child: InkWell(
//         onTap: (){Navigator.pop(context);},
//         child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
//     ),),
//     body: Padding(
//       padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           reusableText('Notifications',color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
//           reusablaSizaBox(context, 0.030),
//           Expanded(
//             child: ListView.builder(
//               itemCount: tuitions.length + 1,
//               itemBuilder: (context, index) {
//                 if (index < tuitions.length) {
//                     var data = tuitions[index];
//                     var remarks = data['remarks'];
//                     var type = data['type'];
//                     var title = data['title'];
//                     var datetime = data['datetime'];
//                     var reference = data['reference'];
//                     return Container(
//                       margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
//                 padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .025),
//                 decoration: BoxDecoration(
//                   color: colorController.whiteColor,
//                   borderRadius: BorderRadius.circular(8.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: colorController.grayTextColor,blurRadius: 4.0,offset: Offset(0, 2),
//                       ),],),
//                 child: ListTile(
//                   leading: Image.asset('assets/images/not_img.png',fit: BoxFit.contain,),
//                   title: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
//                     reusableText('$title',color: colorController.blackColor,fontsize: 15),
//                     reusablaSizaBox(context, 0.003),
//                     reusableText('$remarks',color: colorController.blackColor,fontsize: 13),
//                     reusablaSizaBox(context, 0.007),
//                   ],),
//                   subtitle: reusableText('$datetime',color: colorController.blackColor,fontsize: 11),
//                   trailing: type == '0' ? InkWell(
//                     onTap: (){
//                        setState(() {
//                                     refrence = reference;
//                                   });
//                       getSingleTuitions(reference).then((value) {
//                         reusabletutorDetails(
//                                               context,formatInfo(remark),
//                                               class_name,
//                                               tuition_name,
//                                               placment,
//                                               job_closed,
//                                               subject_name,
//                                               share_date,
//                                               location,
//                                               limit_statement,(){
//                                                 if(g_id == '0'){
//                                                   // applyTuitions();
//                                                 }else{
//                                                   reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm', (){
//                                                     // applyTuitions();
//                                                   }, (){Navigator.pop(context);});
//                                                 }
//                                               },
//                                               g_id,
//                                               tuition_id,
//                                               already
//                                                   );
//                                                   setState(() {});
//                                                 // repository.group_id(g_id);
//                       });
                                          
//                     },
//                     child: Image.asset('assets/images/view.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.04,)) : Container(),
//                 ),
//               );
//                   }else{
//                     return Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: MediaQuery.of(context).size.width * .32,
//                                 vertical: MediaQuery.of(context).size.height * .03,
//                               ),
//                               child: isLoading
//                                   ? reusableloadingrow(context, isLoading)
//                                   : repository.showLoadMoreButton
//                                       ? reusableBtn(
//                                           context, 'Load More', () {
//                                           loadMoreNotification();
//                                         })
//                                       : Center(
//                                       child: CircularProgressIndicator(
//                                       color: colorController.btnColor,
//                                     )),
//                             );
//                   }
              
//             },),
//           )
//         ],
//       ),
//     )
//   );
//   }
// }

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
  TutorRepository repository = TutorRepository();

  @override
  void initState() {
    super.initState();
    fetchNotification();
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
          '${Utils.baseUrl}mobile_app/single_tuition.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&tuition=$reference';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('refrence id $reference');

      if (response.statusCode == 200) {
        dynamic jsonResponse = jsonDecode(response.body);
        var data = jsonResponse['tuition_listing'];
        if (data.isNotEmpty) {
          setState(() {
            tuition_id = data[0]['tuition_id'];
            tuition_name = data[0]['tuition_name'];
            share_date = data[0]['share_date'];
            location = data[0]['location'];
            g_id = data[0]['group_id'];
            remark = data[0]['remarks'];
            placment = data[0]['Placement'];
            class_name = data[0]['class_name'];
            subject_name = data[0]['subject'];
            limit_statement = data[0]['limit_statement'];
            job_closed = data[0]['job_closed'];
            already = data[0]['already'];
            isLoading2 = false;
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
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
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
                    var type = data['type'];
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
                        subtitle: reusableText('$datetime',
                            color: colorController.blackColor, fontsize: 11),
                        trailing: type == '0'
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    refrence = reference;
                                  });
                                  getSingleTuitions(reference).then((value) {
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
                                        // applyTuitions();
                                      } else {
                                        reusableMessagedialog(
                                            context,
                                            'Classes',
                                            'Are you sure${repository.class_name}',
                                            'Confirm', () {
                                          // applyTuitions();
                                        }, () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    }, g_id, tuition_id, already);
                                    setState(() {});
                                  });
                                },
                                child: Image.asset(
                                  'assets/images/view.png',
                                  fit: BoxFit.contain,
                                  height: MediaQuery.of(context).size.height * 0.04,
                                ))
                            : Container(),
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
