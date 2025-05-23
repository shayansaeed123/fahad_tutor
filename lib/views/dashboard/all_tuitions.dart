
import 'dart:async';
import 'dart:convert';
import 'package:fahad_tutor/controller/color_controller.dart';
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
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/res/reusabletutordetails.dart';
import 'package:fahad_tutor/res/reusablevisibility.dart';
import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
import 'package:fahad_tutor/views/dashboard/notification.dart';
import 'package:fahad_tutor/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

// class AllTuitions extends StatefulWidget {
//   AllTuitions({Key? key,required this.isLoading2, 
//   // required this.fetchTuitions
//   }) : super(key: key);

//   final bool isLoading2;
//   // final List<dynamic> fetchTuitions;


//   @override
//   State<AllTuitions> createState() => _AllTuitionsState();
// }

// class _AllTuitionsState extends State<AllTuitions> {
//   final TextEditingController _searchCon = TextEditingController();
//   List<dynamic> tuitions = [];
//   bool isLoading = false;
//   bool visible = true;
//   bool showLoadMoreButton = false;
//   bool hasMoreData = true;
//   int start = 0;
//   final int limit = 10;
//   final ScrollController _scrollController = ScrollController();
//   Connectivity connectivity = Connectivity();

//   @override
//   void initState() {
//     super.initState();
//     fetchTuitions();
//     _scrollController.addListener(_scrollListener);
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels ==
//             _scrollController.position.maxScrollExtent &&
//         !isLoading) {
//       setState(() {
//         showLoadMoreButton = true;
//       });
//       start += limit;
//       setState(() {
//         showLoadMoreButton = true;
//       });
//     }
//   }

//   Future<void> fetchTuitions() async {
//     setState(() {
//       isLoading = true;
//       showLoadMoreButton = false;
//     });
//     try {
//       String url =
//           '${MySharedPrefrence().get_baseUrl()}tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=${limit}';
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         List<dynamic> newItems = responseData['tuition_listing'];
//         print('llllll $newItems');
//         setState(() {
//           tuitions.addAll(newItems);
//           print(tuitions);
          
//         });
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('No Data Found $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String formatInfo(String info) {
//     return info.replaceAll(';', '\n');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorController.whiteColor,
//       appBar: reusableappbar(context, colorController.yellowColor),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * .032),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   reusableText('All Tuitions',
//                       fontsize: 25,
//                       color: colorController.blackColor,
//                       fontweight: FontWeight.bold),
//                   reusableyoutubeIcon(context),
//                 ],
//               ),
//               reusablaSizaBox(context, .007),
//               Container(
//                 width: MediaQuery.of(context).size.width * 1,
//                 height: MediaQuery.of(context).size.height * .065,
//                 child: TextField(
//                   controller: _searchCon,
//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.grey[350],
//                     hintText: 'Search Tuitions',
//                     prefixIcon: Icon(
//                       Icons.search,
//                       color: Colors.grey[270],
//                     ),
//                     hintStyle: TextStyle(color: Colors.grey[250]),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none),
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15),
//                         borderSide: BorderSide.none),
//                     errorBorder: InputBorder.none,
//                     disabledBorder: InputBorder.none,
//                   ),
//                 ),
//               ),
//               reusablaSizaBox(context, .009),
//               reusableVisiblity(context, 'Apply carefully to maintain your profile', () {
//                 setState(() {
//                   visible = false;
//                 });
//               }, visible),
//               reusablaSizaBox(context, .025),
//               StreamBuilder(
//                 stream: connectivity.onConnectivityChanged,
//                 builder: (context, snapshot) {
//                   return checkConnection(
//                     snapshot,
//                    widget.isLoading2
//                 ? Center(child: reusableloadingrow(context, widget.isLoading2)):
//                     Expanded(
//                       child: ListView.builder(
//                         controller: _scrollController,
//                         itemCount: tuitions.length + 1,
//                         // widget.fetchTuitions.length + 1,
//                         itemBuilder: (context, index) {
//                           if (index < tuitions.length) {
//                             var data = tuitions[index];
//                             // if (index < widget.fetchTuitions.length) {
//                             //   print('widgetttttt ${widget.fetchTuitions}');
//                             // var data = widget.fetchTuitions[index];
                            
//                             MySharedPrefrence().setAllTuitions(data);
//                           //   String remarks = data['remarks'];
//                           //   String class_name = data['class_name'];
//                           //   String tuition_name = data['tuition_name'];
//                           //   String Placement = data['Placement'];
//                           //   int job = data['job_closed'];
//                           //   String subject = data['subject'];
//                           //   String share_date = data['share_date'];
//                           //   String location = data['location'];
//                           //   String limit = data['limit_statement'];
//                           //  MySharedPrefrence().set_share_date(data['share_date']);
//                           //   MySharedPrefrence().set_tuition_name(data['tuition_name']);
//                           //   MySharedPrefrence().set_class_name(data['class_name']);
//                           //   MySharedPrefrence().set_subject(data['subject']);
//                           //   MySharedPrefrence().set_Placement(data['Placement']);
//                           //   MySharedPrefrence().set_location(data['location']);
//                           //   MySharedPrefrence().set_limit(data['limit_statement']);
//                           //   MySharedPrefrence().set_remarks(data['remarks']);
//                           //   MySharedPrefrence().set_job(data['job_closed']);
//                             return Container(
//                               height: MediaQuery.of(context).size.height * 0.19,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     top: MediaQuery.of(context).size.height * 0.023,
//                                     left: MediaQuery.of(context).size.width * 0.001,
//                                     right: MediaQuery.of(context).size.width * .001,
//                                     child: InkWell(
//                                         onTap: () {
//                                           reusabletutorDetails(
//                                               context,formatInfo(data['remarks']),
//                                               data['class_name'],
//                                               data['tuition_name'],
//                                               data['Placement'],
//                                               data['job_closed'],
//                                               data['subject'],
//                                               data['share_date'],
//                                               data['location'],
//                                               data['limit_statement'],
//                                                   );
//                                         },
//                                         child: reusablecard(context,
//                                         data['tuition_name'],
//                                         data['class_name'],
//                                         data['share_date'],
//                                         data['location'],
//                                         data['subject']
//                                         )),
//                                   ),
//                                   Positioned(
//                                       left: MediaQuery.of(context).size.width * 0.45,
//                                       top: MediaQuery.of(context).size.height * 0.005,
//                                       right: MediaQuery.of(context).size.width * .27,
//                                       child: InkWell(
//                                           onTap: () {
//                                             reusabletutorDetails(
//                                                 context,formatInfo(data['remarks']),
//                                               data['class_name'],
//                                               data['tuition_name'],
//                                               data['Placement'],
//                                               data['job_closed'],
//                                               data['subject'],
//                                               data['share_date'],
//                                               data['location'],
//                                               data['limit_statement'],
//                                                 );
//                                           },
//                                           child: reusablecardbtn(
//                                               context,
//                                               '${data['Placement']}',
//                                               colorController.btnColor,
//                                               colorController.whiteColor))),
//                                   Positioned(
//                                       left: MediaQuery.of(context).size.width * 0.72,
//                                       top: MediaQuery.of(context).size.height * 0.005,
//                                       right: MediaQuery.of(context).size.width * .03,
//                                       child: InkWell(
//                                           onTap: () {
//                                             reusabletutorDetails(
//                                                 context,formatInfo(data['remarks']),
//                                               data['class_name'],
//                                               data['tuition_name'],
//                                               data['Placement'],
//                                               data['job_closed'],
//                                               data['subject'],
//                                               data['share_date'],
//                                               data['location'],
//                                               data['limit_statement'],
//                                                 );
//                                           },
//                                           child: reusablecardbtn(context, data['job_closed'] == 0 ? 'Open' : 'Closed', data['job_closed'] == 0 ? colorController.yellowColor : colorController.redColor, data['job_closed'] == 0 ? colorController.blackColor : colorController.whiteColor))),
//                                 ],
//                               ),
//                             );
//                           } else{
//                             return Padding(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: MediaQuery.of(context).size.width * .32,
//                                 vertical: MediaQuery.of(context).size.height * .03,
//                               ),
//                               child: isLoading ? 
//                               Center(child: CircularProgressIndicator(color: colorController.btnColor,)) :
//                                reusableBtn(context,  'Load More', () {
//                                 fetchTuitions();
//                               }),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class AllTuitions extends StatefulWidget {
  AllTuitions({Key? key,required this.isLoading2, 
  // required this.fetchTuitions
  }) : super(key: key);

  final bool isLoading2;
  // final List<dynamic> fetchTuitions;

  @override
  State<AllTuitions> createState() => _AllTuitionsState();
}

class _AllTuitionsState extends State<AllTuitions> {
  final TextEditingController _searchCon = TextEditingController();
  List<dynamic> tuitions = [];
  List<dynamic> filteredTuitions = [];
  bool isLoading = false;
  bool isLoading2 = false;
  bool visible = true;
  String g_id = '';
  String tuition_id = '';
  int success = 0;
  int is_apply = 0;
  String msg = '';
  int start = 0;
  final int limit = 10;
  final ScrollController _scrollController = ScrollController();
  Connectivity connectivity = Connectivity();
  TutorRepository repository = TutorRepository();
  String searchQuery = '';

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  String formatApply(String info) {
    return info.replaceAll(',', '\n');
  }

  @override
  void initState() {
    super.initState();
    fetchInitialTuitions();
    repository.documentsAttach();
    // searchTuitions(_searchCon.text.toString());
  }

  List<Tuition> searchResults = [];

  // Fetch search results based on input
  void searchTuitions(String query) async {
    setState(() {
        isLoading2 = true;
      });
      // Define the API URL
  final String apiUrl = "${MySharedPrefrence().get_baseUrl()}search_all_tuitions.php";
  
    final results = await repository.searchTuitions(query,apiUrl);
    setState(() {
      searchResults = results;
    });
    setState(() {
        isLoading2 = false;
      });
  }

  Future<void> fetchInitialTuitions() async {
    setState(() {
      isLoading2 = true;
    });
    await repository.allTuitions(start, limit);
    setState(() {
      tuitions = repository.allTuitionsList;
      filteredTuitions = tuitions;
    });
    setState(() {
      isLoading2 = false;
    });
  }

  // Future<void> searchTuitions(String searchText) async {
  //   String url =
  //         '${MySharedPrefrence().get_baseUrl()}search_all_tuitions.php?searchtext=$searchText&code=10&tutor_id=${MySharedPrefrence().get_user_ID()}';
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
    setState(() {
      searchQuery = query.toLowerCase();
      filteredTuitions = tuitions.where((item) {
        final className = item['class_name']?.toString().toLowerCase() ?? '';
        final subject = item['subject']?.toString().toLowerCase() ?? '';
        final location = item['location']?.toString().toLowerCase() ?? '';
        final tuitionName = item['tuition_name']?.toString().toLowerCase() ?? '';
        return className.contains(searchQuery) ||
            subject.contains(searchQuery) ||
            location.contains(searchQuery) ||
            tuitionName.contains(searchQuery);
      }).toList();
    });
  }

  Future<void> loadMoreTuitions() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.allTuitions(start, limit);
    setState(() {
      tuitions = repository.allTuitionsList;
      filteredTuitions = tuitions;
      isLoading = false;
    });
  }

  Future<void> applyTuitions(Function updateCardState) async {
    setState(() {
      isLoading2 = true;
    });

    try {
      String url =
          '${MySharedPrefrence().get_baseUrl()}apply_tuition.php?code=10&group_id=$g_id&tuition_id=$tuition_id&tutor_id=${MySharedPrefrence().get_user_ID()}';
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
  // setState(() {
  //   fetchInitialTuitions();
  // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: reusableappbar(context, colorController.yellowColor,()async{
        // await repository.Check_popup();
        Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(),));},repository.profile_image,(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
        }),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .032),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  reusableText('All Tuitions',
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
                      child: Icon(
                        Icons.search,
                        color: Colors.grey[270],
                      ),
                    ),
                    hintStyle: TextStyle(color: Colors.grey[250]),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none),
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  
                ),
              ),
               
          // Expanded(
          //   child: ListView.builder(
          //     itemCount: searchResults.length,
          //     itemBuilder: (context, index) {
          //       final tuition = searchResults[index];
          //       return ListTile(
          //         title: Text(tuition.tuitionName,style: TextStyle(color: Colors.black),),
          //         subtitle: Text('${tuition.className} - ${tuition.subject}'),
          //         trailing: Text(tuition.location),
          //       );
          //     },
          //   ),
          // ),
              reusablaSizaBox(context, .009),
              reusableVisiblityMesage(context, 'Apply carefully to maintain your profile', () {
                setState(() {
                  visible = false;
                });
              }, visible),
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
                   isLoading2 || widget.isLoading2
                ? Center(child: reusableloadingrow(context, isLoading2||widget.isLoading2)):
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: filteredTuitions.length + 1,
                        itemBuilder: (context, index) {
                          // MySharedPrefrence().setTuitions(tuitions);
                          if (index < filteredTuitions.length) {
                            var data = filteredTuitions[index];
                            MySharedPrefrence().setAllTuitions(data);
                            
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.23, //19 to 21
                              child: InkWell(
                                onTap: (){
                                  // repository.group_id();
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
                                      //       // repository.group_id();
                                      //       print('online check ${data['Online_terms_check']}');
                                      //       g_id = data['group_id'];
                                      //       tuition_id = data['tuition_id'];
                                      //       print('tuitions_id ${data['tuition_id']}');
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
                                      //               if(data['Online_terms_check']==1){
                                
                                      //               }else{
                                      //               applyTuitions(() {
                                      //             setState(() {
                                      //               data['already'] = 1;
                                      //             });
                                      //           });
                                      //               }
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
                                        //       print(repository.success);
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
                    // ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}





