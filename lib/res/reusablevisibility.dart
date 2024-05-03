

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget reusableVisiblity(BuildContext context,String text,Function ontap){
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .057,
    padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * .014),
    decoration: BoxDecoration(
        color: colorController.btnColor,
        borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width * .036),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reusableText(text,color: colorController.whiteColor,fontsize: 14),
          InkWell(
            onTap: (){
              ontap();
            },
            child: Icon(Icons.cancel,color: colorController.whiteColor,size: 30,)),
        ],
      ),
    )
  );
}