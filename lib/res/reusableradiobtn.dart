import 'package:fahad_tutor/controller/color_controller.dart';
import 'package:fahad_tutor/res/reusableText.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget reusableRadioBtn(
    BuildContext context,
    String value1,
    String value2,
    String? _groupValue,
    void Function(String?)? onChanged,
    String name1,
    String name2,
    double width) {
  return Container(
    width: MediaQuery.of(context).size.width * 1,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
          children: [
            Radio<String>(
              value: value1,
              groupValue: _groupValue,
              fillColor: MaterialStateColor.resolveWith(
                              (states) => colorController.blueColor),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            activeColor: MaterialStateColor.resolveWith(
                              (states) => colorController.blueColor),
              onChanged: onChanged,
            ),
            Flexible(child: Text(name1, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),)),
          ],
                // ),
              ),
        ),
    Expanded(
      child: Row(
          children: [
            Radio<String>(
              value: value2,
              groupValue: _groupValue,
              fillColor: MaterialStateColor.resolveWith(
                              (states) => colorController.blueColor),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            activeColor: MaterialStateColor.resolveWith(
                              (states) => colorController.blueColor),
              onChanged: onChanged,
            ),
            Flexible(child: Text(name2, overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 13),)),
          ],
        // ),
      ),
    )
      ],
    ),
  );
}


