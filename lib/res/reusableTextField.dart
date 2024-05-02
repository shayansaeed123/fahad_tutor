import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:flutter/material.dart';

Widget reusableTextField(BuildContext context ,TextEditingController controller,String labelText, Color color, FocusNode focusnode,
    {TextInputType keyboardType = TextInputType.text,  
    bool obscureText = false,}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    height: MediaQuery.of(context).size.height * .060,
    child: TextField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusnode,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorController.whiteColor,
        labelText: labelText,
        labelStyle: TextStyle(color: color),
        // prefixIcon: const Icon(Icons.password_outlined, color: Colors.white),
        hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        // contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      ),
    ),
  );
}
