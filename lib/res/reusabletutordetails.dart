

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablecardbtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

reusabletutorDetails(BuildContext context, 
// String titletxt, String contenttxt,
    // String btntxt, Function btnontap
    ) {
  return showDialog(
    
    context: context,
    builder: (context) => AlertDialog(
        backgroundColor: colorController.whiteColor,
        title: Center(child: reusableText('Class/Course: ',color: colorController.blackColor,fontsize: 17,fontweight: FontWeight.bold)),
        content: Container(
           width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height  * .5,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.2,
                child: Center(child: Positioned(child: Image.asset('assets/images/logo_1.png')))),
              Positioned(child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: reusableText('T55708 ',color: colorController.grayTextColor,fontsize: 15),
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
                        child: reusablecardbtn(context, 'All Subject', colorController.btnColor, colorController.whiteColor,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: reusableText('May-04-2024',color: colorController.blackColor,fontsize: 13.7),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: reusableText('Lorem Lipsam IdeazShuttle Loremfkgjlfdgfbgfg',color: colorController.blackColor,fontsize: 13.7),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:  5.0,vertical: 7.0),
                        child: reusableText('Details',color: colorController.blackColor,fontsize: 14.2),
                      ),
                      reusableText('City : ',color: colorController.grayTextColor,fontsize: 13.7),
                      reusableText('Area : ',color: colorController.grayTextColor,fontsize: 13.7),
                      reusableText('Home Address : ',color: colorController.grayTextColor,fontsize: 13.7),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7.0),
                        child: reusableText('Home-Tuition',color: colorController.grayTextColor,fontsize: 13.7),
                      ),
                      reusableText('Addresss',color: colorController.grayTextColor,fontsize: 13.7),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: reusableText('Password : ',color: colorController.grayTextColor,fontsize: 13.7),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: reusableText('Religion : ',color: colorController.grayTextColor,fontsize: 13.7),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: reusableText('Last Registration : ',color: colorController.grayTextColor,fontsize: 13.7),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: reusableText('Tutor ID : ',color: colorController.grayTextColor,fontsize: 13.7),
                      // ),
                      // reusableText('If you want to update your basic details, email your details ',color: colorController.homeTxtColor,fontsize: 13.7,fontweight: FontWeight.bold),
                    ],
                  ),
                ),
            ],
          ),
        ),
        actions: [
          Center(child: reusableText('You can attemptfor three tuitions in 24 hours.',color: colorController.blackColor)),
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