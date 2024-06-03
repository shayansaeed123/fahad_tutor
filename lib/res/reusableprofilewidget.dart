

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';

reusableprofileidget(Widget column,Widget widget){
  return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,),
    body: Stack(
      children: [
        SafeArea(child: SingleChildScrollView(child: column,),),
        widget
      ],
    ),
  );
}