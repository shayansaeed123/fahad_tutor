import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/check_connectivity.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
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
import 'package:fahad_tutor/views/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ViewTuitions extends StatefulWidget {
  const ViewTuitions({super.key});

  @override
  State<ViewTuitions> createState() => _ViewTuitionsState();
}

class _ViewTuitionsState extends State<ViewTuitions> {
  TutorRepository repository = TutorRepository();
  final ScrollController _scrollController = ScrollController();
  Connectivity connectivity = Connectivity();

  bool visible = true;
  bool isLoading = false;
  int start = 0;
  int limit = 10;
  List<dynamic> tuitions = [];

  String formatInfo(String info) {
    return info.replaceAll(';', '\n');
  }

  @override
  void initState() {
    super.initState();
    fetchInitialTuitions();
    repository.documentsAttach();
  }

  Future<void> fetchInitialTuitions() async {
    await repository.fetchTuitions(start, limit);
    setState(() {
      tuitions = repository.listResponse;
    });
  }

  Future<void> loadMoreTuitions() async {
    setState(() {
      isLoading = true;
    });
    start += limit;
    await repository.fetchTuitions(start, limit);
    setState(() {
      tuitions = repository.listResponse;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorController.whiteColor,
      appBar: reusableappbar(context, colorController.yellowColor,(){},repository.profile_image,(){}),
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
                  controller: reusabletextfieldcontroller.searchConAll,
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
                  )
                ),
              ),
              reusablaSizaBox(context, .009),
              reusableVisiblityMesage(context,
                  'Apply carefully to maintain your profile', () {
                setState(() {
                  visible = false;
                });
              }, visible),
              reusablaSizaBox(context, .025),
              StreamBuilder<ConnectivityResult>(
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
                            print('ClassName ${data['class_name']}');
                            MySharedPrefrence().setViewTuitions(data);
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.23, //19 to 23
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: MediaQuery.of(context).size.height *
                                        0.023,
                                    left: MediaQuery.of(context).size.width *
                                        0.001,
                                    right: MediaQuery.of(context).size.width *
                                        .001,
                                    child: InkWell(
                                        onTap: () {
                                          reusabletutorDetails(
                                            context,
                                            formatInfo(data['remarks']),
                                            data['class_name'],
                                            data['tuition_name'],
                                            data['Placement'],
                                            data['job_closed'],
                                            data['subject'],
                                            data['share_date'],
                                            data['location'],
                                            data['limit_statement'],
                                            (){reusableMessagedialog(context, 'Login', 'Please Login to Apply for Tuition', 'Login','Cancel', (){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);
                                            }, (){Navigator.pop(context);});},
                                            data['group_id'],
                                            data['tuition_id'],
                                            data['already'],() {
                                                setState(() {
                                                  data['already'] = 1;
                                                });
                                              }
                                          );
                                        },
                                        child: reusablecard(
                                            context,
                                            data['tuition_name'],
                                            data['class_name'],
                                            data['share_date'],
                                            data['location'],
                                            data['subject'],
                                            0,
                                            )),
                                  ),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.45,
                                      top: MediaQuery.of(context).size.height *
                                          0.005,
                                      right: MediaQuery.of(context).size.width *
                                          .27,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                              context,
                                              formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],
                                              (){reusableMessagedialog(context, 'Login', 'Please Login to Apply for Tuition', 'Login', 'Cancel',(){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);
                                            }, (){Navigator.pop(context);});},
                                              data['group_id'],
                                              data['tuition_id'],
                                              data['already'],() {
                                                setState(() {
                                                  data['already'] = 1;
                                                });
                                              }
                                            );
                                          },
                                          child: reusablecardbtn(
                                              context,
                                              '${data['Placement']}',
                                              colorController.btnColor,
                                              colorController.whiteColor))),
                                  Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.72,
                                      top: MediaQuery.of(context).size.height *
                                          0.005,
                                      right: MediaQuery.of(context).size.width *
                                          .03,
                                      child: InkWell(
                                          onTap: () {
                                            reusabletutorDetails(
                                              context,
                                              formatInfo(data['remarks']),
                                              data['class_name'],
                                              data['tuition_name'],
                                              data['Placement'],
                                              data['job_closed'],
                                              data['subject'],
                                              data['share_date'],
                                              data['location'],
                                              data['limit_statement'],
                                              (){reusableMessagedialog(context, 'Login', 'Please Login to Apply for Tuition', 'Login','Cancel', (){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login()),);
                                            }, (){Navigator.pop(context);});},
                                              data['group_id'],
                                              data['tuition_id'],
                                              data['already'],() {
                                                setState(() {
                                                  data['already'] = 1;
                                                });
                                              }
                                            );
                                          },
                                          child: reusablecardbtn(
                                              context,
                                              data['job_closed'] == 0
                                                  ? 'Open'
                                                  : 'Closed',
                                              data['job_closed'] == 0
                                                  ? colorController.yellowColor
                                                  : colorController.redColor,
                                              data['job_closed'] == 0
                                                  ? colorController.blackColor
                                                  : colorController.whiteColor))),
                                ],
                              ),
                            );
                          } else {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .32,
                                vertical:
                                    MediaQuery.of(context).size.height * .03,
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
    );
  }
}
