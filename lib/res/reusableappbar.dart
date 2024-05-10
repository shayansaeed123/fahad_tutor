


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
        leading: Icon(CupertinoIcons.circle_filled,color: colorController.blackColor,size: 40,),
        actions: [
          Icon(CupertinoIcons.bell_circle_fill,color: colorController.yellowColor,size: 40,),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
        ],
      );
}