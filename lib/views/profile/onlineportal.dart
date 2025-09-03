

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusableloading.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
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
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(context, Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .032),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reusableText("Online Portal",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
                          reusablaSizaBox(context, 0.020),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.39,
            decoration: BoxDecoration(
              border: Border.all(color: colorController.btnColor,style: BorderStyle.solid,width: 5),
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              color: colorController.itemsBtnColor,
              gradient: LinearGradient(
      colors: [
        colorController.itemsBtnColor,
        colorController.whiteColor,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
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
                        Expanded(child: reusableText('Tuition id: 12345',color: colorController.whiteColor,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        // Expanded(child: reusableText('Invoice Date : invoiceDate',color: colorController.whiteColor,fontsize: 15,)),
                        Expanded(child: reusablecardbtn(context, 'Join Room', colorController.btnColor, colorController.whiteColor))
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusableText('Class: reqFor',color: colorController.whiteColor,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        Expanded(child: reusableText('Subject: Address',color: colorController.whiteColor,fontsize: 15,)),
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusableText('Date: 12/01/2025',color: colorController.whiteColor,fontsize: 15,)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        Expanded(child: reusableText('🏠: online',color: colorController.whiteColor,fontsize: 15,)),
                      ],
                    ),
                    reusablaSizaBox(context, 0.01),
                    reusableText('HostKey: model',color: colorController.whiteColor,fontsize: 15,),
                    reusablaSizaBox(context, 0.01),
                    reusableText('Meeting Id: model',color: colorController.whiteColor,fontsize: 15,),
                    reusablaSizaBox(context, 0.01),
                    reusableText('Meeting Passcode: model',color: colorController.whiteColor,fontsize: 15,),
                    reusablaSizaBox(context, 0.015),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: reusablecardbtn(context, 'Meeting Info', colorController.btnColor, colorController.whiteColor)),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.03,),
                        // Expanded(child: reusableText('Invoice Date : invoiceDate',color: colorController.whiteColor,fontsize: 15,)),
                        Expanded(child: reusablecardbtn(context, 'Daily Progress', colorController.btnColor, colorController.whiteColor))
                      ],
                    ),
                    reusablaSizaBox(context, 0.015),
                    reusableBtn(context, 'Chat', (){
                      // ontap();
                    },width: 0.45)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ), reusableloadingrow(context, isLoading));
  }
}