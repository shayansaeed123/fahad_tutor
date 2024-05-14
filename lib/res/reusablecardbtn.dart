

import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';

Widget reusablecardbtn(BuildContext context,String text,Color color,textcolor,{double width = 0}){
  return Container(
    // width: MediaQuery.of(context).size.width * 0.45,
    // height: MediaQuery.of(context).size.height * 0.015,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(11),
      color: color,
    ),
    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.010, horizontal: MediaQuery.of(context).size.width * width),
    child: Center(child: reusableText(text,color: textcolor,fontweight: FontWeight.bold),),
  );
}