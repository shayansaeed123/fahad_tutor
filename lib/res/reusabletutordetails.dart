

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/database/MySharedPrefrence.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

reusabletutorDetails(BuildContext context, 
String details,
    ) {
  return showDialog(
    
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: colorController.whiteColor,
        title: Center(child: reusableText('${MySharedPrefrence().get_class_name()}',color: colorController.blackColor,fontsize: 17,fontweight: FontWeight.bold)),
        content: Container(
           width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height  * .5,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.2,
                child: Center(child: Positioned(child: Image.asset('assets/images/logo_1.png')))),
              Positioned(child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: reusableText('${MySharedPrefrence().get_tuition_name()} ',color: colorController.grayTextColor,fontsize: 15),
                      ),],),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [reusablecardbtn(context, 'Home', colorController.btnColor, colorController.whiteColor,width: 0.030),
                          SizedBox(width: MediaQuery.of(context).size.width * 0.010,),
                        reusablecardbtn(context, 'Open', colorController.yellowColor, colorController.blackColor,width: 0.030),],),
                      )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: reusablecardbtn(context, '${MySharedPrefrence().get_subject()}', colorController.btnColor, colorController.whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: reusableText('${MySharedPrefrence().get_share_date()}',color: colorController.blackColor,fontsize: 13.7),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: reusableText('${MySharedPrefrence().get_location()}',color: colorController.blackColor,fontsize: 13.7),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  5.0,vertical: 7.0),
                        child: reusableText('Details',color: colorController.blackColor,fontsize: 14.2),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: reusableText(details,color: colorController.grayTextColor,fontsize: 13.7),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          Center(child: reusableText('${MySharedPrefrence().get_limit()}',color: colorController.blackColor)),
          SizedBox(width: MediaQuery.of(context).size.width * .010,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) =>  colorController.btnColor),
                ),
                onPressed: () {
                  // btnontap();
                  Navigator.pop(context);
                },
                child: reusableText('Apply',color: colorController.whiteColor),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) =>  colorController.grayTextColor),
                ),
                onPressed: () {
                  // btnontap();
                  Navigator.pop(context);
                },
                child: reusableText( 'Close',color: colorController.whiteColor,)
              ),
            ],
          ),
          reusablaSizaBox(context, .01)
        ],
      ),
  );
}