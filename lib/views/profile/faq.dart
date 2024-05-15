

import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:fahad_tutor/res/reusableprofilewidget.dart';
import 'package:fahad_tutor/res/reusablesizebox.dart';
import 'package:flutter/cupertino.dart';

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  @override
  Widget build(BuildContext context) {
    return reusableprofileidget(
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .032),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            reusableText("FAQ's",color: colorController.blackColor,fontsize: 23,fontweight: FontWeight.bold),
            reusablaSizaBox(context, 0.020),
        //     TextField(
        //           maxLines: 5, // Set the maximum number of lines
        //           decoration: InputDecoration(
        //             label: reusableText('Feedback For App'),
        //             labelStyle: TextStyle(color: colorController.grayTextColor),
        //             border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide(
        //         color: colorController.textfieldBorderColorBefore, width: 1.5)),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide(
        //         color: colorController.textfieldBorderColorBefore, width: 1.5)),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(10),
        //     borderSide: BorderSide(
        //         color: colorController.textfieldBorderColorAfter, width: 1.5)),
        //           ),
        //     ),
        //     reusablaSizaBox(context, 0.040),
        //     reusableBtn(context, 'Submit')
          ],
        ),
      )
    );
  }
}