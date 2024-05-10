


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

reusableappbar(BuildContext context){
  return AppBar(
        elevation: 0.0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: reusableText("Home"),
        centerTitle: true,
        leading: 
        // Container(
          // height: MediaQuery.of(context).size.height * .001,
          // width: MediaQuery.of(context).size.width * .001,
          // decoration: BoxDecoration(
          //   color: colorController.blackColor,
          //   // borderRadius: BorderRadius.circular(50)
          //   ),
          // child: 
          CircleAvatar(
            radius: 10.0,
            backgroundColor: colorController.blackColor,
          ),
        // ),
        actions: [
          Icon(CupertinoIcons.bell_circle_fill,color: colorController.yellowColor,size: 40,),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
        ],
      );
}