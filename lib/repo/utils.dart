


import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Utils {


    static void fieldFocusChange(BuildContext context , FocusNode current , FocusNode  nextFocus ){
      current.unfocus();
      FocusScope.of(context).requestFocus(nextFocus);
    }


    static toastMessage(String message){
      Fluttertoast.showToast(
          msg: message ,
        backgroundColor: colorController.redColor ,
        textColor: colorController.whiteColor,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,


      );
    }


    static toastMessageCenter(String message){
      Fluttertoast.showToast(
        msg: message ,
        backgroundColor: colorController.blackColor ,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_LONG,
        textColor: colorController.whiteColor,
      );
    }

    static snackBar(String title, String message){
      Get.snackbar(
          title,
          message ,
          backgroundColor: colorController.redColor,
          borderRadius: 11,
          colorText: colorController.blackColor,
          duration: Duration(seconds: 3),
      );
    }
}