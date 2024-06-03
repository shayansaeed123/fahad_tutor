

import 'package:dotted_border/dotted_border.dart';
import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

reusableDocuments(BuildContext context,String add1,String add2,String add3, String title1,String title2,String image1, String image2, String image3, Function ontap1,Function ontap2,Function ontap3){
  return  
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        reusableText(title1, fontsize: 20,color: colorController.blackColor,fontweight: FontWeight.bold),
        reusablaSizaBox(context, .030),
        DottedBorder(
          color: colorController.blackColor,
            strokeWidth: 2,
            dashPattern: [6, 3],
            radius: Radius.circular(15),
            child:  reusableSelectImage1(context, (){ontap1();}, image1)
        ),
        reusablaSizaBox(context, .010),
        reusableText(add1, color: colorController.btnColor,fontsize: 15),
        reusablaSizaBox(context, .030),
        reusableText(title2, fontsize: 20,color: colorController.blackColor,fontweight: FontWeight.bold),
        reusablaSizaBox(context, .030),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage2(context, (){ontap2();}, image2)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add2, color: colorController.btnColor,fontsize: 15),
              ],
            ),
            Column(
              children: [
                DottedBorder(
                  color: colorController.blackColor,
                    strokeWidth: 2,
                    dashPattern: [6, 3],
                    radius: Radius.circular(15),
                    child:  reusableSelectImage2(context, (){ontap3();}, image3)
                ),
                reusablaSizaBox(context, .010),
                reusableText(add3, color: colorController.btnColor,fontsize: 15),
              ],
            ),
          ],
        ),
      ]
    );
  // );
}

reusableSelectImage1(BuildContext context,Function ontap,String image){
  return InkWell(
            onTap: (){ontap();},
            child: Container(
              width: MediaQuery.of(context).size.width * .43,
              height: MediaQuery.of(context).size.height * .18,
              decoration: BoxDecoration(
                color: colorController.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .013,),
                child: Center(child: image == '' ? Image.asset('assets/images/add_img_placeholder.png',fit: BoxFit.contain,)
                : CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.4,
                  backgroundImage: NetworkImage(image),
                  backgroundColor: colorController.blackColor,
                  // child: Image.network(image,fit: BoxFit.contain,)
                  )),
              ),
            ),
          );
}

reusableSelectImage2(BuildContext context,Function ontap,String image){
  return InkWell(
            onTap: (){ontap();},
            child: Container(
              width: MediaQuery.of(context).size.width * .43,
              height: MediaQuery.of(context).size.height * .18,
              decoration: BoxDecoration(
                color: colorController.whiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * .013,),
                child: Center(child: image == '' ? Image.asset('assets/images/add_img_placeholder.png',fit: BoxFit.contain,)
                : Image.network(image,fit: BoxFit.contain,)
                  ),
              ),
            ),
          );
}