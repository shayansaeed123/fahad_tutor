

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

reusableprofileInfoDialog(BuildContext context, 
// String titletxt, String contenttxt,
    // String btntxt, Function btnontap
    ) {
  return showDialog(
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Name : Shayan Saeed',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Contact No : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Alternate No : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('CNIC : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('City : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Area : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Home Address : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('DOB : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Email : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Password : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Religion : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Last Registration : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('Tutor ID : ',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          reusableText('If you want to update your basic details, email your details ',color: colorController.homeTxtColor,fontsize: 13.7,fontweight: FontWeight.bold),
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