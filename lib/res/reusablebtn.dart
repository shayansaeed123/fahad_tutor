

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';

Widget reusableBtn(BuildContext context,String btnText,){
  return Container( 
    width: MediaQuery.of(context).size.width * 1,
    height: 50,
    decoration: BoxDecoration(
      color: colorController.btnColor,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Center(child: Text(btnText,style: TextStyle(color: colorController.whiteColor,fontSize: 18),)),
  );
}