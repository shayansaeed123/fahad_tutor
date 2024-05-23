


// // import 'dart:async';
// // import 'dart:convert';

// // import 'package:fahad_tutor/controller/color_controller.dart';
// // import 'package:fahad_tutor/database/MySharedPrefrence.dart';
// // import 'package:fahad_tutor/repo/utils.dart';
// // import 'package:fahad_tutor/res/reusableText.dart';
// // import 'package:fahad_tutor/res/reusableappbar.dart';
// // import 'package:fahad_tutor/res/reusablebtn.dart';
// // import 'package:fahad_tutor/res/reusablecard.dart';
// // import 'package:fahad_tutor/res/reusablecardbtn.dart';
// // import 'package:fahad_tutor/res/reusablesizebox.dart';
// // import 'package:fahad_tutor/res/reusabletutordetails.dart';
// // import 'package:fahad_tutor/res/reusablevisibility.dart';
// // import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// // import 'package:http/http.dart' as http;

// // class AllTuitions extends StatefulWidget {
// //   AllTuitions({super.key, 
// //   // required this.allTuitions
// //   });
// //   // Future<Map<String, dynamic>>? allTuitions;

// //   @override
// //   State<AllTuitions> createState() => _AllTuitionsState();
// // }

// // class _AllTuitionsState extends State<AllTuitions> {
// //   final TextEditingController _searchCon = TextEditingController();
// //   List<dynamic> tuitions = [];
// //   bool isLoading = false;
// //   bool visible = true;
// //   bool hasMoreData = true;
// //   int start = 0;
// //   final int limit = 10;
// //   Future<List<dynamic>>? _futureTuitions;
// //   ScrollController _scrollController = ScrollController();
// //   Color _color = colorController.yellowColor; // Initial color
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     _futureTuitions = allTuitions();
// //     _scrollController.addListener(_scrollListener);
    
// //   }

// //   Future<void> _scrollListener()async{
// //     // if (hasMoreData) return;
// //     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) { 
// //       setState(() {
// //         hasMoreData = true;
// //       });
// //       start = start + 10;
// //         await allTuitions();
// //       setState(() {
// //         hasMoreData = true;
// //       });
// //           print('Scroll Call');
// //       }
// //   }


// //   Future<List<dynamic>> allTuitions()async{
// //     setState(() {
// //       isLoading = true;
// //     });
// //     try {
// //     String url = '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=10';
// //     final response = await http.get(
// //       Uri.parse(url),
// //     );
// //     print(url);
// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> responseData = json.decode(response.body);
// //       // List data = responseData['tuitions_listing'];
// //       print('All Tuitions $responseData');
// //       List<dynamic> item = responseData['tuition_listing'];
// //       setState(() {});
// //       tuitions = tuitions + item;
// //       print('list tuitions $tuitions');
// //       return tuitions;
// //     } else {
// //       print('Error2: ' + response.statusCode.toString());
// //       return [];
// //     }
// //   } catch (e) {
// //     print('No Data Found $e');
// //     throw Exception('No Data Found $e');
// //   } finally {
// //     setState(() {
// //       isLoading = false;
// //     });
// //   }
// //   }
// //   // void loadMoreTuitions() {
// //   //   if (!isLoading) {
// //       // setState(() {
// //       //   start += limit;
// //       // });
// //   //     allTuitions();
// //   //   }
// //   // }

// //   String formatInfo(String info) {
// //     return info.replaceAll(';', '\n');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: colorController.whiteColor,
// //       appBar: reusableappbar(context,_color),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: EdgeInsets.symmetric(
// //             horizontal: MediaQuery.of(context).size.width * .032),
// //           child: Column(children: [
// //             // reusablaSizaBox(context, .01),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 reusableText('All Tuitions',fontsize: 25,color: colorController.blackColor, fontweight: FontWeight.bold),
// //                 reusableyoutubeIcon(context),
// //               ],
// //             ),
// //             reusablaSizaBox(context, .007),
// //             Container(
// //               width: MediaQuery.of(context).size.width * 1,
// //               height: MediaQuery.of(context).size.height * .065,
// //               child: TextField(
// //                     controller: _searchCon,
// //                     keyboardType: TextInputType.text,
// //                     decoration: InputDecoration(
// //                       filled: true,
// //                       fillColor: Colors.grey[350],
// //                       hintText: 'Search Tuitions',
// //                       prefixIcon: Icon(Icons.search,color: Colors.grey[270],),
// //                       // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
// //                       hintStyle: TextStyle(color: Colors.grey[250]),
// //                       border: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               borderSide: BorderSide.none
// //                   ),
// //                       enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               borderSide: BorderSide.none
// //               // borderSide: BorderSide(
// //               //     color: colorController.textfieldBorderColorBefore, width: 1.5)
// //                   ),
// //                       focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(15),
// //               borderSide: BorderSide.none
// //               // borderSide: BorderSide(
// //               //     color: colorController.grayTextColor, width: 1.5)
// //                   ),
// //                       errorBorder: InputBorder.none,
// //                       disabledBorder: InputBorder.none,
// //                       // contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
// //                     ),
// //                   ),
// //             ),
// //             reusablaSizaBox(context, .009),
// //             reusableVisiblity(context, 'Apply carefully to maintain your profile', (){
// //               setState(() {});
// //               visible = false;},visible),
// //             reusablaSizaBox(context, .025),
// //             // ElevatedButton(onPressed: (){
// //             //   allTuitions();
// //             // }, child: Text('data')),
// //             Expanded(
        //       child: FutureBuilder<List<dynamic>>(
        // future: _futureTuitions,
        // builder: (context, snapshot) {
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   } else if (snapshot.hasError) {
        //     return Center(
        //       child: Text('Error: ${snapshot.error}'),
        //     );
        //   } else if (snapshot.hasData) {
        //     // var tuitions = snapshot.data!['tuition_listing'];
        //     var tuitions = snapshot.data!;
        //     if (tuitions.isEmpty) {
        //       return Center(
        //         child: Text('No Tuitions Found'),
        //       );
        //     }
        //     return ListView.builder(
// //               controller: _scrollController,
// //               itemCount: hasMoreData ? tuitions.length + 1 : tuitions.length,
// //               itemBuilder: (context, index) {
               
                
// //                 if(index < tuitions.length){
// //                    var data = tuitions[index];
// //                 MySharedPrefrence().set_share_date(data['share_date']);
// //                 MySharedPrefrence().set_tuition_name(data['tuition_name']);
// //                 MySharedPrefrence().set_class_name(data['class_name']);
// //                 MySharedPrefrence().set_subject(data['subject']);
// //                 MySharedPrefrence().set_Placement(data['Placement']);
// //                 MySharedPrefrence().set_location(data['location']);
// //                 MySharedPrefrence().set_limit(data['limit_statement']);
// //                 MySharedPrefrence().set_remarks(data['remarks']);
// //                   return Container(
// //                   height: MediaQuery.of(context).size.height * 0.19,
// //                   child: Stack(
// //                             children: [
// //                               Positioned(
// //                                 top: MediaQuery.of(context).size.height * 0.023,
// //                                 left: MediaQuery.of(context).size.width * 0.001,
// //                                                 right: MediaQuery.of(context).size.width * .001,
// //                                 child: InkWell(
// //                                   onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
// //                                   child: reusablecard(context)),
// //                                 ),
// //                                 Positioned(
// //                                                 left: MediaQuery.of(context).size.width * 0.45,
// //                                                 top: MediaQuery.of(context).size.height * 0.005,
// //                                                 right: MediaQuery.of(context).size.width * .27,
// //                                                 child: InkWell(
// //                                                   onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
// //                                                   child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor))),
// //                                                 Positioned(
// //                                                 left: MediaQuery.of(context).size.width * 0.72,
// //                                                 top: MediaQuery.of(context).size.height * 0.005,
// //                                                 right: MediaQuery.of(context).size.width * .03,
// //                                                 child: InkWell(
// //                                                   onTap: (){reusabletutorDetails(context,formatInfo(MySharedPrefrence().get_remarks()));},
// //                                                   child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor))),
// //                             ],
// //                                                     // );
// //                                                     // },
// //                                                     ),
// //                 );
// //                 }
// //                 else{
                  // return Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .32,
                  //   vertical: MediaQuery.of(context).size.height * .03
                  //   ),
                  //   child: Center(child: CircularProgressIndicator()),
                  //   // reusableBtn(context, 'Load More', (){
                  //   //   // loadMoreTuitions();
                  //   // }),
                  // );
//                 }
//               },
//             );
//           } else {
//             return Center(
//               child: Text('No Tuitions Found'),
//             );
//           }
//         },
//       ),
//             ),
//             // reusablecard(context),
//           ],),
//         ),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'dart:convert';
// import 'package:fahad_tutor/controller/color_controller.dart';
// import 'package:fahad_tutor/database/MySharedPrefrence.dart';
// import 'package:fahad_tutor/repo/utils.dart';
// import 'package:fahad_tutor/res/reusableText.dart';
// import 'package:fahad_tutor/res/reusableappbar.dart';
// import 'package:fahad_tutor/res/reusablebtn.dart';
// import 'package:fahad_tutor/res/reusablecard.dart';
// import 'package:fahad_tutor/res/reusablecardbtn.dart';
// import 'package:fahad_tutor/res/reusablesizebox.dart';
// import 'package:fahad_tutor/res/reusabletutordetails.dart';
// import 'package:fahad_tutor/res/reusablevisibility.dart';
// import 'package:fahad_tutor/res/reusableyoutubeIcon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AllTuitions extends StatefulWidget {
//   AllTuitions({super.key});
  
//   @override
//   State<AllTuitions> createState() => _AllTuitionsState();
// }

// class _AllTuitionsState extends State<AllTuitions> {
//   final TextEditingController _searchCon = TextEditingController();
//   List<dynamic> tuitions = [];
//   bool isLoading = false;
//   bool visible = true;
//   bool hasMoreData = true;
//   int start = 0;
//   final int limit = 10;
//   ScrollController _scrollController = ScrollController();
//   Color _color = colorController.yellowColor;

//   @override
//   void initState() {
//     super.initState();
//     fetchTuitions();
//     _scrollController.addListener(_scrollListener);
//   }

//   Future<void> fetchTuitions() async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       String url = '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=10';
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         List<dynamic> newItems = responseData['tuition_listing'];
//         setState(() {
//           tuitions.addAll(newItems);
//           hasMoreData = newItems.length == limit;
//         });
//       } else {
//         print('Error: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('No Data Found: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   void _scrollListener() {
//     if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && hasMoreData && !isLoading) {
//       start += limit;
//       fetchTuitions();
//     }
//   }

//   String formatInfo(String info) {
//     return info.replaceAll(';', '\n');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorController.whiteColor,
//       appBar: reusableappbar(context, _color),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   reusableText('All Tuitions', fontsize: 25, color: colorController.blackColor, fontweight: FontWeight.bold),
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
//                     prefixIcon: Icon(Icons.search, color: Colors.grey[270]),
//                     hintStyle: TextStyle(color: Colors.grey[250]),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(15),
//                       borderSide: BorderSide.none,
//                     ),
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
//               Expanded(
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   itemCount: tuitions.length + (hasMoreData ? 1 : 0),
//                   itemBuilder: (context, index) {
//                     if (index < tuitions.length) {
//                       var data = tuitions[index];
//                       MySharedPrefrence().set_share_date(data['share_date']);
//                       MySharedPrefrence().set_tuition_name(data['tuition_name']);
//                       MySharedPrefrence().set_class_name(data['class_name']);
//                       MySharedPrefrence().set_subject(data['subject']);
//                       MySharedPrefrence().set_Placement(data['Placement']);
//                       MySharedPrefrence().set_location(data['location']);
//                       MySharedPrefrence().set_limit(data['limit_statement']);
//                       MySharedPrefrence().set_remarks(data['remarks']);
//                       return Container(
//                         height: MediaQuery.of(context).size.height * 0.19,
//                         child: Stack(
//                           children: [
//                             Positioned(
//                               top: MediaQuery.of(context).size.height * 0.023,
//                               left: MediaQuery.of(context).size.width * 0.001,
//                               right: MediaQuery.of(context).size.width * .001,
//                               child: InkWell(
//                                 onTap: () {
//                                   reusabletutorDetails(context, formatInfo(MySharedPrefrence().get_remarks()));
//                                 },
//                                 child: reusablecard(context),
//                               ),
//                             ),
//                             Positioned(
//                               left: MediaQuery.of(context).size.width * 0.45,
//                               top: MediaQuery.of(context).size.height * 0.005,
//                               right: MediaQuery.of(context).size.width * .27,
//                               child: InkWell(
//                                 onTap: () {
//                                   reusabletutorDetails(context, formatInfo(MySharedPrefrence().get_remarks()));
//                                 },
//                                 child: reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor),
//                               ),
//                             ),
//                             Positioned(
//                               left: MediaQuery.of(context).size.width * 0.72,
//                               top: MediaQuery.of(context).size.height * 0.005,
//                               right: MediaQuery.of(context).size.width * .03,
//                               child: InkWell(
//                                 onTap: () {
//                                   reusabletutorDetails(context, formatInfo(MySharedPrefrence().get_remarks()));
//                                 },
//                                 child: reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       return Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(vertical: 16.0),
//                           child: CircularProgressIndicator(),
//                         ),
//                       );
//                     }
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/MySharedPrefrence.dart';
import 'package:fahad_tutor/repo/check_connectivity.dart';
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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class AllTuitions extends StatefulWidget {
  AllTuitions({Key? key}) : super(key: key);

  @override
  State<AllTuitions> createState() => _AllTuitionsState();
}

class _AllTuitionsState extends State<AllTuitions> {
  final TextEditingController _searchCon = TextEditingController();
  List<dynamic> tuitions = [];
  bool isLoading = false;
  bool visible = true;
  bool showLoadMoreButton = false;
  bool hasMoreData = true;
  int start = 1;
  final int limit = 10;
  final ScrollController _scrollController = ScrollController();
  final Color _color = colorController.yellowColor; // Initial color
  Connectivity connectivity = Connectivity();

  @override
  void initState() {
    super.initState();
    fetchTuitions();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isLoading) {
      setState(() {
        showLoadMoreButton = true;
      });
      start += limit;
      setState(() {
        showLoadMoreButton = true;
      });
    }
  }

  Future<void> fetchTuitions() async {
    // if (isLoading || !hasMoreData) return;
    setState(() {
      isLoading = true;
      showLoadMoreButton = false;
    });
    try {
      String url =
          '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=${limit}';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> newItems = responseData['tuition_listing'];
        setState(() {
          // if (newItems.length < limit) {
          //   hasMoreData = false;
          // }
          tuitions.addAll(newItems);
          
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('No Data Found $e');
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
      appBar: reusableappbar(context, _color),
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
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[270],
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
              reusablaSizaBox(context, .009),
              reusableVisiblity(context, 'Apply carefully to maintain your profile', () {
                setState(() {
                  visible = false;
                });
              }, visible),
              reusablaSizaBox(context, .025),
              StreamBuilder(
                stream: connectivity.onConnectivityChanged,
                builder: (context, snapshot) {
                  return checkConnection(
                    snapshot,
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: tuitions.length + 1,
                        itemBuilder: (context, index) {
                          if (index < tuitions.length) {
                            var data = tuitions[index];
                            MySharedPrefrence().set_share_date(data['share_date']);
                            MySharedPrefrence().set_tuition_name(data['tuition_name']);
                            MySharedPrefrence().set_class_name(data['class_name']);
                            MySharedPrefrence().set_subject(data['subject']);
                            MySharedPrefrence().set_Placement(data['Placement']);
                            MySharedPrefrence().set_location(data['location']);
                            MySharedPrefrence().set_limit(data['limit_statement']);
                            MySharedPrefrence().set_remarks(data['remarks']);
                            MySharedPrefrence().set_job(data['job_closed']);
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
                                              context,
                                              formatInfo(MySharedPrefrence()
                                                  .get_remarks()));
                                        },
                                        child: reusablecard(context)),
                                  ),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width * 0.45,
                                      top: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.width * .27,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                                context,
                                                formatInfo(MySharedPrefrence()
                                                    .get_remarks()));
                                          },
                                          child: reusablecardbtn(
                                              context,
                                              '${MySharedPrefrence().get_Placement()}',
                                              colorController.btnColor,
                                              colorController.whiteColor))),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width * 0.72,
                                      top: MediaQuery.of(context).size.height * 0.005,
                                      right: MediaQuery.of(context).size.width * .03,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                                context,
                                                formatInfo(MySharedPrefrence()
                                                    .get_remarks()));
                                          },
                                          child: reusablecardbtn(context, MySharedPrefrence().get_job() == 0 ? 'Open' : 'Closed', MySharedPrefrence().get_job() == 0 ? colorController.yellowColor : colorController.redColor, MySharedPrefrence().get_job() == 0 ? colorController.blackColor : colorController.whiteColor))),
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
                                fetchTuitions();
                              }),
                            );
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
              // if (isLoading)
              //   Center(child: CircularProgressIndicator(color: colorController.btnColor,)),
            ],
          ),
        ),
      ),
    );
  }
}



// class _AllTuitionsState extends State<AllTuitions> {
//   final TextEditingController _searchCon = TextEditingController();
//   List<dynamic> tuitions = [];
//   bool isLoading = false;
//   bool visible = true;
//   bool hasMoreData = true;
//   int start = 0;
//   final int limit = 10;
//   final ScrollController _scrollController = ScrollController();
//   final Color _color = colorController.yellowColor; // Initial color
//   Connectivity connectivity = Connectivity();

//   @override
//   void initState() {
//     super.initState();
//     fetchTuitions();
//     _scrollController.addListener(_scrollListener);
//   }

//   Future<void> _scrollListener() async {
//     if (_scrollController.position.pixels ==
//         _scrollController.position.maxScrollExtent && !isLoading) {
//           setState(() {
//       hasMoreData = true;
//     });
//           start += limit;
//       fetchTuitions();
//       setState(() {
//       hasMoreData = true;
//     });
//     }
//   }

//   Future<void> fetchTuitions() async {
//     // if (isLoading || !hasMoreData) return;
//     setState(() {
//       isLoading = true;
//     });
//     print('object');
//     try {
//       String url =
//           '${Utils.baseUrl}mobile_app/tuitions.php?code=10&tutor_id=${MySharedPrefrence().get_user_ID()}&start=$start&end=${limit}';
//       final response = await http.get(Uri.parse(url));
//       print(url);
//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         List<dynamic> newItems = responseData['tuition_listing'];
//         setState(() {
//           // if (newItems.length < limit) {
//           //   hasMoreData = false;
//           // }
//           // print(responseData);
//           tuitions.addAll(newItems);
//           // print(tuitions);
          
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
//       appBar: reusableappbar(context, _color),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               horizontal: MediaQuery.of(context).size.width * .032),
//           child: 
//           // Stack(
//           //   children: [
//               Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       reusableText('All Tuitions',
//                           fontsize: 25,
//                           color: colorController.blackColor,
//                           fontweight: FontWeight.bold),
//                       reusableyoutubeIcon(context),
//                     ],
//                   ),
//                   reusablaSizaBox(context, .007),
//                   Container(
//                     width: MediaQuery.of(context).size.width * 1,
//                     height: MediaQuery.of(context).size.height * .065,
//                     child: TextField(
//                       controller: _searchCon,
//                       keyboardType: TextInputType.text,
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: Colors.grey[350],
//                         hintText: 'Search Tuitions',
//                         prefixIcon: Icon(
//                           Icons.search,
//                           color: Colors.grey[270],
//                         ),
//                         hintStyle: TextStyle(color: Colors.grey[250]),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none),
//                         enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(15),
//                             borderSide: BorderSide.none),
//                         errorBorder: InputBorder.none,
//                         disabledBorder: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   reusablaSizaBox(context, .009),
//                   reusableVisiblity(context, 'Apply carefully to maintain your profile', () {
//                     setState(() {
//                       visible = false;
//                     });
//                   }, visible),
//                   reusablaSizaBox(context, .025),
//                   StreamBuilder(
//                     stream: connectivity.onConnectivityChanged,
//                     builder: (context, snapshot) {
//                       return checkConnection(
//                         snapshot,
//                         Expanded(
//                         child: ListView.builder(
//                           controller: _scrollController,
//                           itemCount: tuitions.length + (isLoading ? 1 : 0),
//                           itemBuilder: (context, index) {
//                             if (index < tuitions.length) {
//                               var data = tuitions[index];
//                               MySharedPrefrence().set_share_date(data['share_date']);
//                               MySharedPrefrence().set_tuition_name(data['tuition_name']);
//                               MySharedPrefrence().set_class_name(data['class_name']);
//                               MySharedPrefrence().set_subject(data['subject']);
//                               MySharedPrefrence().set_Placement(data['Placement']);
//                               MySharedPrefrence().set_location(data['location']);
//                               MySharedPrefrence().set_limit(data['limit_statement']);
//                               MySharedPrefrence().set_remarks(data['remarks']);
//                               return Container(
//                                 height: MediaQuery.of(context).size.height * 0.19,
//                                 child: Stack(
//                                   children: [
//                                     Positioned(
//                                       top: MediaQuery.of(context).size.height * 0.023,
//                                       left: MediaQuery.of(context).size.width * 0.001,
//                                       right: MediaQuery.of(context).size.width * .001,
//                                       child: InkWell(
//                                           onTap: () {
//                                             reusabletutorDetails(
//                                                 context,
//                                                 formatInfo(MySharedPrefrence()
//                                                     .get_remarks()));
//                                           },
//                                           child: reusablecard(context)),
//                                     ),
//                                     Positioned(
//                                         left: MediaQuery.of(context).size.width * 0.45,
//                                         top: MediaQuery.of(context).size.height * 0.005,
//                                         right: MediaQuery.of(context).size.width * .27,
//                                         child: InkWell(
//                                             onTap: () {
//                                               reusabletutorDetails(
//                                                   context,
//                                                   formatInfo(MySharedPrefrence()
//                                                       .get_remarks()));
//                                             },
//                                             child: reusablecardbtn(
//                                                 context,
//                                                 'Home',
//                                                 colorController.btnColor,
//                                                 colorController.whiteColor))),
//                                     Positioned(
//                                         left: MediaQuery.of(context).size.width * 0.72,
//                                         top: MediaQuery.of(context).size.height * 0.005,
//                                         right: MediaQuery.of(context).size.width * .03,
//                                         child: InkWell(
//                                             onTap: () {
//                                               reusabletutorDetails(
//                                                   context,
//                                                   formatInfo(MySharedPrefrence()
//                                                       .get_remarks()));
//                                             },
//                                             child: reusablecardbtn(
//                                                 context,
//                                                 'Open',
//                                                 colorController.yellowColor,
//                                                 colorController.blackColor))),
//                                   ],
//                                 ),
//                               );
//                             } else {
//                               Padding(
//                     padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .32,
//                     vertical: MediaQuery.of(context).size.height * .03
//                     ),
//                     child: reusableBtn(context, 'Load More', (){
//                       // user click this button and then call _scrollcontroller not automatic
//                     }),
//                   );
//                             }
//                           },
//                         ),
//                       )
//                       );
//                     }
//                   ),
//                 ],
//               ),
//               // if(isLoading==true)
//               // Center(child: reusableloadingrow(context, isLoading)),
//           //   ],
//           // ),
//         ),
//       ),
//     );
//   }
// }


