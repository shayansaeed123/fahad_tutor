

import 'package:fahad_tutor/controller/text_field_controller.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusableTextField.dart';
import 'package:flutter/cupertino.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/material.dart';

class Progressreport extends StatefulWidget {
  final String tutor_id;
  final String tuition_id;
  final String sName;
  final String className;
  final String date;
  const Progressreport({super.key,required this.tutor_id, required this.tuition_id,required this.className,required this.sName, required this.date,});

  @override
  State<Progressreport> createState() => _ProgressreportState();
}

class _ProgressreportState extends State<Progressreport> {
  late FocusNode _tname;
  late FocusNode _tCovered;
  late FocusNode _tPlan;
  late FocusNode _tRemarks;
  TutorRepository repository = TutorRepository();
  ScrollController innerController = ScrollController();
  bool isLoading = false;
  DateTime? selectedDate;
  late DateTime lastDate = DateTime(1970, 1, 1);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tname = FocusNode();
    _tname.addListener(_onFocusChange);
    _tCovered = FocusNode();
    _tCovered.addListener(_onFocusChange);
    _tPlan = FocusNode();
    _tPlan.addListener(_onFocusChange);
    _tRemarks = FocusNode();
    _tRemarks.addListener(_onFocusChange);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tname.dispose();
    _tname.removeListener(_onFocusChange);
    _tCovered.dispose();
    _tCovered.removeListener(_onFocusChange);
    _tPlan.dispose();
    _tPlan.removeListener(_onFocusChange);
    _tRemarks.dispose();
    _tRemarks.removeListener(_onFocusChange);
  }
  void _onFocusChange() {
    setState(() {
      // Redraw the UI when the focus changes
    });
  }

  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context, Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reusableText("Progress Report",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
                          Container(
                                      height: MediaQuery.sizeOf(context).height * 0.2,
                                      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015,),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorController.btnColor,style: BorderStyle.solid,width: 5),
                                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                        color: colorController.whiteColor,
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors.black.withOpacity(0.3),
                                                                        spreadRadius: 0.5,
                                                                        blurRadius: 8,
                                                                        offset: Offset(4, 6), // shadow ka direction
                                                                      ),
                                                                    ],
                                      ),
                                      child: Padding(
                                        padding:  EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.01,),
                                        child: Scrollbar(
                                          controller: innerController,
                                                                        thumbVisibility: true,
                                                                        child: ListView(
                                    controller: innerController,
                                    physics: const ClampingScrollPhysics(),
                                            children: [
                                              reusableText('Tuition Id: ${widget.tuition_id}',color: colorController.portaltextColor,fontsize: 15,),
                                              reusablaSizaBox(context, 0.01),
                                              reusableText('Student Name: ${widget.sName}',color: colorController.portaltextColor,fontsize: 15,),
                                              reusablaSizaBox(context, 0.01),
                                              reusableText('Class/Course: ${widget.className}',color: colorController.portaltextColor,fontsize: 15,),
                                              reusablaSizaBox(context, 0.01),
                                              reusableText('Joining Date: ${widget.date}',color: colorController.portaltextColor,fontsize: 15,),
                                              reusablaSizaBox(context, 0.01),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    reusableOnlinePortalDate(
                            context, lastDate, selectedDate, (DateTime timeofday){
                             setState(() {
                                            selectedDate = timeofday;
                                            print('time date $selectedDate');
                                          });
                          },
                          SizedBox.shrink(),'Date'
                          ),
                          reusablaSizaBox(context, .015),
                          reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.tName,
                                  'Teacher Name',
                                  _tname.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _tname,
                                  () {
                                    _tname.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_tCovered);
                                  },
                                  (val) => reusabletextfieldcontroller.tName.text = val,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.tCovered,
                                  'Topics Covered',
                                  _tCovered.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _tCovered,
                                  () {
                                    _tCovered.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_tPlan);
                                  },
                                  (p0) => reusabletextfieldcontroller.tCovered.text = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.tPlan,
                                  'Topics Planned',
                                  _tPlan.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _tPlan,
                                  () {
                                    _tPlan.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_tRemarks);
                                  },
                                  (p0) => reusabletextfieldcontroller.tPlan.text = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .015),
                                reusableOnlineTextField(
                                  context,
                                  reusabletextfieldcontroller.tRemarks,
                                  'Teacher Remarks',
                                  _tRemarks.hasFocus
                                      ? colorController.blueColor
                                      : colorController
                                          .textfieldBorderColorBefore,
                                  _tRemarks,
                                  () {
                                    _tRemarks.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(_tRemarks);
                                  },
                                  (p0) => reusabletextfieldcontroller.tRemarks.text = p0,
                                  // true,
                                  // 'Name is requried',
                                  keyboardType: TextInputType.text,
                                ),
                                reusablaSizaBox(context, .02),
                                reusableBtn(context, 'Update', ()async {
                                  setState(() => isLoading = true);

  try {
    await repository.updateProgressReport(
      date: selectedDate.toString(), 
      tuition_id: widget.tuition_id, 
      topic_covered: reusabletextfieldcontroller.tCovered.text, 
      topic_plan: reusabletextfieldcontroller.tPlan.text, 
      teacher_re: reusabletextfieldcontroller.tRemarks.text, 
      t_name: reusabletextfieldcontroller.tName.text, 
      tutor_id: widget.tutor_id);

    Utils.snakbarSuccess(context, 'Progress Report Updated');
    Navigator.pop(context,true);
  } catch (e) {
    Utils.snakbarSuccess(context, 'Error $e');
  }

  setState(() => isLoading = false);
                                }),
        ]
      ),
    ), reusableloadingrow(context, isLoading));
  }
}