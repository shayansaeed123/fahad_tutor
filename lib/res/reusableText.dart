

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget reusableText(String text,{Color color = Colors.black54,double fontsize = 12, FontWeight fontweight = FontWeight.normal}){
  return Text(text, style: TextStyle(color: color,fontSize: fontsize,fontWeight: fontweight,));
}