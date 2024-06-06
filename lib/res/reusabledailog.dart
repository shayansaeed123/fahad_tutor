

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

reusableprofileInfoDialog(BuildContext context, 
String titletxt, 
Function emailTap,
    // String btntxt, Function btnontap
    ) {
  return showDialog(
     
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 22,fontweight: FontWeight.bold),
      content: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: reusableText('$titletxt',color: colorController.grayTextColor,fontsize: 13.7),
          ),
          reusableText('If you want to update your basic details, email your details ',color: colorController.homeTxtColor,fontsize: 13.7,fontweight: FontWeight.bold),
           GestureDetector(
            onTap: (){
              emailTap();
            },
            child: reusableText('info@fahadtutors.com',color: colorController.arabicTextBtnColor,fontsize: 14,fontweight: FontWeight.bold)),
        ],
      ),
    ),
  );
}