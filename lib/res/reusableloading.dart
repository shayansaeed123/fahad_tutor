




import 'dart:ui';

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
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

