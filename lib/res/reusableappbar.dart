


import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/material.dart';

reusableappbar(BuildContext context){
  return AppBar(
        elevation: 0.0,
        foregroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: reusableText("Home"),
        centerTitle: true,
        leading: Icon(Icons.ac_unit_rounded,color: Colors.black,),
        actions: [
          Icon(Icons.ac_unit_rounded,color: Colors.black,),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02,)
        ],
      );
}