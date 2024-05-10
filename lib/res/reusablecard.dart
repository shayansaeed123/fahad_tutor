


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget reusablecard(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * .16,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      color: colorController.whiteColor,
      border: Border.all(color: colorController.blueColor,width: 1.2)
    ),
    child: Column(children: [
      
    ],),
  );
}