

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/cupertino.dart';

Widget reusableVisiblity(BuildContext context){
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    height: 50,
    decoration: BoxDecoration(
        color: colorController.btnColor,
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        
      ],
    )
  );
}