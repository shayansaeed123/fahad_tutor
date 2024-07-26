

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

reusableprofileInfoDialog(BuildContext context, 
String titletxt, 
Function emailTap,
    // String btntxt, Function btnontap
    ) {
  return showDialog(
     barrierColor: Colors.black.withOpacity(0.7),
    context: context,
    builder: (context) => CupertinoAlertDialog(
      title: reusableText('Tutor Basic Information',color: colorController.blackColor,fontsize: 19,fontweight: FontWeight.bold),
      content: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          reusablaSizaBox(context, 0.01),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Text('$titletxt',textAlign: TextAlign.start,
            style: TextStyle(color: colorController.lightblackColor,fontSize: 12.7,letterSpacing: 0.5,height: 1.7),)
            // reusableText('$titletxt',color: colorController.lightblackColor,fontsize: 12.7),
          ),
          reusableText('If you want to update your basic details, email your details ',color: colorController.redColor,fontsize: 12.7,fontweight: FontWeight.bold),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  emailTap();
                },
                child: reusableText('info@fahadtutors.com',color: colorController.arabicTextBtnColor,fontsize: 12.7,fontweight: FontWeight.bold)),
            ],
          )
        ],
      ),
    ),
  );
}