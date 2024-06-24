




import 'dart:ui';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusablebtn.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';


Widget reusableloadingrow(BuildContext context, bool isLoading) {
  return isLoading == true
      ?  
        // AlertDialog(
        // // backgroundColor: Colors.transparent,
        //     title: 
        Center(
              child: 
              Lottie.asset('assets/images/lottie_anim.json',
              alignment: Alignment.center,
              animate: true,
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,height: MediaQuery.of(context).size.height *0.05,
              repeat: true,),
            )
          // )
      
      : Container();
}


void reusableloadingApply(BuildContext context, String assetPath, String message,VoidCallback onOkPressed) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Assuming reusableloadingrow is some loading animation
            Center(
                  child: 
                  Lottie.asset(assetPath,
                  alignment: Alignment.center,
                  animate: true,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.contain,height: MediaQuery.of(context).size.height *0.15,
                  repeat: true,),
                ),
            SizedBox(height: 20),
            reusableText(message, fontsize: 17,),
            SizedBox(height: 20),
            reusableBtn(context, 'Ok', (){
              Navigator.of(context).pop();
              onOkPressed();
            })
          ],
        ),
      );
    },
  );
}


reusableMessagedialog(
    BuildContext context, String titletxt,String contenttxt, String btntxt, Function btnontap, Function canceltap){
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) { 
      return Theme(
          data: ThemeData.dark().copyWith(
            dialogTheme: DialogTheme(
              backgroundColor: colorController.btnColor, // Background color of the dialog
            ),
          ),
      
      child:  AlertDialog(
      title: Center(child: reusableText(titletxt,color: colorController.whiteColor,fontsize: 16,)),
      content: reusableText(contenttxt,color: colorController.whiteColor,fontsize: 14,),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(colorController.whiteColor)),
          onPressed: () {
            btnontap();
            //             Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: ((context) => attendance())));
          },
          child: reusableText(
            btntxt,
            color: colorController.btnColor,
          ),
        ),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(colorController.grayTextColor)),
          onPressed: () {
                      canceltap();
            // Navigator.push(context, MaterialPageRoute(builder: ((context) => attendance())));
          },
          child: reusableText(
            'Cancel',
            color: colorController.whiteColor,
          ),
        ),
      ],
      )
    );
    }
  );
}

reusableAnimationdialog(
    BuildContext context, String titletxt,String contenttxt){
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) { 
      return AlertDialog(
      title: Center(child: reusableText(titletxt,color: colorController.btnColor,fontsize: 26,)),
      contentPadding: EdgeInsets.zero,
      content: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: 
                Lottie.asset('assets/images/error_lottie.json',
                alignment: Alignment.center,
                animate: true,
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,height: MediaQuery.of(context).size.height *0.15,
                repeat: true,),
              ),
            reusablaSizaBox(context, .020),
            reusableText(contenttxt,color: colorController.grayTextColor,fontsize: 14,),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(colorController.grayTextColor)),
          onPressed: () {
              Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: ((context) => attendance())));
          },
          child: reusableText(
            'Cancel',
            color: colorController.whiteColor,
          ),
        ),
      ],
      );
    }
  );
}

