

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';

reusableprofileidget(BuildContext context, Widget column,Widget widget){
  return Scaffold(
    backgroundColor: colorController.whiteColor,
    appBar: AppBar(elevation: 0,backgroundColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
      child: InkWell(
        onTap: (){Navigator.pop(context);},
        child: Image.asset('assets/images/gradient_back.png',fit: BoxFit.contain,height: MediaQuery.of(context).size.height * 0.02,)),
    ),),
    body: Stack(
      children: [
        SafeArea(child: SingleChildScrollView(child: column,),),
        widget
      ],
    ),
  );
}