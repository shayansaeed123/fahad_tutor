import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/material.dart';

Widget reusablaSizaBox(BuildContext context, double size) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * size,
  );
}

Widget buildCheckboxWithTitle(String title, bool value,Function ontap,){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          shape: ContinuousRectangleBorder(),
          overlayColor: MaterialStatePropertyAll(colorController.blueColor),
          activeColor: colorController.blueColor,
          side: BorderSide(color: colorController.blueColor, width: 1.5),
          value: value,
          onChanged: (newValue) {
            ontap();
            // setState(() {
            //   if (title == 'Home') {
            //     checkbox1 = newValue ?? false;
            //     ontap();
            //   } else if (title == 'Online') {
            //     checkbox2 = value ?? false;
            //     if (value == true) {
            //       isHomeWidgetVisible = true;
            //       updateTutorPlacement();
            //        print(selectedPlacements);
            //     } else {
            //       updateTutorPlacement();
            //        print(selectedPlacements);
            //       isHomeWidgetVisible = false;
            //     }
            //   } else if (title == "At Tutor's Place") {
            //     checkbox3 = value ?? false;
            //     updateTutorPlacement();
            //      print(selectedPlacements);
            //   }
            // });
          },
        ),
        reusableText(title, fontsize: 15),
      ],
    );
  }
