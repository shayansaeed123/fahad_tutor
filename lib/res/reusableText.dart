import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget reusableText(String text,
    {Color color = Colors.black54,
    double fontsize = 12,
    FontWeight fontweight = FontWeight.normal}) {
  return Text(text,
      style: TextStyle(
        color: color,
        fontSize: fontsize,
        fontWeight: fontweight,
      ));
}

reusablequlification(BuildContext context,String name,Function ontap){
  return InkWell(
    onTap: (){
      ontap();
    },
    child: Container(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * .058,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: colorController.lightblackColor,width: 1)
      ),
      child: 
      Padding(
        padding:  EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width  * .035),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: reusableText(name, fontsize: 12,color: colorController.lightblackColor,)),
            Icon(Icons.arrow_drop_down,color: colorController.lightblackColor,)
          ],
        ),
      ),
    ),
  );
}