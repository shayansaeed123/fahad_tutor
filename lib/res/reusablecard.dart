


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableappimage.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget reusablecard(BuildContext context){
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
      vertical: MediaQuery.of(context).size.height * .012,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        reusableText('T55708',color: colorController.grayTextColor,fontsize: 15,fontweight: FontWeight.bold),
        reusablaSizaBox(context, .005),
        reusableText('Classes/Course: Olevel-1',color: colorController.blackColor,fontsize: 17,fontweight: FontWeight.bold),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            reusableappimage(context, .0, .0, 'assets/images/calendar_date.png'),
          ],
        ),
      ],),
    ),
  );
}