

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:fahad_tutor/views/login/login.dart';
import 'package:fahad_tutor/views/profile/online/meetinginfo.dart';
import 'package:fahad_tutor/views/profile/online/progressreport.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Onlineportal extends StatefulWidget {
  const Onlineportal({super.key});

  @override
  State<Onlineportal> createState() => _OnlineportalState();
}

class _OnlineportalState extends State<Onlineportal> {
  bool isLoading = false;
  ScrollController innerController = ScrollController();
  TutorRepository repository = TutorRepository();
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context, Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MySharedPrefrence().get_application_type() == 1 ? reusableText("Online Portal",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold) 
          : InkWell(
            onTap: (){
              MySharedPrefrence().logout();
                  // loginClear();
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),));
            },
            child: reusableText("Logout",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold)),
                          reusablaSizaBox(context, 0.020),
                          FutureBuilder(
                            future: repository.fetchOnlinePortalListing(), 
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                      return const Center(child: CircularProgressIndicator());
                                    }  else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                      return const Center(child: Text("No Listng found"));
                                    }
                                    final meetings = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: meetings.length,
                                      itemBuilder: (context, index) {
                                      final meeting = meetings[index];
                                      return Container(
                                      height: MediaQuery.sizeOf(context).height * 0.39,
                                      margin: EdgeInsets.all(MediaQuery.sizeOf(context).height * 0.015,),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: colorController.btnColor,style: BorderStyle.solid,width: 5),
                                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                                        color: colorController.whiteColor,
                                                                    //           gradient: LinearGradient(
                                                                    //   colors: [
                                                                    //     colorController.itemsBtnColor,
                                                                    //     colorController.whiteColor,
                                                                    //   ],
                                                                    //   begin: Alignment.topCenter,
                                                                    //   end: Alignment.bottomCenter,
                                                                    // ),
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
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: reusableText('Tuition id: ${meeting.clientId}',color: colorController.portaltextColor,fontsize: 15,)),
                                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                                                  // Expanded(child: reusableText('Invoice Date : invoiceDate',color: colorController.whiteColor,fontsize: 15,)),
                                                  Expanded(child: reusablecardbtn(context, '👨‍💻 Join Room', colorController.btnColor, colorController.whiteColor))
                                                ],
                                              ),
                                              reusablaSizaBox(context, 0.01),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: reusableText('Class: ${meeting.className}',color: colorController.portaltextColor,fontsize: 15,)),
                                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                                                  Expanded(child: reusableText('Subject: ${meeting.subjects}',color: colorController.portaltextColor,fontsize: 15,)),
                                                ],
                                              ),
                                              reusablaSizaBox(context, 0.01),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: reusableText('Date: ${meeting.datetime}',color: colorController.portaltextColor,fontsize: 15,)),
                                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                                                  Expanded(child: reusableText('🏠: ${meeting.clientName}|${meeting.areaName}',color: colorController.portaltextColor,fontsize: 15,)),
                                                ],
                                              ),
                                              // reusablaSizaBox(context, 0.01),
                                              Row(
                                                children: [
                                                  reusableText('HostKey: ${meeting.meetingHostkey}',color: colorController.portaltextColor,fontsize: 15,),
                                                  copybutton(context, meeting.meetingHostkey, 'HostKey')
                                                ],
                                              ),
                                              // reusablaSizaBox(context, 0.01),
                                              Row(
                                                children: [
                                                  
                                              reusableText('Meeting Id: ${meeting.meetingId}',color: colorController.portaltextColor,fontsize: 15,),
                                              copybutton(context, meeting.meetingId, 'Meeting Id')
                                                ],
                                              ),
                                              // reusablaSizaBox(context, 0.01),
                                              Row(
                                                children: [
                                                  reusableText('Meeting Passcode: ${meeting.meetingPassword}',color: colorController.portaltextColor,fontsize: 15,),
                                                  copybutton(context, meeting.meetingPassword, 'Meeting Pass')
                                                ],
                                              ),
                                              // reusablaSizaBox(context, 0.015),
                                              MySharedPrefrence().get_application_type() == 1 ? Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(child: InkWell(
                                                    onTap: ()async{
                                                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => MeetingInfo(id: meeting.id,zoomLink: meeting.zoomLink,meetingid: meeting.meetingId,meetingpass: meeting.meetingPassword,meetinghost: meeting.meetingHostkey,),));
                                                      if (result == true) {setState(() {});}
                                                      },
                                                    child: reusablecardbtn(context, 'ℹ️ Meeting Info', colorController.btnColor, colorController.whiteColor))),
                                                  SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                                                  // Expanded(child: reusableText('Invoice Date : invoiceDate',color: colorController.whiteColor,fontsize: 15,)),
                                                  Expanded(child: InkWell(
                                                    onTap: ()async{
                                                      final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => Progressreport(tutor_id: meeting.tutorId, tuition_id: meeting.clientId,sName: meeting.clientName,className: meeting.className,date: meeting.datetime),));
                                                      if (result == true) {setState(() {});}
                                                    },
                                                    child: reusablecardbtn(context, '📊 Daily Progress', colorController.btnColor, colorController.whiteColor)))
                                                ],
                                              ) : SizedBox.shrink(),
                                              reusablaSizaBox(context, 0.015),
                                              reusableBtn(context, 'Chat', (){
                                                // ontap();
                                              },width: 0.45)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ); 
                                    },);
                            },)
          
        ],
      ),
    ), reusableloadingrow(context, isLoading));
  }
}