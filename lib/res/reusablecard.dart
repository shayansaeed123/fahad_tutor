


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/my_shared.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget reusablecard(BuildContext context, String tuition_name, String class_name, String share_date, String location, String subject){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .16,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: colorController.whiteColor,
      border: Border.all(color: colorController.blueColor,width: 1.2)
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .05,
      vertical: MediaQuery.of(context).size.height * .005,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          reusableText('${tuition_name}',color: colorController.grayTextColor,fontsize: 15,fontweight: FontWeight.bold),
          reusablaSizaBox(context, .005),
          reusableText('${class_name}',color: colorController.blackColor,fontsize: 16,fontweight: FontWeight.bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              reusableappimage(context, .039, .05, 'assets/images/calendar_date.png'),
              reusableText(' ${share_date}',color: colorController.blackColor,fontweight: FontWeight.bold,fontsize: 12),
              SizedBox(width: MediaQuery.of(context).size.width * .09,),
              reusableappimage(context, .039, .05, 'assets/images/pin_point.png'),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * .025,
                  child: Text(' ${location}',softWrap: true,overflow: TextOverflow.ellipsis, style: TextStyle(color: colorController.blackColor,fontSize: 12,fontWeight: FontWeight.bold),)),
              ),
              // reusableText('  Lorem Lipsam IdeazShuttle Lorem',color: colorController.blackColor,fontweight: FontWeight.bold,fontsize: 12),
            ],
          ),
          reusablaSizaBox(context, .005),
          Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * .012,),
            decoration: BoxDecoration(
              color: colorController.btnColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: reusableText('${subject}',color: colorController.whiteColor,fontsize: 12,),
          ),
        ],),
      ),
    ),
  );
}