

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/material.dart';

reusableprofileInfoDialog(BuildContext context, 
// String titletxt, String contenttxt,
    // String btntxt, Function btnontap
    ) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 17,fontweight: FontWeight.bold),
      content: Column(
        children: [
          reusableText('Name : ',color: colorController.grayTextColor,),
          reusableText('Contact No : ',color: colorController.grayTextColor,),
          reusableText('Alternate No : ',color: colorController.grayTextColor,),
          reusableText('CNIC : ',color: colorController.grayTextColor,),
          reusableText('City : ',color: colorController.grayTextColor,),
          reusableText('Area : ',color: colorController.grayTextColor,),
          reusableText('Home Address : ',color: colorController.grayTextColor,),
          reusableText('DOB : ',color: colorController.grayTextColor,),
          reusableText('Email : ',color: colorController.grayTextColor,),
          reusableText('Password : ',color: colorController.grayTextColor,),
          reusableText('Religion : ',color: colorController.grayTextColor,),
          reusableText('Last Registration : ',color: colorController.grayTextColor,),
          reusableText('Tutor ID : ',color: colorController.grayTextColor,),
        ],
      ),
      // actions: [
      //   ElevatedButton(
      //     onPressed: () {
      //       btnontap();
      //       Navigator.pop(context);
      //     },
      //     child: Text(btntxt),
      //   ),
      // ],
    ),
  );
}