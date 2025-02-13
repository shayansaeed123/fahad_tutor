

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget reusablelisttile(BuildContext context,Function ontap,String image,title,{double borderWidth = .15,Widget widget = const Icon(Icons.arrow_forward_ios,)}){
  return 
    ListTile(
      onTap: (){
        ontap();
      },
    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.01), // Adjust as needed
    tileColor: Colors.grey.shade100,
    shape: Border(bottom: BorderSide(color: colorController.blackColor,width: borderWidth)),
    dense: true, 
    minVerticalPadding: 0, 
    horizontalTitleGap: 2.0, 
    leading: Image.asset(image,fit: BoxFit.contain,height: MediaQuery.of(context).size.height * .025,),
    title: reusableText(title,fontsize: 13,color: colorController.blackColor),
    trailing: widget,
  );
}