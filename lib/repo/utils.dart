import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static const String baseUrl = 'https://fahadtutors.com/mobile_app/';

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: colorController.redColor,
      textColor: colorController.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static snakbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.redColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      content: reusableText(message, color: colorController.whiteColor),
    ));
  }

  static snakbarSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.yellowColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 6),
      content: reusableText(message, color: colorController.btnColor),
    ));
  }

  static snakbarFailed(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colorController.redColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 6),
      content: reusableText(message, color: colorController.whiteColor),
    ));
  }

  static toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: colorController.blackColor,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      textColor: colorController.whiteColor,
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: colorController.redColor,
      borderRadius: 11,
      colorText: colorController.blackColor,
      duration: Duration(seconds: 3),
    );
  }

  static launchWhatsApp(BuildContext context,) async {
    final whatsappNumber = "+923158729060"; // Replace with your WhatsApp number
    final whatsappUrl = "https://wa.me/$whatsappNumber";
    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("WhatsApp is not installed."),
        ),
      );
    }
  }
}
