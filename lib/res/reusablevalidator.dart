import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/repo/utils.dart';
import 'package:fahad_tutor/res/reusablevalidator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget reusableContactField(
  BuildContext context,
  TextEditingController controller,
  String labelText,
  Color color,
  FocusNode focusnode,
  Function onsubmit,
  int numberLength,
  // bool validate_or_not,
  // String message,
  // String message2,
   {
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
}) {
  return Container(
    // margin: EdgeInsets.only(bottom: 10),
    width: MediaQuery.of(context).size.width * 1,
    // height: MediaQuery.of(context).size.height * .060,
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      focusNode: focusnode,
      onFieldSubmitted: (value) {
                              onsubmit();
                            },
                            inputFormatters: [
                  LengthLimitingTextInputFormatter(numberLength),
                  FilteringTextInputFormatter.digitsOnly,
                ],
      // validator: (value) {
      //   if (validate_or_not) {
      //     if (value!.isEmpty) {
      //        Utils.snakbar(context,message);
      //     }
      //     if (!value.startsWith('03') || value.length != 11) {
      //               return Utils.toastMessage(message2);
      //             }
      //     return null;
      //   }
      // },
                            
                          
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
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorBefore, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: colorController.textfieldBorderColorAfter, width: 1.5)),
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10),
      ),
    ),
  );
}




// Widget reusableTextField(
//   BuildContext context,
//   TextEditingController controller,
//   String labelText,
//   Color color,
//   FocusNode focusNode,
//   Function onSubmit,
//   bool validate_or_not,
//   String message,
//   // Function validator,
//    {
//   TextInputType keyboardType = TextInputType.text,
//   bool obscureText = false,
// }) {
//   return Container(
//     width: MediaQuery.of(context).size.width * 1,
//     height: MediaQuery.of(context).size.height * .060,
//     child: TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       focusNode: focusNode,
//       onFieldSubmitted: (value) {
//         onSubmit();
//       },
//        validator: (value) {
//         if (validate_or_not == true) {
//           if (value!.isEmpty) {
//             return message;
//           }
//           return null;
//         }
//       },

//       obscureText: obscureText,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: colorController.whiteColor,
//         labelText: labelText,
//         labelStyle: TextStyle(color: color),
//         hintStyle: TextStyle(color: colorController.textfieldBorderColorBefore),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorBefore,
//             width: 1.5,
//           ),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorBefore,
//             width: 1.5,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide(
//             color: colorController.textfieldBorderColorAfter,
//             width: 1.5,
//           ),
//         ),
//         errorBorder: InputBorder.none,
//         disabledBorder: InputBorder.none,
//       ),
//     ),
//   );
// }
