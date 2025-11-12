import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/model/searchmodel.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappbar.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablecard.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusablepopup.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
import 'package:fahad_tutor/views/dashboard/notification.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:in_app_review/in_app_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../login/login.dart';

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
  double rating = 0.0;
  String g_id = '';
  String tuition_id = '';
  String msg= '';
  final TextEditingController _searchCon = TextEditingController();
  Connectivity connectivity = Connectivity();
  final ScrollController _scrollController = ScrollController();
  TutorRepository repository = TutorRepository();
  List<dynamic> tuitions = [];
  List<dynamic> filteredTuitions = [];
  final InAppReview _inAppReview = InAppReview.instance;

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  String formatApply(String info) {
    return info.replaceAll(',', '\n');
  }

  String formatAttention(String info) {
    return info.replaceAll('<><>', '\n');
  }

  @override
  void initState() {
    super.initState();
    // fetchInitialTuitions();
    // repository.getBasepath();
    repository.get_Token();
    repository.documentsAttach();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAndCheckPopup();
    });
    
  }

  List<Tuition> searchResults = [];

  // Fetch search results based on input
  void searchTuitions(String query) async {
    setState(() {
        isLoading2 = true;
      });
  final String apiUrl = "${Utils.baseUrl}search_pereferred.php";
  
    final results = await repository.searchTuitions(query,apiUrl);
    setState(() {
      searchResults = results;
    });
    setState(() {
        isLoading2 = false;
      });
  }


  Future<void> _fetchAndCheckPopup() async {
    await fetchInitialTuitions();
    if (mounted) {
      _checkPreferredPopup();
    }
  }

  void _checkPreferredPopup() {
    if(repository.goto_play.value == 1){
      reusableNewUpdate(context,(){
        launch('https://play.google.com/store/apps/details?id=com.fahadtutors&hl=en_US');
      });
    }
    if (repository.preferred_popup.value == 1) {
      reusablepopup1(context,'${repository.preferred_popup_image.value}',);
    }
    if(repository.discount_popup.value == '1'){
      reusablepopup2(context, '${repository.discount_popup_image.value}',);
    }
    if(repository.attention_popup.value == 1){
      reusableAttention(context, repository.attention_popup_title.value, formatAttention(repository.attention_popup_text.value));
    }
    if(repository.account_check.value == 0){
      setState(() {
        reusableAutoLogout(context,(){
        MySharedPrefrence().logout();
        reusabletextfieldcontroller.loginPassCon.clear();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
      });
      });
    }
    print(repository.app_review.value);
    if(repository.app_review.value == 1){
      showReviewDialog(context,rating);
    }
  }

  Future<void> _openInAppReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
    } else {
      // Agar in-app review available nahi, to Play Store page open karega
      await _inAppReview.openStoreListing(
        appStoreId: 'YOUR_APP_STORE_ID', // only for iOS
        microsoftStoreId: null,
      );
    }
  }

  Future<void> fetchInitialTuitions() async {
    setState(() {
      isLoading2 = true;
    });
    await repository.prefferedTuitions(start, limit);
    setState(() {
      tuitions = repository.prefferedTuitionsList;
      filteredTuitions = tuitions;
    });
    setState(() {
      isLoading2 = false;
    });
  }
  // Future<void> searchTuitions(String searchText) async {
  //   String url =
  //         '${Utils.baseUrl}search_pereferred.php?searchtext=$searchText&code=10&tutor_id=${MySharedPrefrence().get_user_ID()}';
  //     final response = await http.get(Uri.parse(url));

  //   if (response.statusCode == 200) {
  //     final jsonResponse = jsonDecode(response.body);
  //     setState(() {
  //       tuitions = jsonResponse['tuition_listing'];
  //       filteredTuitions = tuitions;
  //     }); // Assuming the JSON contains a key 'tuition_listing'
  //   } else {
  //     throw Exception('Failed to load tuitions');
  //   }
  // }

  void filterTuitions(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredTuitions = tuitions;
      });
    } else {
      setState(() {
        filteredTuitions = tuitions.where((item) {
          return item['class_name'].toLowerCase().contains(query.toLowerCase()) ||
                 item['subject'].toLowerCase().contains(query.toLowerCase()) ||
                 item['location'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  Future<void> loadMoreTuitions() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.prefferedTuitions(start, limit);
    setState(() {
      tuitions = repository.prefferedTuitionsList;
      filteredTuitions = tuitions;
      isLoading = false;
    });
  }

  Future<void> applyTuitions(Function updateCardState) async {
    
    try {
      String url =
          '${Utils.baseUrl}apply_tuition.php?code=10&group_id=$g_id&tuition_id=$tuition_id&tutor_id=${MySharedPrefrence().get_user_ID()}';
      final response = await http.get(Uri.parse(url));
      print('url $url');
      print('group id $g_id');
      print('tuition id $tuition_id');

      if (response.statusCode == 200) {
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
        // isLoading2 = false;
      });
    }
  }
  void refreshPage() {
  // setState(() {
  //   fetchInitialTuitions();
  // });
}

  @override
Widget build(BuildContext context) {
  return WillPopScope(
    onWillPop: repository.onWillPop,
    child: Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: reusableappbar(context, colorController.yellowColor,()async{
        // await repository.Check_popup();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));},repository.profile_image,(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
        }),
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
                      reusableText('Preferred Tuitions',
                          fontsize: 22.5,
                          color: colorController.blackColor,
                          fontweight: FontWeight.bold),
                      reusableyoutubeIcon(context),
                    ],
                  ),
                  reusablaSizaBox(context, .007),
                  Container(
                    width: MediaQuery.of(context).size.width * 1,
                    // height: MediaQuery.of(context).size.height * .065,
                    child: TextField(
                      controller: _searchCon,
                      onChanged: (value) {
                     searchTuitions(value);
                    },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0.0),
                        filled: true,
                        fillColor: Colors.grey[350],
                        hintText: 'Search Tuitions',
                        prefixIcon: InkWell(
                          onTap: (){
                            // filterTuitions(_searchCon.text);
                            },
                          child: Icon(Icons.search, color: Colors.grey[270],)),
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
                        reusableVisiblityMesage(context, 'Apply carefully to maintain your profile', (){
                          setState(() {});
                          visible = false;},visible),
                          reusablaSizaBox(context, .025),
                          _searchCon.text.isNotEmpty ?
                StreamBuilder(
                  stream: connectivity.onConnectivityChanged,
                  builder: (context, snapshot) {
                    // Check connectivity status
            bool isConnected = snapshot.data != ConnectivityResult.none;
            
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: reusableloadingrow(context, isLoading));
            // }
    
            if (!isConnected) {
              return Center(
                child: Image.asset('assets/images/no_internet.jpg',fit: BoxFit.cover,filterQuality: FilterQuality.high,)
              );
            }
                    return 
                    // checkConnection(
                    //   snapshot,
                     isLoading2 || widget.isLoading2
                  ? Center(child: reusableloadingrow(context, isLoading2||widget.isLoading2)):
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            final searchTuition = searchResults[index]; 
                            // if (index < filteredTuitions.length) {
                            //   var data = filteredTuitions[index];
                            //   MySharedPrefrence().setAllTuitions(data);
                              
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.23, //19 to 21
                                child: InkWell(
                                  onTap: (){
                                    // repository.group_id();
                                              print('online check ${searchTuition.onlineTermsCheck}');
                                              print('online check headng ${searchTuition.onlineTermsCheckHeading}');
                                              print('online check text  ${searchTuition.onlineTermsCheckText}');
                                              g_id = searchTuition.groupId;
                                              tuition_id = searchTuition.tuitionId;
                                              print('tuitions_id ${searchTuition.tuitionId}');
                                              reusabletutorDetails(
                                                  context,formatInfo(searchTuition.remarks),
                                                  searchTuition.className,
                                                  searchTuition.tuitionName,
                                                  searchTuition.placement,
                                                  searchTuition.jobClosed,
                                                  searchTuition.subject,
                                                  searchTuition.shareDate,
                                                  searchTuition.location,
                                                  searchTuition.limitStatement,(){
                                                    if(searchTuition.groupId == '0'){
                                                      if(searchTuition.onlineTermsCheck==1){
                                                        reusableMessagedialog(context, searchTuition.onlineTermsCheckHeading, formatInfo(searchTuition.onlineTermsCheckText), 'Agree', 'Disagree', (){
                                                          applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          Navigator.pop(context);
                                                        }, (){Navigator.pop(context);});
                                                      }else{
                                                          // applyTuitions(() {
                                                          //   setState(() {
                                                          //     searchTuition.already == 1;
                                                          //   });
                                                          // });
                                                          if(MySharedPrefrence().get_gender() == 2){
                                                            reusableMessagedialog(context, 'Confirmation', "You will have to visit at Student's Place", 'Apply', 'Cancel', (){
                                                              applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          Navigator.pop(context);
                                                        }, (){Navigator.pop(context);});
                                                          }else{
                                                            applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          }
                                                      }
                                                    }else{
                                                      reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm','Cancel', (){
                                                        if(searchTuition.onlineTermsCheck==1){
                                                        reusableMessagedialog(context, searchTuition.onlineTermsCheckHeading, formatInfo(searchTuition.onlineTermsCheckText), 'Agree', 'Disagree', (){
                                                          applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          Navigator.pop(context);
                                                        }, (){Navigator.pop(context);});
                                                      }else{
                                                          // applyTuitions(() {
                                                          //   setState(() {
                                                          //     searchTuition.already == 1;
                                                          //   });
                                                          // });
                                                          if(MySharedPrefrence().get_gender() == 2){
                                                            reusableMessagedialog(context, 'Confirmation', "You will have to visit at Student's Place", 'Apply', 'Cancel', (){
                                                              applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          Navigator.pop(context);
                                                        }, (){Navigator.pop(context);});
                                                          }else{
                                                            applyTuitions(() {
                                                            setState(() {
                                                              searchTuition.already == 1;
                                                            });
                                                          });
                                                          }
                                                      }
                                                      }, (){Navigator.pop(context);});
                                                    }
                                                  },
                                                  searchTuition.groupId,
                                                  searchTuition.tuitionId,
                                                  searchTuition.already,() {
                                                    setState(() {
                                                      searchTuition.already == 1;
                                                    });
                                                  }
                                                      );
                                                      setState(() {});
                                                    print('groupppppppppppppppppppppppppp ${searchTuition.groupId}');
                                                    repository.group_id(searchTuition.groupId);
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.023,
                                        left: MediaQuery.of(context).size.width * 0.001,
                                        right: MediaQuery.of(context).size.width * .001,
                                        
                                            child: reusablecard(context,
                                            searchTuition.tuitionName,
                                           searchTuition.className,
                                            searchTuition.shareDate,
                                            searchTuition.location,
                                            searchTuition.subject,
                                            searchTuition.already,
                                            )),
                                      // ),
                                      Positioned(
                                          left: MediaQuery.of(context).size.width * 0.45,
                                          top: MediaQuery.of(context).size.height * 0.005,
                                          right: MediaQuery.of(context).size.width * .27,
                                          
                                              child: reusablecardbtn(
                                                  context,
                                                  '${searchTuition.placement}',
                                                  colorController.btnColor,
                                                  colorController.whiteColor)),
                                                  // ),
                                      Positioned(
                                          left: MediaQuery.of(context).size.width * 0.72,
                                          top: MediaQuery.of(context).size.height * 0.005,
                                          right: MediaQuery.of(context).size.width * .03,
                                              child: reusablecardbtn(context, searchTuition.jobClosed == 0 ? 'Open' : 'Closed', searchTuition.jobClosed == 0 ? colorController.yellowColor : colorController.redColor, searchTuition.jobClosed == 0 ? colorController.blackColor : colorController.whiteColor))
                                    ],
                                  ),
                                ),
                              );
                          },
                        ),
                    );
                  },
                ):
                          StreamBuilder(
                  stream: connectivity.onConnectivityChanged,
                  builder: (context, snapshot) {
                     // Check connectivity status
            bool isConnected = snapshot.data != ConnectivityResult.none;
            
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return Center(child: reusableloadingrow(context, isLoading));
            // }
    
            if (!isConnected) {
              return Center(
                child: Image.asset('assets/images/no_internet.jpg',fit: BoxFit.cover,filterQuality: FilterQuality.high,)
              );
            }
    
                    return 
                    // checkConnection(
                    //   snapshot,
                     widget.isLoading2 || isLoading2
                  ? Center(child: reusableloadingrow(context, widget.isLoading2||isLoading2)):
                      Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: filteredTuitions.length + 1,
                          itemBuilder: (context, index) {
                            if (index < filteredTuitions.length) {
                              var data = filteredTuitions[index];
                              MySharedPrefrence().setAllTuitions(data);
                              return Container(
                                height: MediaQuery.of(context).size.height * 0.23, //19 to 23
                                child: InkWell(
                                  onTap: (){
                                              print('online check ${data['Online_terms_check']}');
                                              print('online check headng ${data['Online_terms_check_heading']}');
                                              print('online check text  ${data['Online_terms_check_text']}');
                                              g_id = data['group_id'];
                                              tuition_id = data['tuition_id'];
                                              print('tuitions_id ${data['tuition_id']}');
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
                                                      if(data['Online_terms_check']==1){
                                                        reusableMessagedialog(context, data['Online_terms_check_heading'], formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
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
                                                    }else{
                                                      reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm','Cancel', (){
                                                        if(data['Online_terms_check']==1){
                                                        reusableMessagedialog(context, data['Online_terms_check_heading'], formatInfo(data['Online_terms_check_text']), 'Agree', 'Disagree', (){
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
                                                      }, (){Navigator.pop(context);});
                                                    }
                                                  },
                                                  data['group_id'],
                                                  data['tuition_id'],
                                                  data['already'],() {
                                                    setState(() {
                                                      data['already'] = 1;
                                                    });
                                                  }
                                                      );
                                                      setState(() {});
                                                    print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                                    repository.group_id(data['group_id']);
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: MediaQuery.of(context).size.height * 0.023,
                                        left: MediaQuery.of(context).size.width * 0.001,
                                        right: MediaQuery.of(context).size.width * .001,
                                        // child: InkWell(
                                        //     onTap: () {
                                        //       g_id = data['group_id'];
                                        //       tuition_id = data['tuition_id'];
                                        //       print('Preferred tuition id: ${data['tuition_id']}');
                                        //       reusabletutorDetails(
                                        //           context,formatInfo(data['remarks']),
                                        //           data['class_name'],
                                        //           data['tuition_name'],
                                        //           data['Placement'],
                                        //           data['job_closed'],
                                        //           data['subject'],
                                        //           data['share_date'],
                                        //           data['location'],
                                        //           data['limit_statement'],(){
                                        //             if(data['group_id'] == '0'){
                                        //               applyTuitions(() {
                                        //             setState(() {
                                        //               data['already'] = 1;
                                        //             });
                                        //           });
                                        //             }else{
                                        //               reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm','Cancel', (){
                                        //                 applyTuitions(() {
                                        //             setState(() {
                                        //               data['already'] = 1;
                                        //             });
                                        //           });
                                        //               }, (){Navigator.pop(context);});
                                        //             }
                                        //           },
                                        //           data['group_id'],
                                        //           data['tuition_id'],
                                        //           data['already'],() {
                                        //             setState(() {
                                        //               data['already'] = 1;
                                        //             });
                                        //           }
                                        //               );
                                        //               setState(() {});
                                        //             print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                        //             repository.group_id(data['group_id']);
                                        //     },
                                            child: reusablecard(context,
                                            data['tuition_name'],
                                            data['class_name'],
                                            data['share_date'],
                                            data['location'],
                                            data['subject'],
                                            data['already'],
                                            )),
                                      // ),
                                      Positioned(
                                          left: MediaQuery.of(context).size.width * 0.45,
                                          top: MediaQuery.of(context).size.height * 0.005,
                                          right: MediaQuery.of(context).size.width * .27,
                                          // child: InkWell(
                                          //     onTap: () {
                                          //       reusabletutorDetails(
                                          //           context,formatInfo(data['remarks']),
                                          //         data['class_name'],
                                          //         data['tuition_name'],
                                          //         data['Placement'],
                                          //         data['job_closed'],
                                          //         data['subject'],
                                          //         data['share_date'],
                                          //         data['location'],
                                          //         data['limit_statement'],(){
                                          //           if(data['group_id'] == '0'){
                                          //             applyTuitions(() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         });
                                          //           }else{
                                          //             reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm','Cancel', (){
                                          //               applyTuitions(() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         });
                                          //             }, (){Navigator.pop(context);});
                                          //           }
                                          //         },
                                          //         data['group_id'],
                                          //         data['tuition_id'],
                                          //         data['already'],() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         }
                                          //           );
                                          //           setState(() {});
                                          //           print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                          //           repository.group_id(data['group_id']);
                                          //     },
                                              child: reusablecardbtn(
                                                  context,
                                                  '${data['Placement']}',
                                                  colorController.btnColor,
                                                  colorController.whiteColor)),
                                                  // ),
                                      Positioned(
                                          left: MediaQuery.of(context).size.width * 0.72,
                                          top: MediaQuery.of(context).size.height * 0.005,
                                          right: MediaQuery.of(context).size.width * .03,
                                          // child: InkWell(
                                          //     onTap: () {
                                          //       reusabletutorDetails(
                                          //           context,formatInfo(data['remarks']),
                                          //         data['class_name'],
                                          //         data['tuition_name'],
                                          //         data['Placement'],
                                          //         data['job_closed'],
                                          //         data['subject'],
                                          //         data['share_date'],
                                          //         data['location'],
                                          //         data['limit_statement'],(){
                                          //           if(data['group_id'] == '0'){
                                          //             applyTuitions(() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         });
                                          //           }else{
                                          //             reusableMessagedialog(context, 'Classes', 'Are you sure${ repository.class_name}', 'Confirm','Cancel', (){
                                          //               applyTuitions(() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         });
                                          //             }, (){Navigator.pop(context);});
                                          //           }
                                          //         },
                                          //         data['group_id'],
                                          //         data['tuition_id'],
                                          //         data['already'],() {
                                          //           setState(() {
                                          //             data['already'] = 1;
                                          //           });
                                          //         }
                                          //           );
                                          //           setState(() {});
                                          //           print('groupppppppppppppppppppppppppp ${data['group_id']}');
                                          //           repository.group_id(data['group_id']);
                                          //     },
                                              child: reusablecardbtn(context, data['job_closed'] == 0 ? 'Open' : 'Closed', data['job_closed'] == 0 ? colorController.yellowColor : colorController.redColor, data['job_closed'] == 0 ? colorController.blackColor : colorController.whiteColor))
                                              // ),
                                    ],
                                  ),
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
                      );
                //     );
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
    ),
  );
}

  }
// }