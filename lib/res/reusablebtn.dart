import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:flutter/material.dart';

Widget reusableBtn(
  BuildContext context,
  String btnText,
  Function onValidTap,
  {double width = 1}
) {
  return 
  GestureDetector(
    onTap: (){
      onValidTap();
    },
    child: 
    Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * .055,
      decoration: BoxDecoration(
          color: colorController.btnColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        btnText,
        style: TextStyle(color: colorController.whiteColor, fontSize: 18),
      )),
    ),
  );
}

Widget reusablewhite(
  BuildContext context,
  String btnText,
  Function onValidTap,
  {double width = 1}
) {
  return 
  GestureDetector(
    onTap: (){
      onValidTap();
    },
    child: 
    Container(
      width: MediaQuery.of(context).size.width * width,
      height: MediaQuery.of(context).size.height * .055,
      decoration: BoxDecoration(
          color: colorController.whiteColor,
          borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        btnText,
        style: TextStyle(color: colorController.btnColor, fontSize: 18),
      )),
    ),
  );
}
